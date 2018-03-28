//
//  HttpClient+DutyEvents.m
//  ZXProject
//
//  Created by 刘清 on 2018/3/23.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "HttpClient+DutyEvents.h"
#import "NSNULL+Filtration.h"
#import "UserManager.h"
#import "ProjectManager.h"


@implementation HttpClient (DutyEvents)

+ (void)zx_httpClientToQueryNextStepApprvoPersonWithFlowType:(NSString *)type andEventId:(NSString *)eventId andFlowTaskId:(NSString *)flowtaskId andSuccessBlock:(responseBlock)block{
    [NetworkConfig networkConfigTokenWithMethodName:API_QUERYNEXTSTEPFLOW];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:[NetworkConfig sharedNetworkingConfig].publicParamters];
    [dict setObject:[ProjectManager sharedProjectManager].currentProjectid?[ProjectManager sharedProjectManager].currentProjectid:@"" forKey:@"projectid"];
    [dict setObject:[UserManager sharedUserManager].user.employerid?[UserManager sharedUserManager].user.employerid:@"" forKey:@"employerid"];
    [dict setObject:[UserManager sharedUserManager].user.employerid?[UserManager sharedUserManager].user.employerid:@"" forKey:@"eventemployerid"];
    [dict setObject:[UserManager sharedUserManager].user.employerid?[UserManager sharedUserManager].user.employerid:@"" forKey:@"submitemployer"];
    [dict setObject:type forKey:@"flowtype"];
    [dict setObject:eventId forKey:@"eventid"];
    [dict setObject:flowtaskId forKey:@"flowtaskid"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_QUERYNEXTSTEPFLOW];
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

+ (void)zx_httpClientToSubmitDutyEventWithEventType:(NSString *)eventType andBeginTime:(long long)beginTime andEndTime:(long long)endTime andEventName:(NSString *)eventName andEventMark:(NSString *)eventMark andPhotoUrl:(NSString *)photoUrl andSubmitto:(NSString *)submitto andSuccessBlock:(responseBlock)block{
    [NetworkConfig networkConfigTokenWithMethodName:API_SUBMITDUTYEVENT];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:[NetworkConfig sharedNetworkingConfig].publicParamters];
    [dict setObject:[ProjectManager sharedProjectManager].currentProjectid forKey:@"projectid"];
    [dict setObject:[UserManager sharedUserManager].user.employerid forKey:@"employerid"];
    [dict setObject:[UserManager sharedUserManager].user.employerid forKey:@"submitemployer"];
    [dict setObject:[NSString stringWithFormat:@"%lf",[[NSDate date] timeIntervalSince1970] ] forKey:@"apptime"];
    [dict setObject:eventType forKey:@"dutytype"];
    [dict setObject:@(beginTime) forKey:@"begintime"];
    [dict setObject:@(endTime) forKey:@"endtime"];
    [dict setObject:eventName forKey:@"eventname"];
    [dict setObject:eventMark forKey:@"eventremark"];
    [dict setObject:photoUrl forKey:@"photourl"];
    [dict setObject:submitto forKey:@"submitto"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_SUBMITDUTYEVENT];
        request.httpMethod           = kXMHTTPMethodGET;
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


+ (void)zx_httpClientToSubmitEvectionEventWithEventName:(NSString *)eventName andEventMark:(NSString *)eventMark andFromcity:(NSString *)fromcity andToCity:(NSString *)city andBeginTime:(long)beginTime andEndTime:(long)endTime andTransmode:(NSString *)transmode andSubmitto:(NSString *)submitto andSuccessBlock:(responseBlock)block{
    [NetworkConfig networkConfigTokenWithMethodName:API_SUBMITEVCATION];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:[NetworkConfig sharedNetworkingConfig].publicParamters];
    [dict setObject:[ProjectManager sharedProjectManager].currentProjectid forKey:@"projectid"];
    [dict setObject:[UserManager sharedUserManager].user.employerid forKey:@"employerid"];
    [dict setObject:[UserManager sharedUserManager].user.employerid forKey:@"submitemployer"];
    [dict setObject:fromcity forKey:@"fromcity"];
    [dict setObject:city forKey:@"tocity"];
    [dict setObject:@(beginTime) forKey:@"begintime"];
    [dict setObject:@(endTime) forKey:@"endtime"];
    [dict setObject:eventName forKey:@"eventname"];
    [dict setObject:eventMark forKey:@"eventremark"];
    [dict setObject:submitto forKey:@"submitto"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_SUBMITEVCATION];
        request.httpMethod           = kXMHTTPMethodGET;
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

+ (void)zx_httpClientToSubmitReimentEventWithFeetype:(NSString *)feetype andBeginTime:(long)beginTime andEndTime:(long)endTime andFeemoney:(NSString *)feemoney andEventName:(NSString *)eventName andEventMark:(NSString *)eventMark andPhotoUrl:(NSString *)url andSubmitto:(NSString *)submitto andSuccessBlock:(responseBlock)block{
    [NetworkConfig networkConfigTokenWithMethodName:API_SUBMITFEEEVENT];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:[NetworkConfig sharedNetworkingConfig].publicParamters];
    [dict setObject:[ProjectManager sharedProjectManager].currentProjectid forKey:@"projectid"];
    [dict setObject:[UserManager sharedUserManager].user.employerid forKey:@"employerid"];
    [dict setObject:[UserManager sharedUserManager].user.employerid forKey:@"submitemployer"];
    [dict setObject:@(beginTime) forKey:@"begintime"];
    [dict setObject:@(endTime) forKey:@"endtime"];
    [dict setObject:eventName forKey:@"eventname"];
    [dict setObject:eventMark forKey:@"eventremark"];
    [dict setObject:url forKey:@"photourl"];
    [dict setObject:submitto forKey:@"submitto"];
    [dict setObject:feetype forKey:@"feetype"];
    [dict setObject:feemoney forKey:@"feemoney"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_SUBMITFEEEVENT];
        request.httpMethod           = kXMHTTPMethodGET;
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

+ (void)zx_httpClientToSubmitReportWithReportType:(NSString *)reportType andEventName:(NSString *)eventName andEventMark:(NSString *)eventMark andPhotoUrl:(NSString *)photoUrl andSubmitto:(NSString *)submitto andSuccessBlock:(responseBlock)block{
    [NetworkConfig networkConfigTokenWithMethodName:API_SUBMITREPORTEVENT];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:[NetworkConfig sharedNetworkingConfig].publicParamters];
    [dict setObject:[ProjectManager sharedProjectManager].currentProjectid forKey:@"projectid"];
    [dict setObject:[UserManager sharedUserManager].user.employerid forKey:@"employerid"];
    [dict setObject:[UserManager sharedUserManager].user.employerid forKey:@"submitemployer"];
    [dict setObject:reportType forKey:@"reporttype"];
    [dict setObject:eventName forKey:@"eventname"];
    [dict setObject:eventMark forKey:@"eventremark"];
    [dict setObject:photoUrl forKey:@"photourl"];
    [dict setObject:submitto forKey:@"submitto"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_SUBMITREPORTEVENT];
        request.httpMethod           = kXMHTTPMethodGET;
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

+ (void)zx_httpClientToDutyCheckWithDutytype:(NSString *)dutytype andPositionAdress:(NSString *)positionAdress andPosition:(NSString *)posiotion andPhotoUrl:(NSString *)url andSuccessBlock:(responseBlock)block{
    [NetworkConfig networkConfigTokenWithMethodName:API_DUTYCHECK];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:[NetworkConfig sharedNetworkingConfig].publicParamters];
    [dict setObject:[ProjectManager sharedProjectManager].currentProjectid forKey:@"projectid"];
    [dict setObject:[UserManager sharedUserManager].user.employerid forKey:@"employerid"];
    [dict setObject:dutytype forKey:@"dutytype"];
    [dict setObject:positionAdress forKey:@"positionaddress"];
    [dict setObject:posiotion forKey:@"position"];
    [dict setObject:url forKey:@"photourl"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_DUTYCHECK];
        request.httpMethod           = kXMHTTPMethodGET;
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

+ (void)zx_httpClientToQueryDutyRuleWithWorkDateFormatter:(NSString *)formatter andSuccessBlock:(responseBlock)block{
    [NetworkConfig networkConfigTokenWithMethodName:API_DUTYRULE];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:[NetworkConfig sharedNetworkingConfig].publicParamters];
    [dict setObject:[ProjectManager sharedProjectManager].currentProjectid forKey:@"projectid"];
    [dict setObject:[UserManager sharedUserManager].user.employerid forKey:@"employerid"];
    [dict setObject:formatter forKey:@"workdate"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_DUTYRULE];
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

+ (void)zx_httpClientToInitWorkDateWithProjectId:(NSString *)projectid andSettingId:(NSString *)settingId andEmployerid:(NSString *)employerid andWorkdates:(NSString *)workDates andSuccessBlock:(responseBlock)block{
    [NetworkConfig networkConfigTokenWithMethodName:API_DUTYINIT];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:[NetworkConfig sharedNetworkingConfig].publicParamters];
    [dict setObject:projectid forKey:@"projectid"];
    [dict setObject:employerid forKey:@"employerids"];
    [dict setObject:settingId forKey:@"settingtypeid"];
    [dict setObject:workDates forKey:@"workdates"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_DUTYINIT];
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

+ (void)zx_httpClientToQueryProjectDutyWithBeginTime:(long)beginTime andEndTime:(long)time andSuccessBlock:(responseBlock)block{
    [NetworkConfig networkConfigTokenWithMethodName:API_PROJECTDUTYQUERY];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:[NetworkConfig sharedNetworkingConfig].publicParamters];
    [dict setObject:[ProjectManager sharedProjectManager].currentProjectid?[ProjectManager sharedProjectManager].currentProjectid:@"" forKey:@"projectid"];
    [dict setObject:[UserManager sharedUserManager].user.employerid?[UserManager sharedUserManager].user.employerid:@"" forKey:@"employerid"];
    [dict setObject:@(beginTime) forKey:@"begintime"];
    [dict setObject:@(time) forKey:@"endtime"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_PROJECTDUTYQUERY];
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
