//
//  HttpClient.h
//  ZXProject
//
//  Created by Me on 2018/2/12.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMNetworking.h"
#import "NetworkConfig.h"



typedef void (^responseBlock)( int  code, id _Nullable data, NSString * _Nullable message, NSError * _Nullable error);

@interface HttpClient : NSObject

//用户密码登录
+ (void)zx_httpClientToLoginWithUserName:(NSString *_Nullable)userName andPassword:(NSString *_Nullable)password andSuccessBlock:(responseBlock _Nullable )block;

//用户短信验证码登录
+ (void)zx_httpClientToLoginWithUserName:(NSString *_Nullable)userName andVerifyCode:(NSString *_Nullable)VerifyCode andSmsid:(NSString *_Nullable)smsid andSuccessBlock:(responseBlock _Nullable )block;

//获取短信验证码
+ (void)zx_httpClientToGetVerifyCodeWithType:(int)type andMobile:(NSString *_Nullable)mobile andSuccessBlock:(responseBlock _Nullable )block;

//注册
+ (void)zx_httpClientToRegisterWithMobile:(NSString *_Nullable)mobile andSmcontent:(NSString *_Nullable)content andSmsid:(NSString *_Nullable)smsid andPassword:(NSString * _Nullable)password andSuccessBlock:(responseBlock _Nullable)block;

//修改密码
+ (void)zx_httpClientToForgetPasswordWithMobile:(NSString *_Nullable)mobile andVerifyCode:(NSString *_Nullable)code andSmsid:(NSString *_Nullable)smsid andNewPassword:(NSString *_Nullable)password andSuccessBlock:(responseBlock _Nullable )block;

//获取环卫事件
+ (void)zx_httpClientToGetProjectEventsWithProjectId:(NSString *_Nullable)projectId andEventsStatus:(NSString *_Nullable)eventStatus andSuccessBlock:(responseBlock _Nullable )block;

@end
