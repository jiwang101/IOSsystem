//
//  AppManage.m
//  zqyOA
//
//  Created by daoyi on 14-8-6.
//  Copyright (c) 2014年 daoyi. All rights reserved.
//

#import "AppManage.h"
#import "Macros.h"

static AppManage *instance = nil;

@implementation AppManage
+ (AppManage *)sharedManager
{
    @synchronized(self) {
        if (instance == nil) {
            instance = [[AppManage alloc] init];
        }
    }
    
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        NSString *OAUrl = USER_DEFAULTS_GET(@"OAUrl");
        NSString *OSUrl = USER_DEFAULTS_GET(@"OSUrl");
        NSString *UnitName = USER_DEFAULTS_GET(@"UnitName");
        NSString *Unitjianchen = USER_DEFAULTS_GET(@"Unitjianchen");
        NSString *UnitLogoUrl = USER_DEFAULTS_GET(@"UnitLogoUrl");
        if (OAUrl && OSUrl && UnitName) {
            _currentUnitItem = [[UnitItem alloc] init];
            _currentUnitItem.OAUrl = OAUrl;
            _currentUnitItem.OSUrl = OSUrl;
            _currentUnitItem.UnitName = UnitName;
            _currentUnitItem.Unitjianchen = Unitjianchen;
            _currentUnitItem.UnitLogoUrl = UnitLogoUrl;
        }
        id isAuto = USER_DEFAULTS_GET(@"isAutoLogin");
        if (isAuto) {
            _isAutoLogin = [isAuto boolValue];
        }else{
            _isAutoLogin = NO;
        }
        
        id isRememberPass = USER_DEFAULTS_GET(@"isRememberPass");
        if (isRememberPass) {
            _isRememberPass = [isRememberPass boolValue];
        }else{
            _isRememberPass = NO;
        }
        
        _lastLoginName = USER_DEFAULTS_GET(@"lastLoginName");
        _lastLoginPass = USER_DEFAULTS_GET(@"lastLoginPass");
        
        if (!_userItem) {
            _userItem = [[UserItem alloc] init];
        }
    }
    
    return self;
}
-(void)setCurrentUnitItem:(UnitItem *)currentUnitItem{
    _currentUnitItem = currentUnitItem;
    USER_DEFAULTS_SET(_currentUnitItem.OAUrl, @"OAUrl");
    USER_DEFAULTS_SET(_currentUnitItem.OSUrl, @"OSUrl");
    USER_DEFAULTS_SET(_currentUnitItem.UnitName, @"UnitName");
    USER_DEFAULTS_SET(_currentUnitItem.Unitjianchen, @"Unitjianchen");
    USER_DEFAULTS_SET(_currentUnitItem.UnitLogoUrl, @"UnitLogoUrl");
}
-(void)setIsAutoLogin:(BOOL)isAutoLogin{
    _isAutoLogin = isAutoLogin;
    USER_DEFAULTS_SET([NSNumber numberWithBool:isAutoLogin], @"isAutoLogin");
}
-(void)setIsRememberPass:(BOOL)isRememberPass{
    _isRememberPass = isRememberPass;
    USER_DEFAULTS_SET([NSNumber numberWithBool:isRememberPass], @"isRememberPass");

}
-(void)setLastLoginName:(NSString *)lastLoginName{
    _lastLoginName = lastLoginName;
    USER_DEFAULTS_SET(_lastLoginName, @"lastLoginName");
}
-(void)setLastLoginPass:(NSString *)lastLoginPass{
    _lastLoginPass = lastLoginPass;
    USER_DEFAULTS_SET(_lastLoginPass, @"lastLoginPass");
}
@end
