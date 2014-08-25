#import "SystemLib.h"


@implementation SystemLib


#pragma mark -
#pragma mark NotificationCenter 消息
+(void)addNotificationCenter:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject{
	[[NSNotificationCenter defaultCenter] addObserver:observer selector:aSelector name:aName object:anObject];
}
+(void)postNotificationName:(NSString *)aName object:(id)anObject{
	[[NSNotificationCenter defaultCenter] postNotificationName:aName object:anObject];
}
+(void)postNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo{
	[[NSNotificationCenter defaultCenter] postNotificationName:aName object:anObject userInfo:aUserInfo];
}
+(void)removeObserver:(id)observer{
	[[NSNotificationCenter defaultCenter] removeObserver:observer];
}
+(void)removeObserver:(id)observer name:(NSString *)aName object:(id)anObject{
	[[NSNotificationCenter defaultCenter] removeObserver:observer name:aName object:anObject];
}


/*
 -(void)HandleCustomMessage:(NSNotification *)notify {
 
 [notify retain];
 [self performSelectorOnMainThread:@selector(HandleCustomMessageMainThread:) withObject:notify waitUntilDone:NO];
 }
 
 
 -(void) HandleCustomMessageMainThread:(NSNotification *)notify{
 
 NSString* message=[notify name];
 */

#pragma mark -
#pragma mark UserDefaults 持久化
+(BOOL)setUserDefaultsWithObject:(id)aObject 
						  forKey:(NSString*)aKey{
	//设置一个userDefaults项
	[[NSUserDefaults standardUserDefaults] setObject:aObject forKey:aKey];
	return [[NSUserDefaults standardUserDefaults] synchronize];
}
+(id)getUserDefaultsObject:(NSString*)aKey{
	return [[NSUserDefaults standardUserDefaults] objectForKey:aKey];
}
+(BOOL)setUserDefaultsWithInt:(NSInteger)aInt
					   forKey:(NSString*)aKey{
	//设置一个userDefaults项
	[[NSUserDefaults standardUserDefaults] setInteger:aInt forKey:aKey];
	return [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSInteger)getUserDefaultsInt:(NSString*)aKey{
	return [[NSUserDefaults standardUserDefaults] integerForKey:aKey];
}
+(void)removeUserDefaults:(NSString*)aKey{
	[[NSUserDefaults standardUserDefaults] removeObjectForKey:aKey];
}




@end
