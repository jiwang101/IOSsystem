//
//  DocItem.m
//  zqyOA
//
//  Created by daoyi on 14-8-29.
//  Copyright (c) 2014年 daoyi. All rights reserved.
//

#import "DocItem.h"

@implementation DocItem
-(id)initWithDict:(NSDictionary *)dict{
    self = [super initWithDict:dict];
    if (self) {
        self.actionName = [dict objectForKey:@"action_name"];
        self.docTitle = [[dict objectForKey:@"doc_title"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        self.docType = [dict objectForKey:@"doc_type"];
        self.sender = [dict objectForKey:@"sender"];
        self.senderTime = [dict objectForKey:@"sender_time"];
    }
    return self;
}
@end
