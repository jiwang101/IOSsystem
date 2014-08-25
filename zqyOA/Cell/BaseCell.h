//
//  BaseCell.h
//  zqyOA
//
//  Created by daoyi on 14-8-21.
//  Copyright (c) 2014年 daoyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseItem.h"

//定义点击事件
typedef void(^CellAction)(int,id);
@interface BaseCell : UITableViewCell
@property (copy, nonatomic) CellAction action;

- (void)setupCellWithItem:(BaseItem *)item index:(NSInteger)index actionBlock:(CellAction)action;
@end
