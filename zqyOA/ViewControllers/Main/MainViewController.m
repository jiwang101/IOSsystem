//
//  MainViewController.m
//  zqyOA
//
//  Created by daoyi on 14-8-6.
//  Copyright (c) 2014年 daoyi. All rights reserved.
//

#import "MainViewController.h"
#import <UIImageView+WebCache.h>


@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = self.manage.userItem.userName;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.userLogoImage sd_setImageWithURL:[NSURL URLWithString:self.manage.currentUnitItem.UnitLogoUrl]];
    self.userNameLabel.text = self.manage.userItem.userName;
    self.userUnitNameLabel.text = self.manage.userItem.userUnitName;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)waitDoAction:(id)sender {
}

- (IBAction)haveDoAction:(id)sender {
}
@end
