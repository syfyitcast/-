//
//  NetworkConfig.h
//  ZXProject
//
//  Created by Me on 2018/2/12.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MD5_ID  @"ZXHW_IOS"

extern NSString *const API_LOGINPWD;//登录
extern NSString *const API_LOGINCODE;//验证码登录

extern NSString *const API_GETCODE;//获取短信验证码
extern NSString *const API_REGISTER;//注册
extern NSString *const API_FORGETPWD;//忘记密码

@interface NetworkConfig : NSObject

@property (nonatomic, copy) NSString *baseUrl;
@property (nonatomic, strong) NSMutableDictionary *publicParamters; //公共参数
@property (nonatomic, copy) NSString *apiuser;//用户id
@property (nonatomic, copy) NSString *snid;//流水id
@property (nonatomic, copy) NSString *accountid;//账号id
@property (nonatomic, copy) NSString *position;//位置信息
@property (nonatomic, copy) NSString *token;//用户token
@property (nonatomic, copy) NSString *smsid;//短信验证码校验码

+ (instancetype)sharedNetworkingConfig;

+ (NSString *)api:(NSString *)apiIdentifier;

+ (void)networkConfigTokenWithMethodName:(NSString *)methodName;

@end