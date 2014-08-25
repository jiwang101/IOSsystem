//
//  DataExchangeManager.m
//  MobileOA
//
//  Created by Vincent on 4/24/14.
//  Copyright (c) 2014 TeamX. All rights reserved.
//

#import "DataExchangeManager.h"
#import "NSMutableArray+Extend.h"
#import "AppManage.h"

// HttpRequest
@implementation HttpRequest
@end

static NSArray *cookies = nil;

// DataExchangeManager
@interface DataExchangeManager ()

-  (HttpRequest *)requestWithUrl:(NSURL *)url parameter:(NSDictionary *)param requestType:(RequestType)type;

@end

@implementation DataExchangeManager

- (id)init
{
    self = [super init];
    if (self) {
        self.requestQueue = [NSMutableArray array];
        self.actionQueue = [NSMutableArray array];
        self.actionDict = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (void)dealloc
{
    self.delegate = nil;
}

- (void)setDelegate:(id<DataExchangeManagerDelegate>)delegate
{
    _delegate = delegate;
    if (_delegate==nil) {
        for (HttpRequest *request in self.requestQueue) {
            request.delegate = nil;
        }
        
        [self.requestQueue removeAllObjects];
    }
}
#pragma mark - 普通的POST请求
-  (HttpRequest *)requestWithUrl:(NSURL *)url parameter:(NSDictionary *)param requestType:(RequestType)type
{
    for (NSNumber *aq in self.actionQueue) {
        if (aq.integerValue == type) {
            
            return nil;
        }
    }
    
    [self.actionQueue addObject:[NSNumber numberWithInteger:type]];

    HttpRequest *httpRequest = [HttpRequest requestWithURL:url];
    httpRequest.requestType = type;
    httpRequest.delegate = self;
    [httpRequest setShouldAttemptPersistentConnection:NO];
    httpRequest.requestCookies = [NSMutableArray arrayWithArray:cookies];
    
    for (NSString *key in [param allKeys]) {
        
        if ([[param objectForKey:key] isKindOfClass:[UIImage class]]) {

            NSData *imgData = UIImageJPEGRepresentation([param objectForKey:key], 1.0);
            [httpRequest setData:imgData withFileName:[NSString stringWithFormat:@"%@.jpg",key] andContentType:@"image/jpeg" forKey:key];
        } else {
            [httpRequest setPostValue:[param objectForKey:key] forKey:key];
        }
    }
    
    [httpRequest setTimeOutSeconds:60];
    [httpRequest startAsynchronous];

    [self.requestQueue addObject:httpRequest];
    
    return httpRequest;
}
#pragma mark - webservice请求
- (NSString *)paramToDefaultSoapMessage:(NSDictionary *)param methodName:(NSString*)methodName{
    NSMutableString *soapMutableString = [NSMutableString string];
    for (id key in [param allKeys]) {
        [soapMutableString appendFormat:@"<%@>",key];
        [soapMutableString appendString:[param objectForKey:key]];
        [soapMutableString appendFormat:@"</%@>",key];
    }
    NSMutableString *soapSystemString = [NSMutableString string];
    NSDictionary *systemDic = [self buildDicWithSystemParams];
    for (id key in [systemDic allKeys]) {
        [soapSystemString appendFormat:@"<%@>",key];
        [soapSystemString appendString:[systemDic objectForKey:key]];
        [soapSystemString appendFormat:@"</%@>",key];
    }

    NSString *soapString = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                            "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                            "<soap:Body><%@ xmlns=\"%@\">%@<inParam>%@</inParam></%@></soap:Body></soap:Envelope>",methodName,kWebServiceNameSpace,soapSystemString,soapMutableString,methodName];

    return soapString;
}
- (void)requestWithWebServiceUrl:(NSURL *)url method:(NSString *)method parameter:(NSDictionary *)param requestType:(RequestType)type
{
    for (NSNumber *aq in self.actionQueue) {
        if (aq.integerValue == type) {
            
            return ;
        }
    }
    
    [self.actionQueue addObject:[NSNumber numberWithInteger:type]];
    
    NSString *soapMsg=[self paramToDefaultSoapMessage:param methodName:method];

    HttpRequest *httpRequest = [HttpRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    [httpRequest addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
	[httpRequest addRequestHeader:@"Content-Length" value:msgLength];
    [httpRequest addRequestHeader:@"SOAPAction" value:[NSString stringWithFormat:@"%@%@",kWebServiceNameSpace,method]];
    //传soap信息
    [httpRequest appendPostData:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    [httpRequest setValidatesSecureCertificate:NO];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    
    
    httpRequest.requestType = type;
    httpRequest.delegate = self;
    [httpRequest setShouldAttemptPersistentConnection:NO];
    httpRequest.requestCookies = [NSMutableArray arrayWithArray:cookies];
    [httpRequest setTimeOutSeconds:60];
    [httpRequest startAsynchronous];
    
    [self.requestQueue addObject:httpRequest];
    
}

#pragma mark - HttpRequest delegate
- (void)requestFinished:(HttpRequest *)request
{
    for (NSNumber *aq in self.actionQueue) {
        if (aq.integerValue == request.requestType) {
            
            [self.actionQueue removeObjectWhileEnumerate:aq];
            break;
        }
    }
    
 	if (self.delegate && [self.delegate respondsToSelector:@selector(dataExchangeFinishWith:)]) {
        [self.delegate dataExchangeFinishWith:request];
    }
    
    request.delegate = nil;
    [self.requestQueue removeObjectWhileEnumerate:request];
}

- (void)requestFailed:(HttpRequest *)request
{
    for (NSNumber *aq in self.actionQueue) {
        if (aq.integerValue == request.requestType) {
            
            [self.actionQueue removeObjectWhileEnumerate:aq];
            break;
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(dataExchangeFailedWith:)]) {
        [self.delegate dataExchangeFailedWith:request];
    }
    
    request.delegate = nil;
    [self.requestQueue removeObjectWhileEnumerate:request];
}

- (NSURL *)buildUrlWithInterface:(NSString *)category method:(NSString *)method
{
    NSString *urlString = [NSString stringWithFormat:@"%@/%@!%@.action",kSystemUrl,category,method];
    return [NSURL URLWithString:urlString];
}

//门户接口
- (NSURL *)buildUrlWithDynamicServerForWebsite:(NSString *)method
{
    NSString *category = @"WS/Asynchronous";
    return [self buildUrlWithDynamicServer:category method:method server:[AppManage sharedManager].currentUnitItem.OSUrl];
}

- (NSDictionary *)buildDicWithSystemParams
{
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:@"SYSTEM-0000000000000000000000005",@"systemID",
                            @"client", @"account",
                            @"clientpass123", @"password", nil];
    return params;
}

//OA接口
- (NSURL *)buildUrlWithDynamicServerForOA:(NSString *)category method:(NSString *)method
{
    return [self buildUrlWithDynamicServer:category method:method server:[AppManage sharedManager].currentUnitItem.OAUrl];
}

- (NSURL *)buildUrlWithDynamicServer:(NSString *)category method:(NSString *)method server:(NSString *)serverUrl
{
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/%@",serverUrl,category,method];
    return [NSURL URLWithString:urlString];
}

//获取区域列表
- (void)getUnitList
{
    NSString *category = @"departmentAction";
    NSString *method = @"findDepartmentClientList";
    
    [self requestWithUrl:[self buildUrlWithInterface:category method:method] parameter:nil requestType:RT_getUnitList];
}

//登录
- (void)loginAuthen_userName:(NSString *)userName
                    password:(NSString *)password
                        imei:(NSString *)imei
{
    NSString *method = @"UserLongin.ashx";
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:userName,@"userName",
                            password, @"password",
                            imei, @"imei", nil];
    
    [self requestWithUrl:[self buildUrlWithDynamicServerForWebsite:method] parameter:params requestType:RT_loginAuthen];
}

-(void)getUserMoreInfo_loginName:(NSString *)loginName
{
    NSString *method = @"QueryUserInfoByLoginIDEx";
    
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:loginName,@"loginID", nil];
    
    
    NSURL *webService = [NSURL URLWithString:[NSString stringWithFormat:kWebServiceUrl,[AppManage sharedManager].currentUnitItem.OSUrl]];
    
    [self requestWithWebServiceUrl:webService method:method parameter:params requestType:RT_getUserMoreInfo];
}

@end







