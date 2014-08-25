//
//  UnitItem.m
//  zqyOA
//  单位实体类
//  Created by daoyi on 14-8-6.
//  Copyright (c) 2014年 daoyi. All rights reserved.
//

#import "UnitItem.h"

@implementation UnitItem
-(id)initWithDict:(NSDictionary *)dict{
    self = [super initWithDict:dict];
    if (self) {
        self.OAUrl = [dict objectForKey:@"oaPath"];
        self.OSUrl = [dict objectForKey:@"urlPath"];
        self.UnitName = [dict objectForKey:@"departmentName"];
        self.Unitjianchen = [dict objectForKey:@"jianchen"];
        self.UnitLogoUrl = [dict objectForKey:@"imgUrl"];
    }
    return self;
}
@end
