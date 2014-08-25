//
//  SelectUnitsViewController.m
//  zqyOA
//
//  Created by daoyi on 14-8-6.
//  Copyright (c) 2014年 daoyi. All rights reserved.
//

#import "SelectUnitsViewController.h"
#import <MMProgressHUD.h>
#import <JSONKit.h>
#import "UnitItem.h"
#import "BaseCell.h"
#import "EGORefreshTableHeaderView.h"

@interface SelectUnitsViewController ()<EGORefreshTableHeaderDelegate>{
    BOOL _isRefreshing;
}
@property (nonatomic,strong) NSMutableArray *unitList;
@property (nonatomic,strong) NSMutableArray *unitTableList;
@property (nonatomic,strong) EGORefreshTableHeaderView *downEGO;
//@property (nonatomic,strong) EGORefreshTableHeaderView *upEGO;

@end

@implementation SelectUnitsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"选择单位";
        self.unitList = [NSMutableArray array];
        self.unitTableList = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [MMProgressHUD showWithStatus:LString(@"Loading")];
    [self.dataExchangeMgr getUnitList];
    
    //tableview透明与分隔线
    self.unitTableView.backgroundColor = [UIColor clearColor];
    self.unitTableView.backgroundView = nil;
    self.unitTableView.separatorColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"line_B00_2"]];
    
    //利用tableview的头部改成搜索框
    UIView *tableViewSearchVC = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.unitTableView.frame.size.width, 60)];
    tableViewSearchVC.backgroundColor = [UIColor lightGrayColor];
    
    UITextField *inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, tableViewSearchVC.frame.size.width-10*2, 36)];
    inputTextField.placeholder = @"请输入单位名称或者拼音字母";
    inputTextField.delegate = self;
    inputTextField.background = [[UIImage imageNamed:@"searchBg1724x72_B00_2"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 20, 10, 20)];
    inputTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    inputTextField.returnKeyType = UIReturnKeySearch;
    inputTextField.font = [UIFont systemFontOfSize:18.0];
    inputTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    inputTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [inputTextField addTarget:self action:@selector(searchUnit:) forControlEvents:UIControlEventEditingChanged];
    
    UIButton *inputLeftButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 15, 30, 30)];
    [inputLeftButton setImage:[UIImage imageNamed:@"LookingGlass_B00_2"] forState:UIControlStateNormal];
//    [inputLeftButton addTarget:self action:@selector(searchUnit:) forControlEvents:UIControlEventTouchUpInside];
    inputTextField.leftView = inputLeftButton;
    inputTextField.leftViewMode = UITextFieldViewModeAlways;
    
    [tableViewSearchVC addSubview:inputTextField];
    self.unitTableView.tableHeaderView = tableViewSearchVC;
    
    //下拉刷新
    _downEGO = [[EGORefreshTableHeaderView alloc] initWithScrollView:self.unitTableView orientation:EGOPullOrientationDown];
    _downEGO.delegate = self;
    
//    //上拉加载更多
//    _upEGO = [[EGORefreshTableHeaderView alloc] initWithScrollView:self.unitTableView orientation:EGOPullOrientationUp];
//    _upEGO.delegate = self;
    
    
    
}
#pragma mark - action
-(void)searchUnit:(UITextField *)sender{
    [self matchUnit:sender.text];
}
-(void)matchUnit:(NSString *)unit{
    [self.unitTableList removeAllObjects];
    unit = [unit uppercaseString];
    for (UnitItem *unitItem in self.unitList) {
        if ([unit isEqualToString:@""]) {
            [self.unitTableList addObject:unitItem];
        }else if ([unitItem.UnitName rangeOfString:unit].location !=NSNotFound || [unitItem.Unitjianchen rangeOfString:unit].location !=NSNotFound) {
            [self.unitTableList addObject:unitItem];
        }
    }
    [self.unitTableView reloadData];
}
#pragma mark - textfieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.unitTableList.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"unitCell";
    BaseCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell= [[BaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UnitItem *item = (UnitItem *)[self.unitTableList objectAtIndex:indexPath.row];
    cell.textLabel.text = item.UnitName;
    
    //block的使用
    [cell setupCellWithItem:item index:indexPath.row actionBlock:^(int i ,id ite){
        NSLog(@"indexpath%d",indexPath.row);
    }];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UnitItem *item = (UnitItem *)[self.unitTableList objectAtIndex:indexPath.row];
    [[AppManage sharedManager] setCurrentUnitItem:item];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _isRefreshing = NO;
    [_downEGO egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [_downEGO egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark - EGORefreshTableHeaderDelegate

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view {
    _isRefreshing = YES;
    [MMProgressHUD showWithStatus:LString(@"Loading")];
    [self.dataExchangeMgr getUnitList];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view {
    return _isRefreshing;
}
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view {
    return [NSDate date];
}
#pragma mark - DataExchangeManagerDelegate
-(void)dataExchangeFinishWith:(HttpRequest *)request{
    if (![request error]) {
        NSString *respString = [request responseString];
        NSDictionary *dict = [respString objectFromJSONString];
        if ([dict isKindOfClass:[NSDictionary class]]) {
            NSNumber *result =(NSNumber *)[dict objectForKey:@"code"];
            if(result && result.integerValue == 0) {
                [MMProgressHUD dismiss];
                [self.unitTableList removeAllObjects];
                [self.unitList removeAllObjects];
                if (request.requestType == RT_getUnitList) {
                    
                    NSArray *data = [dict objectForKey:@"data"];
                    if (data && [data isKindOfClass:[NSArray class]]) {
                        for (NSDictionary *dataDict in data) {
                            UnitItem *item = [[UnitItem alloc] initWithDict:dataDict];
                            [self.unitList addObject:item];
                            [self.unitTableList addObject:item];
                        }
                        
                    }
                    [self.unitTableView reloadData];
                    [_downEGO adjustPosition];
                    
                }
            }else{
                [MMProgressHUD dismissWithError:[dict objectForKey:@"desc"] afterDelay:2.0f];
            }
        }else{
            [MMProgressHUD dismissWithError:LString(@"DataFormatError") afterDelay:2.0f];
            
        }

    }else{
       [MMProgressHUD dismissWithError:LString(@"ServerUnavailable") afterDelay:2.0f];
    }
    _isRefreshing = NO;
    [_downEGO egoRefreshScrollViewDataSourceDidFinishedLoading:self.unitTableView];
}
-(void)dataExchangeFailedWith:(HttpRequest *)request{
    [MMProgressHUD dismissWithError:LString(@"NetworkBroken") afterDelay:2.0f];
    _isRefreshing = NO;
    [_downEGO egoRefreshScrollViewDataSourceDidFinishedLoading:self.unitTableView];
    
}
@end
