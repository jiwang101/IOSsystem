//
//  MainViewController.m
//  zqyOA
//
//  Created by daoyi on 14-8-6.
//  Copyright (c) 2014年 daoyi. All rights reserved.
//

#import "MainViewController.h"
#import <UIImageView+WebCache.h>
#import "DownloadMainViewController.h"
#import "WaitDoListViewController.h"


@interface MainViewController (){
    NSInteger _currentButtonTag;
}
@property (nonatomic,strong) NSMutableArray *contentViews;
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = self.manage.userItem.userName;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.userLogoImage sd_setImageWithURL:[NSURL URLWithString:self.manage.currentUnitItem.UnitLogoUrl]];
    self.userNameLabel.text = self.manage.userItem.userName;
    self.userUnitNameLabel.text = self.manage.userItem.userUnitName;
    
    //装载内容视图
    self.contentViews = [NSMutableArray array];
    //待办
    WaitDoListViewController *waitDoVC = [[WaitDoListViewController alloc] init];
    UINavigationController *waitDoNavigationController = [[UINavigationController alloc] initWithRootViewController:waitDoVC];
    waitDoNavigationController.navigationBarHidden = YES;
    [self.contentViews addObject:waitDoNavigationController];
    //下载中心
    DownloadMainViewController *downVC = [[DownloadMainViewController alloc] init];
    UINavigationController *downNavigationController = [[UINavigationController alloc] initWithRootViewController:downVC];
    downNavigationController.navigationBarHidden = YES;
    [self.contentViews addObject:downNavigationController];
    [self clickItemsAction:0];
}
#pragma mark - parivate
//按钮切换视图
- (void)clickItemsAction:(NSInteger)toTag{
    UINavigationController *navController = (UINavigationController *)[self.contentViews objectAtIndex:_currentButtonTag];
    if (navController) {
        [navController.view removeFromSuperview];
    }
    _currentButtonTag = toTag;
    UINavigationController *toNavController = (UINavigationController *)[self.contentViews objectAtIndex:_currentButtonTag];
    [toNavController popToRootViewControllerAnimated:NO];
    [self.contentView addSubview:toNavController.view];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)waitDoAction:(id)sender {
    [self clickItemsAction:0];
}

- (IBAction)haveDoAction:(id)sender {
    [self clickItemsAction:1];
}

- (IBAction)exitAction:(id)sender {
    RIButtonItem *okItem = [RIButtonItem itemWithLabel:@"确定" action:^{
        [SystemLib postNotificationName:@"toLogOut" object:nil];
    }];
    RIButtonItem *cancelItem = [RIButtonItem itemWithLabel:@"取消"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定退出登录" message:nil cancelButtonItem:cancelItem otherButtonItems:okItem, nil];
    [alert show];
}
@end
