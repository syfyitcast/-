//
//  HttpClient+Common.m
//  ZXProject
//
//  Created by Me on 2018/4/7.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "HttpClient+Common.h"
#import "NSNULL+Filtration.h"

@implementation HttpClient (Common)

+ (void)zx_httpCilentToGetWeatherWithCityName:(NSString *)cityName andSuccessBlock:(responseBlock)block{
    NSDictionary *paramters = @{
                                @"city":cityName
                                };
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = @"http://wthrcdn.etouch.cn/weather_mini";
        request.httpMethod           = kXMHTTPMethodGET;
        request.parameters =         paramters;
        request.timeoutInterval      = 30;
        request.useGeneralHeaders    = YES;
        request.useGeneralServer     = YES;
        request.useGeneralParameters = NO;
    } onSuccess:^(id  _Nullable responseObject) {
        id responseObjectNoNull = [responseObject filterNullObject];
        int resultCode = [responseObjectNoNull[@"status"] intValue];
        id data = responseObjectNoNull[@"data"];
        NSString *message = responseObjectNoNull[@"des"];
        block(resultCode,data,message,nil);
    } onFailure:^(NSError * _Nullable error) {
        block(-1,nil,nil,error);
    }];
}

+ (void)zx_httpCilentToGetWeatherWithPosition:(NSString *)position andSuccessBlock:(responseBlock)block{
    NSDictionary *paramters = @{
                                @"location":position,
                                @"output":@"json"
                                };
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = @"http://api.map.baidu.com/telematics/v3/weather";
        request.httpMethod           = kXMHTTPMethodGET;
        request.parameters =         paramters;
        request.timeoutInterval      = 30;
        request.useGeneralHeaders    = YES;
        request.useGeneralServer     = YES;
        request.useGeneralParameters = NO;
    } onSuccess:^(id  _Nullable responseObject) {
        id responseObjectNoNull = [responseObject filterNullObject];
        block(0,responseObjectNoNull,@"",nil);
    } onFailure:^(NSError * _Nullable error) {
        block(-1,nil,nil,error);
    }];
}

@end
