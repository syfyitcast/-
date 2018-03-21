//
//  HttpClient.m
//  ZXProject
//
//  Created by Me on 2018/2/12.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "HttpClient.h"
#import "Tool+MD5.h"
#import "NetworkConfig.h"
#import "NSNULL+Filtration.h"

@implementation HttpClient

+ (void)zx_httpClientToLoginWithUserName:(NSString *_Nullable)userName andPassword:(NSString *_Nullable)password andSuccessBlock:(responseBlock _Nullable )block{
    [NetworkConfig networkConfigTokenWithMethodName:API_LOGINPWD];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:[NetworkConfig sharedNetworkingConfig].publicParamters];
    [dict setObject:userName forKey:@"loginname"];
    [dict setObject:[Tool MD5ForLower32Bate:password] forKey:@"loginpass"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_LOGINPWD];
        request.httpMethod           = kXMHTTPMethodPOST;
        request.parameters =         dict;
        request.timeoutInterval      = 30;
        request.useGeneralHeaders    = YES;
        request.useGeneralServer     = YES;
        request.useGeneralParameters = NO;
    } onSuccess:^(id  _Nullable responseObject) {
        id responseObjectNoNull = [responseObject filterNullObject];
        int resultCode = [responseObjectNoNull[@"code"] intValue];
        id data = responseObjectNoNull[@"datas"];
        NSString *message = responseObjectNoNull[@"codedes"];
        block(resultCode,data,message,nil);
    } onFailure:^(NSError * _Nullable error) {
        block(-1,nil,nil,error);
    }];
}

+ (void)zx_httpClientToLoginWithUserName:(NSString *_Nullable)userName andVerifyCode:(NSString *_Nullable)VerifyCode andSmsid:(NSString *)smsid andSuccessBlock:(responseBlock _Nullable )block{
    [NetworkConfig networkConfigTokenWithMethodName:API_LOGINCODE];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:[NetworkConfig sharedNetworkingConfig].publicParamters];
    [dict setObject:userName forKey:@"mobileno"];
    [dict setObject:smsid forKey:@"smsid"];
    [dict setObject:VerifyCode forKey:@"smscontent"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_LOGINCODE];
        request.httpMethod           = kXMHTTPMethodPOST;
        request.parameters =         dict;
        request.timeoutInterval      = 30;
        request.useGeneralHeaders    = YES;
        request.useGeneralServer     = YES;
        request.useGeneralParameters = NO;
    } onSuccess:^(id  _Nullable responseObject) {
        id responseObjectNoNull = [responseObject filterNullObject];
        int resultCode = [responseObjectNoNull[@"code"] intValue];
        id data = responseObjectNoNull[@"datas"];
        NSString *message = responseObjectNoNull[@"codedes"];
        block(resultCode,data,message,nil);
    } onFailure:^(NSError * _Nullable error) {
        block(-1,nil,nil,error);
    }];
}

+ (void)zx_httpClientToGetVerifyCodeWithType:(int)type andMobile:(NSString *)mobile andSuccessBlock:(responseBlock)block{
    [NetworkConfig networkConfigTokenWithMethodName:API_GETCODE];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:[NetworkConfig sharedNetworkingConfig].publicParamters];
    [dict setObject:@(type) forKey:@"optype"];
    [dict setObject:mobile forKey:@"mobileno"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_GETCODE];
        request.httpMethod           = kXMHTTPMethodPOST;
        request.parameters =         dict;
        request.timeoutInterval      = 30;
        request.useGeneralHeaders    = YES;
        request.useGeneralServer     = YES;
        request.useGeneralParameters = NO;
    } onSuccess:^(id  _Nullable responseObject) {
        id responseObjectNoNull = [responseObject filterNullObject];
        int resultCode = [responseObjectNoNull[@"code"] intValue];
        id data = responseObjectNoNull[@"datas"];
        NSString *message = responseObjectNoNull[@"codedes"];
        block(resultCode,data,message,nil);
    } onFailure:^(NSError * _Nullable error) {
        block(-1,nil,nil,error);
    }];
}

+ (void)zx_httpClientToRegisterWithMobile:(NSString *_Nullable)mobile andSmcontent:(NSString *_Nullable)content andSmsid:(NSString *_Nullable)smsid andPassword:(NSString *)password andSuccessBlock:(responseBlock _Nullable)block{
    [NetworkConfig networkConfigTokenWithMethodName:API_REGISTER];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:[NetworkConfig sharedNetworkingConfig].publicParamters];
    [dict setObject:content forKey:@"smscontent"];
    [dict setObject:mobile forKey:@"mobileno"];
    [dict setObject:smsid?smsid:@"" forKey:@"smsid"];
    [dict setObject:[Tool MD5ForLower32Bate:password] forKey:@"loginpass"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_REGISTER];
        request.httpMethod           = kXMHTTPMethodPOST;
        request.parameters =         dict;
        request.timeoutInterval      = 30;
        request.useGeneralHeaders    = YES;
        request.useGeneralServer     = YES;
        request.useGeneralParameters = NO;
    } onSuccess:^(id  _Nullable responseObject) {
        id responseObjectNoNull = [responseObject filterNullObject];
        int resultCode = [responseObjectNoNull[@"code"] intValue];
        id data = responseObjectNoNull[@"datas"];
        NSString *message = responseObjectNoNull[@"codedes"];
        block(resultCode,data,message,nil);
    } onFailure:^(NSError * _Nullable error) {
        block(-1,nil,nil,error);
    }];
}

//修改密码
+ (void)zx_httpClientToForgetPasswordWithMobile:(NSString *_Nullable)mobile andVerifyCode:(NSString *_Nullable)code andSmsid:(NSString *_Nullable)smsid andNewPassword:(NSString *_Nullable)password andSuccessBlock:(responseBlock _Nullable )block{
    [NetworkConfig networkConfigTokenWithMethodName:API_FORGETPWD];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:[NetworkConfig sharedNetworkingConfig].publicParamters];
    [dict setObject:code forKey:@"smscontent"];
    [dict setObject:mobile forKey:@"mobileno"];
    [dict setObject:smsid?smsid:@"" forKey:@"smsid"];
    [dict setObject:[Tool MD5ForLower32Bate:password] forKey:@"loginpass"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_FORGETPWD];
        request.httpMethod           = kXMHTTPMethodPOST;
        request.parameters =         dict;
        request.timeoutInterval      = 30;
        request.useGeneralHeaders    = YES;
        request.useGeneralServer     = YES;
        request.useGeneralParameters = NO;
    } onSuccess:^(id  _Nullable responseObject) {
        id responseObjectNoNull = [responseObject filterNullObject];
        int resultCode = [responseObjectNoNull[@"code"] intValue];
        id data = responseObjectNoNull[@"datas"];
        NSString *message = responseObjectNoNull[@"codedes"];
        block(resultCode,data,message,nil);
    } onFailure:^(NSError * _Nullable error) {
        block(-1,nil,nil,error);
    }];
}

+ (void)zx_httpClientToGetProjectListWithProjectCode:(NSString *)projectCode andProjectName:(NSString *)projectName andSuccessBlock:(responseBlock)block{
    [NetworkConfig networkConfigTokenWithMethodName:API_GETPROJECTLIST];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:[NetworkConfig sharedNetworkingConfig].publicParamters];
    [dict setObject:projectCode forKey:@"projectcode"];
    [dict setObject:projectName forKey:@"projectname"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_GETPROJECTLIST];
        request.httpMethod           = kXMHTTPMethodPOST;
        request.parameters =         dict;
        request.timeoutInterval      = 30;
        request.useGeneralHeaders    = YES;
        request.useGeneralServer     = YES;
        request.useGeneralParameters = NO;
    } onSuccess:^(id  _Nullable responseObject) {
        id responseObjectNoNull = [responseObject filterNullObject];
        int resultCode = [responseObjectNoNull[@"code"] intValue];
        id data = responseObjectNoNull[@"datas"];
        NSString *message = responseObjectNoNull[@"codedes"];
        block(resultCode,data,message,nil);
    } onFailure:^(NSError * _Nullable error) {
        block(-1,nil,nil,error);
    }];
}

+ (void)zx_httpClientToGetProjectEventsWithProjectId:(NSString *_Nullable)projectId andEventsStatus:(NSString *_Nullable)eventStatus andSuccessBlock:(responseBlock _Nullable )block{
    [NetworkConfig networkConfigTokenWithMethodName:API_GETEVENTS];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:[NetworkConfig sharedNetworkingConfig].publicParamters];
    [dict setObject:projectId forKey:@"projectid"];
    [dict setObject:eventStatus forKey:@"eventstatus"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_GETEVENTS];
        request.httpMethod           = kXMHTTPMethodPOST;
        request.parameters =         dict;
        request.timeoutInterval      = 30;
        request.useGeneralHeaders    = YES;
        request.useGeneralServer     = YES;
        request.useGeneralParameters = NO;
    } onSuccess:^(id  _Nullable responseObject) {
        id responseObjectNoNull = [responseObject filterNullObject];
        int resultCode = [responseObjectNoNull[@"code"] intValue];
        id data = responseObjectNoNull[@"datas"];
        NSString *message = responseObjectNoNull[@"codedes"];
        block(resultCode,data,message,nil);
    } onFailure:^(NSError * _Nullable error) {
        block(-1,nil,nil,error);
    }];
}

+ (void)zx_getAppNoticeinfoWithProjectid:(NSString *)projectId andEmployedId:(NSString *)employedId andPublishType:(NSString *)type andpublishLevel:(NSString *)level andSuccessBlock:(responseBlock)block{
    [NetworkConfig networkConfigTokenWithMethodName:API_GETAPPNOTICEINFO];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:[NetworkConfig sharedNetworkingConfig].publicParamters];
    [dict setObject:projectId forKey:@"projectid"];
    [dict setObject:employedId forKey:@"employerid"];
    [dict setObject:type forKey:@"publishtype"];
    [dict setObject:level forKey:@"publishlevel"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_GETAPPNOTICEINFO];
        request.httpMethod           = kXMHTTPMethodPOST;
        request.parameters =         dict;
        request.timeoutInterval      = 30;
        request.useGeneralHeaders    = YES;
        request.useGeneralServer     = YES;
        request.useGeneralParameters = NO;
    } onSuccess:^(id  _Nullable responseObject) {
        id responseObjectNoNull = [responseObject filterNullObject];
        int resultCode = [responseObjectNoNull[@"code"] intValue];
        id data = responseObjectNoNull[@"datas"];
        NSString *message = responseObjectNoNull[@"codedes"];
        block(resultCode,data,message,nil);
    } onFailure:^(NSError * _Nullable error) {
        block(-1,nil,nil,error);
    }];
}

+ (void)zx_httpClientToGetNotificationReadCountWithProjectid:(NSString *)projectid andEmployerid:(NSString *)employerid andSuccessBlock:(responseBlock)block{
    [NetworkConfig networkConfigTokenWithMethodName:API_GETAPPNOTICEREADCOUNT];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:[NetworkConfig sharedNetworkingConfig].publicParamters];
    [dict setObject:projectid forKey:@"projectid"];
    [dict setObject:employerid forKey:@"employerid"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_GETAPPNOTICEREADCOUNT];
        request.httpMethod           = kXMHTTPMethodPOST;
        request.parameters =         dict;
        request.timeoutInterval      = 30;
        request.useGeneralHeaders    = YES;
        request.useGeneralServer     = YES;
        request.useGeneralParameters = NO;
    } onSuccess:^(id  _Nullable responseObject) {
        id responseObjectNoNull = [responseObject filterNullObject];
        int resultCode = [responseObjectNoNull[@"code"] intValue];
        id data = responseObjectNoNull[@"datas"];
        NSString *message = responseObjectNoNull[@"codedes"];
        block(resultCode,data,message,nil);
    } onFailure:^(NSError * _Nullable error) {
        block(-1,nil,nil,error);
    }];
}

//工作流程
+ (void)zx_httpClientWorkFlowWithProject_id:(NSString *_Nullable)project_id andEmployedId:(NSString *_Nullable)employedId andSubmitmployer:(NSString *)submitemployer andEventType:(NSString *)type andBeginTime:(NSString *)beginTime andEndTime:(NSString *)endTime andEventName:(NSString *)eventName andEventRemark:(NSString *)eventMark andPhotoUrl:(NSString *)photoUrl andSubmitto:(NSString *)submitto{
    
}


+ (void)zx_httpClientToDutyEventlistWithProjectid:(NSString *_Nonnull)projectId andEmployerid:(NSString *_Nonnull)employerid  andFlowTaskStatus:(NSString *_Nonnull)taskStatus andSuccessBlock:(responseBlock _Nonnull )block{
    [NetworkConfig networkConfigTokenWithMethodName:API_GETDUTYEVENTLIST];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:[NetworkConfig sharedNetworkingConfig].publicParamters];
    [dict setObject:projectId forKey:@"projectid"];
    [dict setObject:employerid forKey:@"employerid"];
    [dict setObject:taskStatus forKey:@"flowtaskstatus"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_GETDUTYEVENTLIST];
        request.httpMethod           = kXMHTTPMethodPOST;
        request.parameters =         dict;
        request.timeoutInterval      = 30;
        request.useGeneralHeaders    = YES;
        request.useGeneralServer     = YES;
        request.useGeneralParameters = NO;
    } onSuccess:^(id  _Nullable responseObject) {
        id responseObjectNoNull = [responseObject filterNullObject];
        int resultCode = [responseObjectNoNull[@"code"] intValue];
        id data = responseObjectNoNull[@"datas"];
        NSString *message = responseObjectNoNull[@"codedes"];
        block(resultCode,data,message,nil);
    } onFailure:^(NSError * _Nullable error) {
            block(-1,nil,nil,error);
    }];
}

@end
