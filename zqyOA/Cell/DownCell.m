//
//  DownCell.m
//  zqyOA
//
//  Created by daoyi on 14-8-29.
//  Copyright (c) 2014年 daoyi. All rights reserved.
//

#import "DownCell.h"

@implementation DownCell

- (void)awakeFromNib
{
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)downAction:(id)sender {
}
@end
