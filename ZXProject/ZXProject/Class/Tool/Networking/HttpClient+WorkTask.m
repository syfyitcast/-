//
//  HttpClient+WorkTask.m
//  ZXProject
//
//  Created by Me on 2018/4/5.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "HttpClient+WorkTask.h"
#import "NSNULL+Filtration.h"
#import "ProjectManager.h"
#import "UserManager.h"

@implementation HttpClient (WorkTask)

+ (void)zx_httpClientToGetTaskListWithOrgtaskid:(long)orgtaskid andBegintime:(long)begintime andEndTime:(long)endTime andTaskdate:(NSString *)taskdate andOrgid:(long)orgid andRegionid:(long)regionid andSubmitemployerid:(long)submitemployerid andComfirmemployerid:(long)comfirmemployerid andTaskStatus:(long)taskStatus andSuccessBlock:(responseBlock)block{
    NSMutableDictionary *dict =  [NetworkConfig networkConfigTokenWithMethodName:API_GETTASKLIST];
    [dict setObject:[ProjectManager sharedProjectManager].currentProjectid?[ProjectManager sharedProjectManager].currentProjectid:@"" forKey:@"projectid"];
//    [dict setObject:@(orgtaskid) forKey:@"orgtaskid"];
//    [dict setObject:@(begintime) forKey:@"begintime"];
//    [dict setObject:@(endTime) forKey:@"endtime"];
//    [dict setObject:taskdate?taskdate:@"" forKey:@"taskdate"];
//    [dict setObject:@(orgid) forKey:@"orgid"];
//    [dict setObject:@(regionid) forKey:@"regionid"];
//    [dict setObject:@(submitemployerid) forKey:@"submitemployerid"];
//    [dict setObject:@(comfirmemployerid) forKey:@"comfirmemployerid"];
    if (taskStatus != 100) {
        [dict setObject:@(taskStatus) forKey:@"taskstatus"];
    }
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_GETTASKLIST];
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

+ (void)zx_httpClientToGetProjectRegionListWithSuccessBlock:(responseBlock)block{
    NSMutableDictionary *dict =  [NetworkConfig networkConfigTokenWithMethodName:API_GETPROJECTREGIONLIST];
    [dict setObject:[ProjectManager sharedProjectManager].currentProjectid?[ProjectManager sharedProjectManager].currentProjectid:@"" forKey:@"projectid"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_GETPROJECTREGIONLIST];
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

+ (void)zx_httpClientToGetWorkTaskPointProjectoRgregionWithPosition:(NSString *)position andSuccessBlock:(responseBlock)block{
    NSMutableDictionary *dict =  [NetworkConfig networkConfigTokenWithMethodName:API_GETPOINTPROJECTREGION];
    [dict setObject:[ProjectManager sharedProjectManager].currentProjectid?[ProjectManager sharedProjectManager].currentProjectid:@"" forKey:@"projectid"];
    [dict setObject:position forKey:@"position"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_GETPOINTPROJECTREGION];
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

+ (void)zx_httpClientToAddOrgTaskWithEventMark:(NSString *)eventMark andPosition:(NSString *)position andPositionaddress:(NSString *)positionaddress andRegionid:(long)regionid andOrgid:(long)orgid andIableemployerid:(long)iableemployerid andPhotoUrls:(NSString *)photoUrl andSoundUrls:(NSString *)soundUrl andVideoUrls:(NSString *)videoUrl andConfirmemployer:(NSString *)confirmemployer andTaskStatus:(NSString *)taskStatus andOrgTaskid:(NSString *)orgtaskid andSuccessBlock:(responseBlock)block{
    NSMutableDictionary *dict =  [NetworkConfig networkConfigTokenWithMethodName:API_ADDTASK];
    [dict setObject:[ProjectManager sharedProjectManager].currentProjectid?[ProjectManager sharedProjectManager].currentProjectid:@"" forKey:@"projectid"];
    [dict setObject:[UserManager sharedUserManager].user.employerid?[UserManager sharedUserManager].user.employerid:@"" forKey:@"employerid"];
    [dict setObject:eventMark forKey:@"taskcontent"];
    [dict setObject:positionaddress forKey:@"position"];
    [dict setObject:positionaddress forKey:@"positionaddress"];
    [dict setObject:@(regionid) forKey:@"regionid"];
    [dict setObject:@(orgid) forKey:@"orgid"];
    [dict setObject:@(iableemployerid) forKey:@"liableemployerid"];
    [dict setObject:photoUrl forKey:@"photourl"];
    [dict setObject:soundUrl forKey:@"soundurl"];
    [dict setObject:confirmemployer forKey:@"confirmemployer"];
    if ([taskStatus isEqualToString:@"99"]) {
         [dict setObject:taskStatus forKey:@"taskstatus"];
    }
    [dict setObject:orgtaskid forKey:@"orgtaskid"];
    [dict setObject:position forKey:@"position"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_ADDTASK];
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

+ (void)zx_httpClientToComfirmOrgTaskWithOrgtaskId:(long)orgtaskid andConfirmContent:(NSString *)confirmcontent andPhotoUrl:(NSString *)photoUrl andVideoUrl:(NSString *)videoUrl andSoundUrl:(NSString *)soundUrl andSuccessBlock:(responseBlock)block{
    NSMutableDictionary *dict =  [NetworkConfig networkConfigTokenWithMethodName:API_CONFIRMORGTASK];
    [dict setObject:[ProjectManager sharedProjectManager].currentProjectid?[ProjectManager sharedProjectManager].currentProjectid:@"" forKey:@"projectid"];
    [dict setObject:[UserManager sharedUserManager].user.employerid?[UserManager sharedUserManager].user.employerid:@"" forKey:@"employerid"]; 
    [dict setObject:@(orgtaskid) forKey:@"orgtaskid"];
    [dict setObject:confirmcontent forKey:@"confirmcontent"];
    [dict setObject:photoUrl forKey:@"photourl"];
    [dict setObject:videoUrl forKey:@"videourl"];
    [dict setObject:soundUrl forKey:@"soundurl"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_CONFIRMORGTASK];
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

@end
