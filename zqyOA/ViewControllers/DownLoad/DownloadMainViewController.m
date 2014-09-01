//
//  DownloadMainViewController.m
//  zqyOA
//
//  Created by daoyi on 14-8-28.
//  Copyright (c) 2014年 daoyi. All rights reserved.
//

#import "DownloadMainViewController.h"
#import "DownCell.h"
#import "DownRecordItem.h"

@interface DownloadMainViewController ()
@property (nonatomic,strong) NSMutableArray *listData;
@end

@implementation DownloadMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"下载中心";
        self.listData = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    DownRecordItem *item1 = [[DownRecordItem alloc] init];
    item1.fileName = @"文件1";
    item1.fileUrl = @"http://183.63.138.178:18815/mmoa/upload/file/MMOAiPhone.ipa";
    [self.listData addObject:item1];
    DownRecordItem *item2 = [[DownRecordItem alloc] init];
    item2.fileName = @"文件2";
    item2.fileUrl = @"http://183.63.138.178:18815/mmoa/upload/file/MMOAiPad.ipa";
    [self.listData addObject:item2];
    
    [self.listTableView reloadData];
    
}
#pragma mark - TableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identerCell = @"download";
    DownCell *cell = [tableView dequeueReusableCellWithIdentifier:identerCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DownCell" owner:self options:nil] objectAtIndex:0];
    }
    DownRecordItem *item = [self.listData objectAtIndex:indexPath.row];
    
    cell.fileNameLabel.text = item.fileName;
    [cell.downButton addTarget:self action:@selector(downFile:) forControlEvents:UIControlEventTouchUpInside];
    cell.downProgress.progressImage = [UIImage imageNamed:@"guageCenter_B26_1"];
    cell.downProgress.trackImage = [UIImage imageNamed:@"guageBg_B26_1"];
    [cell.downProgress setProgress:0.4];
    return cell;
}
#pragma mark - private
- (void)downFile:(UIButton *)sender{
    NSInteger tag = sender.tag;
    DownRecordItem *item = [self.listData objectAtIndex:tag];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
