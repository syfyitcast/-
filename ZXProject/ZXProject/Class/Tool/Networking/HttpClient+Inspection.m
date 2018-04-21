//
//  HttpClient+Inspection.m
//  ZXProject
//
//  Created by 刘清 on 2018/4/18.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "HttpClient+Inspection.h"
#import "NSNULL+Filtration.h"
#import "ProjectManager.h"
#import "UserManager.h"

@implementation HttpClient (Inspection)

+ (void)zx_httpClinetToGetPatrolReportWithProjectId:(NSString *)projectid andPatroltstatus:(long)status andSuccessBlock:(responseBlock)block{
    NSMutableDictionary *dict =  [NetworkConfig networkConfigTokenWithMethodName:API_GETINSPECTION];
    [dict setObject:projectid?projectid:@"" forKey:@"projectid"];
    [dict setObject:@(status) forKey:@"patroltstatus"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_GETINSPECTION];
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

+ (void)zx_httpClinetToAddPatrolRecordWithPatrolTime:(long)patroltime andPosition:(NSString *)position andPositionAdress:(NSString *)positionAdress andRegionid:(long)regionid andOrgid:(long)orgid andLibleemplotyerid:(long)liableemployerid andPhotourl:(NSString *)photourl andSoundUrl:(NSString *)soudurl andPatrolName:(NSString *)patroltname andPatroltContent:(NSString *)patroltcontent andPatroltstatus:(long)patroltstatus andSuccessBlock:(responseBlock)block{
    NSMutableDictionary *dict =  [NetworkConfig networkConfigTokenWithMethodName:API_ADDINPECTION];
    [dict setObject:[ProjectManager sharedProjectManager].currentProjectid?[ProjectManager sharedProjectManager].currentProjectid:@"" forKey:@"projectid"];
    [dict setObject:[UserManager sharedUserManager].user.employerid?[UserManager sharedUserManager].user.employerid:@"" forKey:@"employerid"];
    [dict setObject:@"0" forKey:@"patroltname"];
    [dict setObject:patroltcontent forKey:@"patroltcontent"];
    [dict setObject:position forKey:@"position"];
    [dict setObject:positionAdress forKey:@"positionaddress"];
    [dict setObject:@(regionid) forKey:@"regionid"];
    [dict setObject:@(orgid) forKey:@"orgid"];
    [dict setObject:@(liableemployerid) forKey:@"liableemployerid"];
    [dict setObject:photourl forKey:@"photourl"];
    [dict setObject:soudurl forKey:@"soundurl"];
    [dict setObject:@(patroltime) forKey:@"patroltime"];
    [dict setObject:@(patroltstatus) forKey:@"patroltstatus"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_ADDINPECTION];
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

+ (void)zx_httpClinetToSwitchPatrolToEventWithPatrolRecordid:(long)patrolrecordid  andEventno:(long)eventno andEventType:(long)eventtype andIsvehneed:(int)isvehneed andLiableemployerid:(long)liableemployerid andSolveemployerid:(long)solveemployerid andUrgency:(long)urgency andSendsms:(int)sendsms andEventdescription:(NSString *)eventdescription andSuccessBlock:(responseBlock)block{
    NSMutableDictionary *dict =  [NetworkConfig networkConfigTokenWithMethodName:APT_INSPECTIONTOEVENT];
    [dict setObject:[ProjectManager sharedProjectManager].currentProjectid?[ProjectManager sharedProjectManager].currentProjectid:@"" forKey:@"projectid"];
    [dict setObject:@(patrolrecordid) forKey:@"patrolrecordid"];
    [dict setObject:@(eventno) forKey:@"eventno"];
    [dict setObject:@(eventtype) forKey:@"eventtype"];
    [dict setObject:@(isvehneed) forKey:@"isvehneed"];
    [dict setObject:@(liableemployerid) forKey:@"liableemployerid"];
    [dict setObject:@(solveemployerid) forKey:@"solveemployerid"];
    [dict setObject:@(urgency) forKey:@"urgency"];
    [dict setObject:@(sendsms) forKey:@"sendsms"];
    [dict setObject:eventdescription forKey:@"eventdescription"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:APT_INSPECTIONTOEVENT];
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
