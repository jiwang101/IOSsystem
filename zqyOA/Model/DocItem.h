//
//  DocItem.h
//  zqyOA
//
//  Created by daoyi on 14-8-29.
//  Copyright (c) 2014年 daoyi. All rights reserved.
//

#import "BaseItem.h"

@interface DocItem : BaseItem
@property (nonatomic,copy) NSString *actionName;
@property (nonatomic,copy) NSString *docTitle;
@property (nonatomic,copy) NSString *docType;
@property (nonatomic,copy) NSString *sender;
@property (nonatomic,copy) NSString *senderTime;
@end
