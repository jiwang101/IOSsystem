//
//  UnitItem.h
//  zqyOA
//
//  Created by daoyi on 14-8-6.
//  Copyright (c) 2014年 daoyi. All rights reserved.
//

#import "BaseItem.h"

@interface UnitItem : BaseItem
@property(nonatomic,copy) NSString *OAUrl;  //OA域名地址
@property(nonatomic,copy) NSString *OSUrl;  //门户域名地址
@property(nonatomic,copy) NSString *UnitName;   //单位名称
@property(nonatomic,copy) NSString *Unitjianchen;   //单位首字母缩写
@property(nonatomic,copy) NSString *UnitLogoUrl;
@end
