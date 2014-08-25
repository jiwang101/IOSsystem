//
//  NSMutableArray+Extend.m
//  MobileOA
//
//  Created by Vincent on 4/24/14.
//  Copyright (c) 2014 TeamX. All rights reserved.
//

#import "NSMutableArray+Extend.h"

@implementation NSMutableArray (Extend)

- (void)removeObjectWhileEnumerate:(id)obj
{
    NSMutableArray *discardedItems = [NSMutableArray array];

    for (id item in self) {
        if (item == obj)
            [discardedItems addObject:item];
    }
    
    [self removeObjectsInArray:discardedItems];
}

@end
