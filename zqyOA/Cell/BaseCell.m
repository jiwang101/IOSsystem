//
//  BaseCell.m
//  zqyOA
//
//  Created by daoyi on 14-8-21.
//  Copyright (c) 2014年 daoyi. All rights reserved.
//

#import "BaseCell.h"

@implementation BaseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //选择背景视图
        UIView *selectBG = [[UIView alloc] initWithFrame:self.bounds];
        selectBG.backgroundColor = [UIColor lightGrayColor];
        self.selectedBackgroundView = selectBG;
    }
    return self;
}
- (void)setupCellWithItem:(BaseItem *)item index:(NSInteger)index actionBlock:(CellAction)action{
    self.action = action;
}
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
