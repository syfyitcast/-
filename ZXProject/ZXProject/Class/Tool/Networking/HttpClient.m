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
#import "ProjectManager.h"
#import "UserManager.h"

@interface HttpClient()


@end

@implementation HttpClient

+ (void)zx_httpClientToQueryDictWithDataType:(NSString *)dataType andDataCode:(NSString *)datacode andSuccessBlock:(responseBlock)block{
    NSMutableDictionary *dict = [NetworkConfig networkConfigTokenWithMethodName:API_QUERYDICT];
    [dict setObject:dataType forKey:@"datatype"];
    [dict setObject:[ProjectManager sharedProjectManager].currentProjectid?[ProjectManager sharedProjectManager].currentProjectid:@"" forKey:@"projectid"];
    [dict setObject:@"" forKey:@"companyid"];
    [dict setObject:datacode forKey:@"datacode"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_QUERYDICT];
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

+ (void)zx_httpClientToLoginWithUserName:(NSString *_Nullable)userName andPassword:(NSString *_Nullable)password andSuccessBlock:(responseBlock _Nullable )block{
    NSMutableDictionary *dict =  [NetworkConfig networkConfigTokenWithMethodName:API_LOGINPWD];
    [dict setObject:@"0" forKey:@"accountid"];
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
    NSMutableDictionary *dict =  [NetworkConfig networkConfigTokenWithMethodName:API_LOGINCODE];
    [dict setObject:@"0" forKey:@"accountid"];
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

+ (void)zx_httpClientToLogoutWithUserName:(NSString *)userName andSuccessBlock:(responseBlock)block{
    NSMutableDictionary *dict = [NetworkConfig networkConfigTokenWithMethodName:API_LOGOUT];
    [dict setObject:userName forKey:@"loginname"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_LOGOUT];
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
    NSMutableDictionary *dict = [NetworkConfig networkConfigTokenWithMethodName:API_GETCODE];
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
    NSMutableDictionary *dict = [NetworkConfig networkConfigTokenWithMethodName:API_REGISTER];
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
    NSMutableDictionary *dict = [NetworkConfig networkConfigTokenWithMethodName:API_FORGETPWD];
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
    NSMutableDictionary *dict =  [NetworkConfig networkConfigTokenWithMethodName:API_GETPROJECTLIST];
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

+ (void)zx_httpClientToProjectDetailWithProjectid:(NSString *_Nonnull)projectid andSuccessBlock:(responseBlock _Nonnull )block{
    NSMutableDictionary *dict =  [NetworkConfig networkConfigTokenWithMethodName:API_GETPROJECTDETAIL];
    [dict setObject:projectid forKey:@"projectid"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_GETPROJECTDETAIL];
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
    NSMutableDictionary *dict = [NetworkConfig networkConfigTokenWithMethodName:API_GETEVENTS];
    [dict setObject:projectId?projectId:@"" forKey:@"projectid"];
    if (![eventStatus isEqualToString:@"3"]) {
        [dict setObject:eventStatus?eventStatus:@"" forKey:@"eventstatus"];
    }
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

+ (void) zx_httpClientToGetOrgContactListWithProjectid:(NSString *)projectid andSuccessBlock:(responseBlock)block{
    NSMutableDictionary *dict = [NetworkConfig networkConfigTokenWithMethodName:API_GETORGCONTACTLIST];
    [dict setObject:projectid?projectid:@"" forKey:@"projectid"];
    [dict setObject:@(1) forKey:@"accounttype"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_GETORGCONTACTLIST];
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
    NSMutableDictionary *dict = [NetworkConfig networkConfigTokenWithMethodName:API_GETAPPNOTICEINFO];
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
    NSMutableDictionary *dict = [NetworkConfig networkConfigTokenWithMethodName:API_GETAPPNOTICEREADCOUNT];
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

+ (void)zx_httpClientToGetNoticeReaderlistWithNoticeid:(long)noticeid andSuccessBlock:(responseBlock)block{
    NSMutableDictionary *dict = [NetworkConfig networkConfigTokenWithMethodName:API_GETAPPREDLIST];
    [dict setObject:[ProjectManager sharedProjectManager].currentProjectid forKey:@"projectid"];
    [dict setObject:@(noticeid) forKey:@"noticeid"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_GETAPPREDLIST];
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
    NSMutableDictionary *dict = [NetworkConfig networkConfigTokenWithMethodName:API_GETDUTYEVENTLIST];
    [dict setObject:projectId?projectId:@"" forKey:@"projectid"];
    [dict setObject:employerid?employerid:@"" forKey:@"employerid"];
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
