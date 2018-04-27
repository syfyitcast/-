//
//  HttpClient+Monitor.m
//  ZXProject
//
//  Created by 刘清 on 2018/4/26.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "HttpClient+Monitor.h"
#import "NSNULL+Filtration.h"

@implementation HttpClient (Monitor)

+ (void)zx_httpClientToGetProjectPersonInfoWithProjectid:(NSString *)projectid andSuccessBlock:(responseBlock)block{
    NSMutableDictionary *dict =  [NetworkConfig networkConfigTokenWithMethodName:API_MONITORPERSON];
    [dict setObject:projectid?projectid:@"" forKey:@"projectid"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_MONITORPERSON];
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

+ (void)zx_httpClientToGetProjectCarInfoWithProjectid:(NSString *)projectid andSuccessBlock:(responseBlock)block{
    NSMutableDictionary *dict =  [NetworkConfig networkConfigTokenWithMethodName:API_MONITORCAR];
    [dict setObject:projectid?projectid:@"" forKey:@"projectid"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_MONITORCAR];
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
