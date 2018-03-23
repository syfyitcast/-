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
    [dict setObject:eventType forKey:@"eventtype"];
    [dict setObject:@(beginTime) forKey:@"begintime"];
    [dict setObject:@(endTime) forKey:@"endtime"];
    [dict setObject:eventName forKey:@"eventname"];
    [dict setObject:eventMark forKey:@"eventremark"];
    [dict setObject:photoUrl forKey:@"photourl"];
    [dict setObject:submitto forKey:@"submitto"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_SUBMITDUTYEVENT];
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
