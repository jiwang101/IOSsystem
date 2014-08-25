//
//  UserItem.h
//  zqyOA
//
//  Created by daoyi on 14-8-21.
//  Copyright (c) 2014年 daoyi. All rights reserved.
//

#import "BaseItem.h"

@interface UserItem : BaseItem
@property (nonatomic,copy) NSString *loginName;  //登录账户
@property (nonatomic,copy) NSString *loginPass;
@property (nonatomic,copy) NSString *userId;
@property (nonatomic,copy) NSString *userMobile;
@property (nonatomic,copy) NSString *userName;      //用户姓名
@property (nonatomic,copy) NSString *userUnitName;  //返回的单位名称
- (void)reset;
@end
