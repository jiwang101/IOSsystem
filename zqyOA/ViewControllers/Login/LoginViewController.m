//
//  LoginViewController.m
//  zqyOA
//
//  Created by daoyi on 14-8-6.
//  Copyright (c) 2014年 daoyi. All rights reserved.
//

#import "LoginViewController.h"
#import "SelectUnitsViewController.h"
#import <AdSupport/ASIdentifierManager.h>
#import <GDataXMLNode.h>
#import "LLXMLParser.h"
#import "UserItem.h"
#import "MainViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"用户登录";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!self.manage.currentUnitItem) {
        SelectUnitsViewController *selectUnitController = [[SelectUnitsViewController alloc] init];
        [self.navigationController pushViewController:selectUnitController animated:NO];
    }
    self.autoLoginButton.selected = self.manage.isAutoLogin;
    self.rememberButton.selected = self.manage.isRememberPass;
    self.loginNameTextField.text = self.manage.lastLoginName;
    if (self.manage.isRememberPass) {
        self.loginPassTextField.text = self.manage.lastLoginPass;
        
    }
    
}
-(void)viewDidAppear:(BOOL)animated{
    if (self.manage.currentUnitItem) {
        self.OANameLabel.text = [NSString stringWithFormat:@"%@政务管理系统",self.manage.currentUnitItem.UnitName];
    }else{
        self.OANameLabel.text = @"湛江市政务管理系统";
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - private
-(void)loginAuthen{
    
    NSString *imei = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    [MMProgressHUD showWithStatus:LString(@"Loading")];
    [self.dataExchangeMgr loginAuthen_userName:self.loginNameTextField.text password:self.loginPassTextField.text imei:imei];
}
#pragma mark - DataExchangeManagerDelegate
-(void)dataExchangeFinishWith:(HttpRequest *)request{
    if (![request error]) {
        NSString *respString = [request responseString];
        //如果是json
        NSDictionary *dict = [respString objectFromJSONString];
        if ([dict isKindOfClass:[NSDictionary class]]) {
            NSNumber *result =(NSNumber *)[dict objectForKey:@"result"];
            if(result && result.integerValue == 1) {
                
                if (request.requestType == RT_loginAuthen) {
                    self.manage.lastLoginName = self.loginNameTextField.text;
                    self.manage.lastLoginPass = self.loginPassTextField.text;
                    [self.dataExchangeMgr getUserMoreInfo_loginName:self.manage.lastLoginName];
                }
            }else{
                [MMProgressHUD dismissWithError:[dict objectForKey:@"desc"] afterDelay:2.0f];
            }
        }else{
            //如果是XML
            GDataXMLDocument *xmlDoc = [[GDataXMLDocument alloc] initWithXMLString:respString error:nil];
            
            if (xmlDoc) {
                //获取根目录
                GDataXMLElement *rootElement = [xmlDoc rootElement];
                GDataXMLElement *soapElement = [LLXMLParser pathSubElement:@"soap:Body//QueryUserInfoByLoginIDExResponse" parentElement:rootElement];
                if (request.requestType == RT_getUserMoreInfo) {
                    //获取结果节点
                    GDataXMLElement *returnCode = [LLXMLParser pathSubElement:@"QueryUserInfoByLoginIDExResult//returnCode" parentElement:soapElement];
                    GDataXMLElement *returnMessage = [LLXMLParser pathSubElement:@"QueryUserInfoByLoginIDExResult//returnMessage" parentElement:soapElement];
                    if ([[returnCode stringValue] intValue] == 0) {
                        [MMProgressHUD dismiss];
                        //获取个人信息节点
                        GDataXMLElement *userElement = [LLXMLParser pathSubElement:@"outParam//userInfo//UserInformation" parentElement:soapElement];
                        self.manage.userItem.userId = [[LLXMLParser pathSubElement:@"userID" parentElement:userElement] stringValue];
                        self.manage.userItem.userName = [[LLXMLParser pathSubElement:@"userName" parentElement:userElement] stringValue];
                        self.manage.userItem.userMobile = [[LLXMLParser pathSubElement:@"mobileNo" parentElement:userElement] stringValue];
                        self.manage.userItem.userUnitName = [[LLXMLParser pathSubElement:@"userProperty//NameValueProperty//Value" parentElement:userElement] stringValue];
                        self.manage.userItem.loginName = self.manage.lastLoginName;
                        self.manage.userItem.loginPass = self.manage.lastLoginPass;
                        
                        //进入主界面
                        [SystemLib postNotificationName:@"toMain" object:nil];
                        
                    }else{
                        [MMProgressHUD dismissWithError:[returnMessage stringValue] afterDelay:2.0f];
                    }

                }
                
            }else{
                [MMProgressHUD dismissWithError:LString(@"DataFormatError") afterDelay:2.0f];
            }
            
        }
        
        
    }else{
        [MMProgressHUD dismissWithError:LString(@"ServerUnavailable") afterDelay:2.0f];
    }
}
-(void)dataExchangeFailedWith:(HttpRequest *)request{
    [MMProgressHUD dismissWithError:LString(@"NetworkBroken") afterDelay:2.0f];
}
#pragma mark - action
- (IBAction)rememberPass:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
    self.manage.isRememberPass = button.selected;
}

- (IBAction)autoLogin:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
    self.manage.isAutoLogin = button.selected;
}

- (IBAction)selectUnit:(id)sender {
    SelectUnitsViewController *viewController = [[SelectUnitsViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)loginAction:(id)sender {
    [MMProgressHUD show];
    if (self.loginNameTextField.text.length < 1 || [self.loginNameTextField.text isEqualToString:@""]) {
        [MMProgressHUD dismissWithError:@"账号不能为空" afterDelay:1.0f];
        return;
    }
    if (self.loginPassTextField.text.length < 1 || [self.loginPassTextField.text isEqualToString:@""]) {
        [MMProgressHUD dismissWithError:@"密码不能为空" afterDelay:1.0f];
        return;
    }
    [self loginAuthen];
}
@end
