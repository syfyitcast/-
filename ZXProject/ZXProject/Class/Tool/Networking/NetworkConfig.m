//
//  NetworkConfig.m
//  ZXProject
//
//  Created by Me on 2018/2/12.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "NetworkConfig.h"
#import "UserLocationManager.h"
#import "Tool+MD5.h"

NSString *const API_LOGINPWD = @"checklogin";//登陆
NSString *const API_LOGINCODE = @"verificationcodelogin";//验证码登录
NSString *const API_GETCODE = @"getverificationcode";//获取短信验证码
NSString *const API_REGISTER = @"verificationcoderegiste";//注册
NSString *const API_FORGETPWD = @"verificationcodemodifypass";//忘记密码

@implementation NetworkConfig

+ (instancetype)sharedNetworkingConfig{
    static NetworkConfig *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NetworkConfig alloc] init];
      
    });
    return instance;
}

- (instancetype)init{
    if (self = [super init]) {
        self.snid = @"0";
        self.apiuser = @"0";
        self.accountid = @"0";
        self.position = [NSString stringWithFormat:@"%f,%f",[UserLocationManager sharedUserLocationManager].currentCoordinate.latitude,[UserLocationManager sharedUserLocationManager].currentCoordinate.longitude];
#if DEBUG
        self.baseUrl = @"http://113.247.222.46:9080/hjwulian/appservice/";
#else
        
#endif
    }
    return self;
}

#pragma mark - 配置方法

+ (NSString *)api:(NSString *)apiIdentifier{
    NetworkConfig *config = [NetworkConfig sharedNetworkingConfig];
    return [config.baseUrl stringByAppendingString:apiIdentifier];
}

#pragma mark - setter && getter

- (NSMutableDictionary *)publicParamters{
    if (_publicParamters == nil) {
        _publicParamters = @{
                             @"apiuser":self.apiuser,
                             @"snid":self.snid,
                             @"position":self.position,
                             @"accountid":self.accountid,
                             @"apptime":@(0)
                             }.mutableCopy;
    }
    return _publicParamters;
}

+ (void)networkConfigTokenWithMethodName:(NSString *)methodName{
    NetworkConfig *config = [NetworkConfig sharedNetworkingConfig];
    NSString *tokenString = [NSString stringWithFormat:@"%@%@%@%@%@%@",config.apiuser,config.snid,methodName,config.position,config.accountid,MD5_ID];
    config.token = [Tool MD5ForLower32Bate:tokenString];
    [config.publicParamters setObject:config.token forKey:@"token"];
}

@end
