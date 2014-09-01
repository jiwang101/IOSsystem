//
//  WaitDoListViewController.m
//  zqyOA
//
//  Created by daoyi on 14-8-25.
//  Copyright (c) 2014年 daoyi. All rights reserved.
//

#import "WaitDoListViewController.h"
#import "DocItem.h"
#import "WaitDoCell.h"
#import <EGORefreshTableHeaderView.h>
#import <LoadMoreTableFooterView.h>

@interface WaitDoListViewController ()<EGORefreshTableHeaderDelegate,LoadMoreTableFooterDelegate>{
    NSInteger _pageTotal;
    NSInteger _pageNo;
    
    EGORefreshTableHeaderView *egoRefreshTableHeaderView;
    BOOL isRefreshing;
    LoadMoreTableFooterView *loadMoreTableFooterView;
    BOOL isLoadMoreing;
}
@property (nonatomic,strong) NSMutableArray *listData;
@end

@implementation WaitDoListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"待办列表";
        _pageNo = 1;
        self.listData = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    isRefreshing = NO;
    if (egoRefreshTableHeaderView == nil)
    {
        egoRefreshTableHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, -60.0f, self.listTableView.frame.size.width, 60 )];
        egoRefreshTableHeaderView.delegate = self;
        [self.listTableView addSubview:egoRefreshTableHeaderView];
    }
    [egoRefreshTableHeaderView refreshLastUpdatedDate];
    if (loadMoreTableFooterView == nil)
    {
        loadMoreTableFooterView = [[LoadMoreTableFooterView alloc] initWithFrame:CGRectMake(0.0f, 0, self.listTableView.frame.size.width, 60)];
        loadMoreTableFooterView.delegate = self;
        self.listTableView.tableFooterView = loadMoreTableFooterView;
    }
    [MMProgressHUD showWithStatus:LString(@"Loading")];
    [self reloadData];
    
}
- (void)reloadData
{
    
    [self.dataExchangeMgr getWaitDoDocList_loginName:self.manage.userItem.loginName
                                              pageNo:_pageNo
                                            pageSize:kPageSize
                                                type:1
                                               title:@""];
}
#pragma mark - TableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identerCell = @"waitDo";
    WaitDoCell *cell = [tableView dequeueReusableCellWithIdentifier:identerCell];
    if (!cell) {
        cell = [[WaitDoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identerCell];
    }
    DocItem *item = [self.listData objectAtIndex:indexPath.row];
    cell.textLabel.text = item.docTitle;
    return cell;
}
#pragma mark UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [egoRefreshTableHeaderView egoRefreshScrollViewDidScroll:scrollView];
    [loadMoreTableFooterView loadMoreScrollViewDidScroll:scrollView];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [egoRefreshTableHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    [loadMoreTableFooterView loadMoreScrollViewDidEndDragging:scrollView];
}
#pragma mark EGORefreshTableHeaderDelegate Methods
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
    isRefreshing = YES;
    _pageNo = 1;
    [self reloadData];
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
    return isRefreshing;
}
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
    return [NSDate date];
}
#pragma mark LoadMoreTableFooterDelegate Methods
- (void)loadMoreTableFooterDidTriggerLoadMore:(LoadMoreTableFooterView*)view
{
    _pageNo += 1;
    if (_pageNo <= _pageTotal) {
        isLoadMoreing = YES;
        [self reloadData];
    }else{
        self.listTableView.tableFooterView = nil;
    }
}
- (BOOL)loadMoreTableFooterDataSourceIsLoading:(LoadMoreTableFooterView*)view
{
    return isLoadMoreing;
}
#pragma mark - DataExchangeManagerDelegate
-(void)dataExchangeFinishWith:(HttpRequest *)request{
    if (![request error]) {
        NSString *respString = [request responseString];
        //如果是json
        NSDictionary *dict = [respString objectFromJSONString];
        if ([dict isKindOfClass:[NSDictionary class]]) {
            NSNumber *result =(NSNumber *)[dict objectForKey:@"result"];
            _pageTotal = [[dict objectForKey:@"page_count"] integerValue];
            if(result && result.integerValue == 1) {
                //如果是首次加载 清空数据
                if (_pageNo == 1) {
                    [self.listData removeAllObjects];
                }
                if (request.requestType == RT_getWaitDoDocList) {
                    for (NSDictionary *dic in [dict objectForKey:@"data"]) {
                        DocItem *item = [[DocItem alloc] initWithDict:dic];
                        [self.listData addObject:item];
                    }
                    [self.listTableView reloadData];
                }
            }else{
                [MMProgressHUD dismissWithError:[dict objectForKey:@"desc"] afterDelay:2.0f];
            }
        }
        else{
            [MMProgressHUD dismissWithError:LString(@"DataFormatError") afterDelay:2.0f];
        }
        

        
        
    }else{
        [MMProgressHUD dismissWithError:LString(@"ServerUnavailable") afterDelay:2.0f];
    }
    
    isRefreshing = NO;
    [egoRefreshTableHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.listTableView];
    isLoadMoreing = NO;
    [loadMoreTableFooterView loadMoreScrollViewDataSourceDidFinishedLoading:self.listTableView];
}
-(void)dataExchangeFailedWith:(HttpRequest *)request{
    [MMProgressHUD dismissWithError:LString(@"NetworkBroken") afterDelay:2.0f];
    
    isRefreshing = NO;
    [egoRefreshTableHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.listTableView];
    isLoadMoreing = NO;
    [loadMoreTableFooterView loadMoreScrollViewDataSourceDidFinishedLoading:self.listTableView];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
