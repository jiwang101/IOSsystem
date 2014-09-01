//
//  DownloadMainViewController.h
//  zqyOA
//
//  Created by daoyi on 14-8-28.
//  Copyright (c) 2014年 daoyi. All rights reserved.
//

#import "BaseViewController.h"

@interface DownloadMainViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@end
