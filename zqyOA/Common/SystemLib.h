//
//  SystemLib.h
//  ZJIPHONE
//
//  Created by apple on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemLib : NSObject {
    
}


#pragma mark -
#pragma mark NotificationCenter 消息
+(void)addNotificationCenter:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject;
+(void)postNotificationName:(NSString *)aName object:(id)anObject;
+(void)postNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo;
+(void)removeObserver:(id)observer;
+(void)removeObserver:(id)observer name:(NSString *)aName object:(id)anObject;


#pragma mark -
#pragma mark UserDefaults
+(BOOL)setUserDefaultsWithObject:(id)aObject forKey:(NSString*)aKey;
+(id)getUserDefaultsObject:(NSString*)aKey;
+(BOOL)setUserDefaultsWithInt:(NSInteger)aObject forKey:(NSString*)aKey;
+(NSInteger)getUserDefaultsInt:(NSString*)aKey;
+(void)removeUserDefaults:(NSString*)aKey;

@end
