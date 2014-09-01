//
//  LoginViewController.h
//  zqyOA
//
//  Created by daoyi on 14-8-6.
//  Copyright (c) 2014年 daoyi. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginViewController : BaseViewController
- (IBAction)rememberPass:(id)sender;
- (IBAction)autoLogin:(id)sender;
- (IBAction)selectUnit:(id)sender;
- (IBAction)loginAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *loginNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *loginPassTextField;
@property (weak, nonatomic) IBOutlet UILabel *OANameLabel;
@property (weak, nonatomic) IBOutlet UIButton *autoLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *rememberButton;

@end
