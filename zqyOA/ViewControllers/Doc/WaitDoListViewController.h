//
//  WaitDoListViewController.h
//  zqyOA
//
//  Created by daoyi on 14-8-25.
//  Copyright (c) 2014年 daoyi. All rights reserved.
//

#import "BaseViewController.h"

@interface WaitDoListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@end
