//
//  AppDelegate.m
//  zqyOA
//
//  Created by daoyi on 14-8-5.
//  Copyright (c) 2014年 daoyi. All rights reserved.
//

#import "AppDelegate.h"
#import <IQKeyboardManager.h>
#import "LuncherViewController.h"
#import "SelectUnitsViewController.h"
#import "LoginViewController.h"
#import "AppManage.h"
#import <MMProgressHUD.h>
#import "SystemLib.h"

#import "MainViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    // 统一的键盘管理器，避免输入框被遮住
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:40];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    [[IQKeyboardManager sharedManager] setCanAdjustTextView:YES];
    
    //设置提示框的样式
    [MMProgressHUD setDisplayStyle:MMProgressHUDDisplayStylePlain];
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    
    LuncherViewController *luncherVC = [[LuncherViewController alloc] init];
    self.window.rootViewController = luncherVC;
    
    [self.window makeKeyAndVisible];
    
    [self performSelector:@selector(launchFinished) withObject:nil afterDelay:1.5];
    //test bug
    return YES;
}
- (void)launchFinished
{
    [SystemLib addNotificationCenter:self selector:@selector(onNotify:) name:@"toLogin" object:nil];
	[SystemLib addNotificationCenter:self selector:@selector(onNotify:) name:@"toMain" object:nil];
    [SystemLib addNotificationCenter:self selector:@selector(onNotify:) name:@"toLogOut" object:nil];
    [SystemLib postNotificationName:@"toLogin" object:nil];
    
//    [self performSelector:@selector(checkUpdate) withObject:nil afterDelay:3.0];
}
#pragma mark -
#pragma mark onNotify
- (void)onNotify:(NSNotification *) notification{
	
	//**** 启动完成->登陆/配置 ****
	if ([[notification name] isEqualToString:@"toLogin"]) {
        LoginViewController *selectUnitController = [[LoginViewController alloc] init];
        self.nav = [[UINavigationController alloc] initWithRootViewController:selectUnitController];
        
        self.nav.view.backgroundColor = [UIColor whiteColor];
        self.nav.navigationBarHidden = YES;
        self.window.rootViewController = self.nav;
		
	}
    //**** 进入主界面 ****
	if ([[notification name] isEqualToString:@"toMain"]) {
        MainViewController *selectUnitController = [[MainViewController alloc] init];
        self.nav = [[UINavigationController alloc] initWithRootViewController:selectUnitController];
        
        self.nav.view.backgroundColor = [UIColor whiteColor];
        self.nav.navigationBarHidden = YES;
        self.window.rootViewController = self.nav;
    }
    //**** 退出登录 ****
	if ([[notification name] isEqualToString:@"toLogOut"]) {
        [[AppManage sharedManager].userItem reset];
        [SystemLib postNotificationName:@"toLogin" object:nil];
        
    }
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
