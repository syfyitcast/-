//
//  HttpClient+Device.m
//  ZXProject
//
//  Created by 刘清 on 2018/4/20.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "HttpClient+Device.h"
#import "NSNULL+Filtration.h"
#import "ProjectManager.h"
#import "UserManager.h"

@implementation HttpClient (Device)

+ (void)zx_httpClientToGetDeviceTypeListWithSuccessBlock:(responseBlock)block{
    NSMutableDictionary *dict =  [NetworkConfig networkConfigTokenWithMethodName:API_GETDEVICETYPELIST];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_GETDEVICETYPELIST];
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

+ (void)zx_httpClientToGetProjectDeviceInfoWithProjectid:(NSString *)projectid andSuccessBlock:(responseBlock)block{
    NSMutableDictionary *dict =  [NetworkConfig networkConfigTokenWithMethodName:API_GETDEVICEINFO];
    [dict setObject:projectid?projectid:@"" forKey:@"projectid"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_GETDEVICEINFO];
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

+ (void)zx_httpClientToAddfacilityWithFacilitycode:(NSString *)facilitycode andFacilityname:(NSString *)facilityname andFacilitytype:(NSString *)facilitytype andRfidtag:(NSString *)tag andPhotoUrl:(NSString *)photoUrl andPositionAdress:(NSString *)positionaddress andPositionlon:(double)positionlon andPositionlat:(double)positionlat andIsFocus:(int)isfocus
                                        andIsvideo:(int)isvideo andIspublic:(int)ispublic andSuccessBlock:(responseBlock)block{
    NSMutableDictionary *dict =  [NetworkConfig networkConfigTokenWithMethodName:API_ADDFACILITY];
    [dict setObject:[UserManager sharedUserManager].user.employerid?[UserManager sharedUserManager].user.employerid:@"" forKey:@"employerid"];
    [dict setObject:[ProjectManager sharedProjectManager].currentProjectid?[ProjectManager sharedProjectManager].currentProjectid:@"" forKey:@"projectid"];
    [dict setObject:facilitycode forKey:@"facilitycode"];
    [dict setObject:facilityname forKey:@"facilityname"];
    [dict setObject:facilitytype forKey:@"facilitytype"];
    [dict setObject:photoUrl forKey:@"photourl"];
    [dict setObject:positionaddress forKey:@"positionaddress"];
    [dict setObject:@(positionlon) forKey:@"positionlon"];
    [dict setObject:@(positionlat) forKey:@"positionlat"];
    [dict setObject:@(isfocus) forKey:@"isfocus"];
    [dict setObject:@(isvideo) forKey:@"isvideo"];
    [dict setObject:@(ispublic) forKey:@"ispublic"];
    [dict setObject:tag forKey:@"rfidtag"];
    [dict setObject:[ProjectManager sharedProjectManager].currentModel.projectid forKey:@"projectid"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_ADDFACILITY];
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
