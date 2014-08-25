//
//  AppManage.h
//  zqyOA
//
//  Created by daoyi on 14-8-6.
//  Copyright (c) 2014年 daoyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UnitItem.h"
#import "UserItem.h"

@interface AppManage : NSObject
+ (AppManage *)sharedManager;
@property (nonatomic,strong) UnitItem *currentUnitItem;
@property (nonatomic,strong) UserItem *userItem;
@property (nonatomic,assign) BOOL isAutoLogin;
@property (nonatomic,assign) BOOL isRememberPass;
@property (nonatomic,strong) NSString *lastLoginName;
@property (nonatomic,strong) NSString *lastLoginPass;
@end
