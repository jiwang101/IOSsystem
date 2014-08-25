//
//  SelectUnitsViewController.h
//  zqyOA
//
//  Created by daoyi on 14-8-6.
//  Copyright (c) 2014年 daoyi. All rights reserved.
//

#import "BaseViewController.h"

@interface SelectUnitsViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *unitTableView;

@end
