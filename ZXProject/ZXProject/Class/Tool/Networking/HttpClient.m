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
        int resultCode = [responseObject[@"code"] intValue];
        id data = responseObject[@"datas"];
        NSString *message = responseObject[@"codedesc"];
        dispatch_async(dispatch_get_main_queue(), ^{
            block(resultCode,data,message,nil);
        });
    } onFailure:^(NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            block(-1,nil,nil,error);
        });
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
        int resultCode = [responseObject[@"code"] intValue];
        id data = responseObject[@"datas"];
        NSString *message = responseObject[@"codedesc"];
        dispatch_async(dispatch_get_main_queue(), ^{
            block(resultCode,data,message,nil);
        });
    } onFailure:^(NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            block(-1,nil,nil,error);
        });
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
        int resultCode = [responseObject[@"code"] intValue];
        id data = responseObject[@"datas"];
        NSString *message = responseObject[@"codedesc"];
        dispatch_async(dispatch_get_main_queue(), ^{
            block(resultCode,data,message,nil);
        });
    } onFailure:^(NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            block(-1,nil,nil,error);
        });
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
        int resultCode = [responseObject[@"code"] intValue];
        id data = responseObject[@"datas"];
        NSString *message = responseObject[@"codedesc"];
        dispatch_async(dispatch_get_main_queue(), ^{
             block(resultCode,data,message,nil);
        });
    } onFailure:^(NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            block(-1,nil,nil,error);
        });
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
        int resultCode = [responseObject[@"code"] intValue];
        id data = responseObject[@"datas"];
        NSString *message = responseObject[@"codedesc"];
        dispatch_async(dispatch_get_main_queue(), ^{
            block(resultCode,data,message,nil);
        });
    } onFailure:^(NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            block(-1,nil,nil,error);
        });
    }];
}

@end
