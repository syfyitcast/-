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


+ (void)zx_httpClientToQueryEventListBySelfWithEventStatus:(NSString *)eventStatus andFlowtype:(NSString *)flowtype andSuccessBlock:(responseBlock)block{
    NSMutableDictionary *dict = [NetworkConfig networkConfigTokenWithMethodName:API_GETEVENTLIST];
    [dict setObject:[ProjectManager sharedProjectManager].currentProjectid?[ProjectManager sharedProjectManager].currentProjectid:@"" forKey:@"projectid"];
    [dict setObject:[UserManager sharedUserManager].user.employerid?[UserManager sharedUserManager].user.employerid:@"" forKey:@"employerid"];
    [dict setObject:flowtype forKey:@"flowtype"];
    [dict setObject:eventStatus forKey:@"eventstatus"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_GETEVENTLIST];
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

+ (void)zx_httpClientToQueryNextStepApprvoPersonWithFlowType:(NSString *)type andEventId:(NSString *)eventId andFlowTaskId:(NSString *)flowtaskId andSuccessBlock:(responseBlock)block{
    NSMutableDictionary *dict = [NetworkConfig networkConfigTokenWithMethodName:API_QUERYNEXTSTEPFLOW];
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
    NSMutableDictionary *dict =  [NetworkConfig networkConfigTokenWithMethodName:API_SUBMITDUTYEVENT];
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
    NSMutableDictionary *dict = [NetworkConfig networkConfigTokenWithMethodName:API_SUBMITEVCATION];
    [dict setObject:[ProjectManager sharedProjectManager].currentProjectid forKey:@"projectid"];
    [dict setObject:[UserManager sharedUserManager].user.employerid forKey:@"employerid"];
    [dict setObject:[UserManager sharedUserManager].user.employerid forKey:@"submitemployer"];
    [dict setObject:fromcity forKey:@"fromcity"];
    [dict setObject:city forKey:@"tocity"];
    [dict setObject:@(beginTime) forKey:@"begintime"];
    [dict setObject:@(endTime) forKey:@"endtime"];
    [dict setObject:eventName forKey:@"eventname"];
    [dict setObject:eventMark forKey:@"eventremark"];
    [dict setObject:transmode forKey:@"transmode"];
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
    NSMutableDictionary *dict = [NetworkConfig networkConfigTokenWithMethodName:API_SUBMITFEEEVENT];
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
    NSMutableDictionary *dict = [NetworkConfig networkConfigTokenWithMethodName:API_SUBMITREPORTEVENT];
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
    NSMutableDictionary *dict = [NetworkConfig networkConfigTokenWithMethodName:API_DUTYCHECK];
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
    NSMutableDictionary *dict = [NetworkConfig networkConfigTokenWithMethodName:API_DUTYRULE];
    [dict setObject:[ProjectManager sharedProjectManager].currentProjectid?[ProjectManager sharedProjectManager].currentProjectid:@"" forKey:@"projectid"];
    [dict setObject:[UserManager sharedUserManager].user.employerid?[UserManager sharedUserManager].user.employerid :@"" forKey:@"employerid"];
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
    NSMutableDictionary *dict = [NetworkConfig networkConfigTokenWithMethodName:API_DUTYINIT];
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
    NSMutableDictionary *dict = [NetworkConfig networkConfigTokenWithMethodName:API_PROJECTDUTYQUERY];
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

+ (void)zx_httpClientToQueryDutyEventsWithEventId:(long)eventid andFlowType:(long)flowType  andSuccessBlock:(responseBlock)block{
    NSString *api = @"";
    switch (flowType) {
        case 1://请假
            api = API_QUERYDUTYEVNET;
            break;
        case 2://报销
            api = API_QUERYREMIMENT;
            break;
        case 3:
            api = API_QUERYREPORT;
            break;
        case 4:
            api = API_QUERYEVACATION;
            break;
        default:
            break;
    }
    NSMutableDictionary *dict =  [NetworkConfig networkConfigTokenWithMethodName:api];
    [dict setObject:[ProjectManager sharedProjectManager].currentProjectid?[ProjectManager sharedProjectManager].currentProjectid:@"" forKey:@"projectid"];
    [dict setObject:@(eventid) forKey:@"eventid"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:api];
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
        NSArray *keyDicts = responseObjectNoNull[@"metadatas"];
        NSDictionary *dict = keyDicts.lastObject;
        NSString *key = dict[@"metadataname"];
        NSString *message = responseObjectNoNull[@"codedes"];
        block(resultCode,data[key],message,nil);
    } onFailure:^(NSError * _Nullable error) {
        block(-1,nil,nil,error);
    }];
}

+ (void)zx_httpClientToQueryEventFlowTasklistWithEventid:(int)eventid andflowtype:(int)flowtype andSuccessBlock:(responseBlock)block{
    NSMutableDictionary *dict = [NetworkConfig networkConfigTokenWithMethodName:API_QUERYEVENTFLOWTASKLIST];
    [dict setObject:[ProjectManager sharedProjectManager].currentProjectid?[ProjectManager sharedProjectManager].currentProjectid:@"" forKey:@"projectid"];
    [dict setObject:@(eventid) forKey:@"eventid"];
    [dict setObject:@(flowtype) forKey:@"flowtype"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_QUERYEVENTFLOWTASKLIST];
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
        NSArray *keyDicts = responseObjectNoNull[@"metadatas"];
        NSDictionary *dict = keyDicts.lastObject;
        NSString *key = dict[@"metadataname"];
        NSString *message = responseObjectNoNull[@"codedes"];
        block(resultCode,data[key],message,nil);
    } onFailure:^(NSError * _Nullable error) {
        block(-1,nil,nil,error);
    }];
}

+ (void)zx_httpClientToConfirmflowtaskWithEventFlowid:(long)eventFlowid andFlowtaskid:(long)flowTaskid andCheckOpion:(NSString *)checkOpion andSubmitto:(long)submitto andSubmittype:(long)type andSuccessBlock:(responseBlock)block{
    NSMutableDictionary *dict = [NetworkConfig networkConfigTokenWithMethodName:API_COMFIRMFLOWTASK];
    [dict setObject:[ProjectManager sharedProjectManager].currentProjectid?[ProjectManager sharedProjectManager].currentProjectid:@"" forKey:@"projectid"];
     [dict setObject:[UserManager sharedUserManager].user.employerid?[UserManager sharedUserManager].user.employerid:@"" forKey:@"employerid"];
    [dict setObject:@(eventFlowid) forKey:@"eventflowid"];
    [dict setObject:@(flowTaskid) forKey:@"flowtaskid"];
    [dict setObject:checkOpion forKey:@"checkopion"];
    [dict setObject:@(submitto) forKey:@"submitto"];
    [dict setObject:@(type) forKey:@"submittype"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_COMFIRMFLOWTASK];
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
        NSArray *keyDicts = responseObjectNoNull[@"metadatas"];
        NSDictionary *dict = keyDicts.lastObject;
        NSString *key = dict[@"metadataname"];
        NSString *message = responseObjectNoNull[@"codedes"];
        block(resultCode,data[key],message,nil);
    } onFailure:^(NSError * _Nullable error) {
        block(-1,nil,nil,error);
    }];
}

+ (void)zx_httpClientToDeleteFlowEventWithEventid:(long)eventid andFlowtype:(long)flowtype andSuccessBlock:(responseBlock)block{
    NSMutableDictionary *dict =  [NetworkConfig networkConfigTokenWithMethodName:API_DELETEFLOWEVENT];
    [dict setObject:[ProjectManager sharedProjectManager].currentProjectid?[ProjectManager sharedProjectManager].currentProjectid:@"" forKey:@"projectid"];
    [dict setObject:[UserManager sharedUserManager].user.employerid?[UserManager sharedUserManager].user.employerid:@"" forKey:@"employerid"];
    [dict setObject:@(eventid) forKey:@"eventid"];
    [dict setObject:@(flowtype) forKey:@"flowtype"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_DELETEFLOWEVENT];
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
        NSArray *keyDicts = responseObjectNoNull[@"metadatas"];
        NSDictionary *dict = keyDicts.lastObject;
        NSString *key = dict[@"metadataname"];
        NSString *message = responseObjectNoNull[@"codedes"];
        block(resultCode,data[key],message,nil);
    } onFailure:^(NSError * _Nullable error) {
        block(-1,nil,nil,error);
    }];
}


@end
