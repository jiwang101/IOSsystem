//
//  DataExchangeManager.h
//  MobileOA
//
//  Created by Vincent on 4/24/14.
//  Copyright (c) 2014 TeamX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "ASINetworkQueue.h"

#define kHostUrl      @"http://mm.mmzqoa.net"

#define kRESTUrl      kHostUrl kServerRoot

#define kSystemUrl @"http://zqkhd.zjportal.net/client"  //后台接口地址

//门户WebService
#define kWebServiceUrl @"%@/WS/NewOrgServiceOld.asmx"
#define kWebServiceNameSpace @"http://sxt.com.cn/"

#define kServerRoot   @"mobileoa/zjmobileOA"

#define kPageSize 10


typedef enum {
    RT_getUnitList,
    RT_loginAuthen,
    RT_getUserMoreInfo,
    RT_getWaitDoDocList,
    RT_getHaveDoDocList,
} RequestType;

// HttpRequest
@interface HttpRequest : ASIFormDataRequest
@property (assign, nonatomic) RequestType requestType;
@property (assign, nonatomic) NSInteger reserved;
@property (strong, nonatomic) id reservedObj;
@property (copy,   nonatomic) NSString  *reservedString;
@end


// DataExchangeManagerDelegate
@protocol DataExchangeManagerDelegate <NSObject>

@optional
- (void)dataExchangeFinishWith:(HttpRequest *)request;
- (void)dataExchangeFailedWith:(HttpRequest *)request;
- (void)dataUpload:(HttpRequest *)request progress:(CGFloat)progress;

@end

@interface DataExchangeManager : NSObject

@property (assign, nonatomic) id<DataExchangeManagerDelegate> delegate;
@property (strong, nonatomic) NSMutableArray *requestQueue;
@property (strong, nonatomic) NSMutableArray *actionQueue;
@property (strong, nonatomic) NSMutableDictionary *actionDict;


//获取单位列表
- (void)getUnitList;

//登录
- (void)loginAuthen_userName:(NSString *)userName
                    password:(NSString *)password
                        imei:(NSString *)imei;
//获取个人信息
- (void)getUserMoreInfo_loginName:(NSString *)loginName;

//获取待办列表
- (void)getWaitDoDocList_loginName:(NSString *)loginName
                            pageNo:(NSInteger)pageNo
                          pageSize:(NSInteger)pageSize
                              type:(NSInteger)type
                             title:(NSString *)title;

//自动更新
- (void)checkUpdate;

@end






