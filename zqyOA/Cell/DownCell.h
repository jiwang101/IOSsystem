//
//  DownCell.h
//  zqyOA
//
//  Created by daoyi on 14-8-29.
//  Copyright (c) 2014年 daoyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"

@interface DownCell : BaseCell
@property (weak, nonatomic) IBOutlet UILabel *fileNameLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *downProgress;
- (IBAction)downAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *downButton;

@end
