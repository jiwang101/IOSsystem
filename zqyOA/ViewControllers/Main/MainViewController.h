//
//  MainViewController.h
//  zqyOA
//
//  Created by daoyi on 14-8-6.
//  Copyright (c) 2014年 daoyi. All rights reserved.
//

#import "BaseViewController.h"

@interface MainViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *userLogoImage;
@property (weak, nonatomic) IBOutlet UILabel *userUnitNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIView *contentView;
- (IBAction)waitDoAction:(id)sender;
- (IBAction)haveDoAction:(id)sender;
- (IBAction)exitAction:(id)sender;


@end
