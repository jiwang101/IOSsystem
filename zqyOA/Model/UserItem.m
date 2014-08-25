//
//  UserItem.m
//  zqyOA
//
//  Created by daoyi on 14-8-21.
//  Copyright (c) 2014年 daoyi. All rights reserved.
//

#import "UserItem.h"

@implementation UserItem
-(id)initWithDict:(NSDictionary *)dict{
    self = [super initWithDict:dict];
    if (self) {
//        self.loginName = [];
    }
    return self;
}
-(void)reset{
    _loginName = @"";
    _loginPass = @"";
    _userId = @"";
    _userMobile = @"";
    _userName = @"";
}
@end
