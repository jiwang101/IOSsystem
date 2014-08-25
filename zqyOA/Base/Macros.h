//
//  Macros.h
//  zqyOA
//
//  Created by daoyi on 14-8-6.
//  Copyright (c) 2014年 daoyi. All rights reserved.
//


//本地存储
#define USER_DEFAULTS_SET(__OBJECT,__KEY) {\
[[NSUserDefaults standardUserDefaults] setObject:__OBJECT forKey:__KEY];\
[[NSUserDefaults standardUserDefaults] synchronize];}

#define USER_DEFAULTS_GET(__KEY) ([[NSUserDefaults standardUserDefaults] objectForKey:__KEY])

//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//是否为IOS7
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue]>=7)
//判断是否是4英寸的高清屏
#define DEVICE_R4 ([[UIScreen mainScreen] bounds].size.height > 481)

//本地化语言
#define LString(key)  NSLocalizedString(key, nil)