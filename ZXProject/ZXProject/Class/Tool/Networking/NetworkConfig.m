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
#import "UserManager.h"
#import "ProjectManager.h"
#import "XMCenter.h"

NSString *const API_UPLOADFILE = @"getUploadFileUrl";//上传文件

NSString *const API_QUERYDICT = @"getdictionarydata";//字典查询
NSString *const API_LOGINPWD = @"checklogin";//登陆
NSString *const API_LOGINCODE = @"verificationcodelogin";//验证码登录
NSString *const API_LOGOUT = @"applogout";//登出
NSString *const API_GETCODE = @"getverificationcode";//获取短信验证码
NSString *const API_REGISTER = @"verificationcoderegiste";//注册
NSString *const API_FORGETPWD = @"verificationcodemodifypass";//忘记密码
NSString *const API_GETEVENTS = @"getprojectevents";//获取环卫事件
NSString *const API_GETAPPNOTICEINFO = @"appnoticeinfo";//获取通知公告
NSString *const API_GETAPPNOTICEREADCOUNT = @"noticenotreadcount";//获取app通知消息未阅读数
NSString *const API_GETPROJECTLIST = @"getprojectmanangerlist";//获取项目信息

#pragma mark 考勤  --------------------------------------------------------------
NSString *const API_GETDUTYEVENTLIST = @"myflowtasklist";//查询项目人员待审核考勤事件
NSString *const API_SUBMITDUTYEVENT = @"submitdutyevent";//提交考勤事件
NSString *const API_SUBMITFEEEVENT = @"submitfeeevent";//报销费用
NSString *const API_SUBMITEVCATION = @"submitbusitravelevent";//出差
NSString *const API_SUBMITREPORTEVENT = @"submitreportevent";//呈报
NSString *const API_QUERYNEXTSTEPFLOW = @"eventflownextstep";//查询流程任务下一环节审核人

NSString *const API_DUTYCHECK = @"projectdutycheck";//打卡
NSString *const API_DUTYRULE = @"employerdutysetting";//考勤规则
NSString *const API_DUTYINIT = @"initworkcalendar";//人员排班
NSString *const API_PROJECTDUTYQUERY = @"projectdutyquery";//项目人员考勤查询

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
        self.snid = @"";
        self.apiuser = @"appapi";
        self.accountid = @"";
        self.position = [NSString stringWithFormat:@"%f,%f",[UserLocationManager sharedUserLocationManager].currentCoordinate.latitude,[UserLocationManager sharedUserLocationManager].currentCoordinate.longitude];
        self.ipUrl = @"http://113.247.222.45:9080";
#if DEBUG
        self.baseUrl = @"http://113.247.222.45:9080/hjwulian/appservice/";
#else
        self.baseUrl = @"http://113.247.222.45:9080/hjwulian/appservice/";
#endif
    }
    return self;
}

#pragma mark - 配置方法

+ (NSString *)api:(NSString *)apiIdentifier{
    NetworkConfig *config = [NetworkConfig sharedNetworkingConfig];
    return [config.baseUrl stringByAppendingString:apiIdentifier];
}

+ (NSString *)appendPulicParamterWithApiUrl:(NSString *)apiUrl{
    NSMutableString *baseUrl = [[self api:apiUrl] stringByAppendingString:@"?"].mutableCopy;
    NetworkConfig *config = [NetworkConfig sharedNetworkingConfig];
    int i = 0;
    for (NSString *key in config.publicParamters.allKeys) {
        if (i == config.publicParamters.allKeys.count - 1) {
            [baseUrl appendString:[NSString stringWithFormat:@"%@=%@",key,config.publicParamters[key]]];
            return baseUrl;
        }
        [baseUrl appendString:[NSString stringWithFormat:@"%@=%@",key,config.publicParamters[key]]];
        [baseUrl appendString:@"&"];
         i ++;
    }
    return baseUrl;
}

#pragma mark - setter && getter

- (NSMutableDictionary *)publicParamters{
    if (_publicParamters == nil) {
        NSString *version =  [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
        _publicParamters = @{
                             @"apiuser":self.apiuser,
                             @"apptime":@(0),
                             @"appversion": [NSString stringWithFormat:@"iOS-%@",version]
                             }.mutableCopy;
        
    }
    return _publicParamters;
}

+ (void)networkConfigTokenWithMethodName:(NSString *)methodName{
    NetworkConfig *config = [NetworkConfig sharedNetworkingConfig];
    [config.publicParamters setObject:config.accountid forKey:@"accountid"];
    [config.publicParamters setObject:config.position forKey:@"position"];
    [config.publicParamters setObject:config.snid forKey:@"snid"];
    NSString *tokenString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",config.apiuser,config.snid,methodName,config.position,config.accountid,config.usertoken,MD5_ID];
    config.token = [Tool MD5ForLower32Bate:tokenString];
    [config.publicParamters setObject:config.token forKey:@"token"];
}

- (NSString *)position{
    return [NSString stringWithFormat:@"%f,%f",[UserLocationManager sharedUserLocationManager].currentCoordinate.latitude,[UserLocationManager sharedUserLocationManager].currentCoordinate.longitude];
}

- (NSString *)accountid{
    return [UserManager sharedUserManager].user.accountid?[UserManager sharedUserManager].user.accountid:@"";
}

- (NSString *)usertoken{
     return [UserManager sharedUserManager].user.usertoken?[UserManager sharedUserManager].user.usertoken:@"";
}

- (NSString *)snid{
    return [UserManager sharedUserManager].user.usertoken?[UserManager sharedUserManager].user.loginname:@"";
}

@end
