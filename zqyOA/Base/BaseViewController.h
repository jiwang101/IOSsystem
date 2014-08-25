//
//  BaseViewController.h
//  zqyOA
//
//  Created by daoyi on 14-8-6.
//  Copyright (c) 2014年 daoyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppManage.h"
#import "DataExchangeManager.h"
#import "Macros.h"
#import "SystemLib.h"

@interface BaseViewController : UIViewController<DataExchangeManagerDelegate>
@property (nonatomic,assign) AppManage *manage;
@property (nonatomic,strong) DataExchangeManager *dataExchangeMgr;
@property (nonatomic, assign) BOOL enableDataExchange;    //若需要与后台进行接口交互的话，需将此属性设置为YES
@end
