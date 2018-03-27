//
//  NetworkConfig.h
//  ZXProject
//
//  Created by Me on 2018/2/12.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MD5_ID  @"ed40065902934b4eb7f7bb12b20f1900"

extern NSString *const API_QUERYDICT;//字典查询
extern NSString *const API_LOGINPWD;//登录
extern NSString *const API_LOGOUT;//登出
extern NSString *const API_LOGINCODE;//验证码登录

extern NSString *const API_GETCODE;//获取短信验证码
extern NSString *const API_REGISTER;//注册
extern NSString *const API_FORGETPWD;//忘记密码

extern NSString *const API_GETEVENTS;//获取环卫事件
extern NSString *const API_GETAPPNOTICEINFO;//获取通知新闻
extern NSString *const API_GETAPPNOTICEREADCOUNT;//获取app通知消息未阅读数
extern NSString *const API_GETDUTYEVENTLIST;//获取待审核考勤事件
extern NSString *const API_GETPROJECTLIST;//获取项目列表

#pragma mark ---------------------------------------------------

extern NSString *const API_SUBMITDUTYEVENT;//提交考勤事件
extern NSString *const API_QUERYNEXTSTEPFLOW;//查询流程任务下一环节审核人

extern NSString *const API_DUTYCHECK;//打卡
extern NSString *const API_DUTYRULE;//考勤规则
extern NSString *const API_DUTYINIT;//人员排班
extern NSString *const API_PROJECTDUTYQUERY;//项目人员考勤查询


@interface NetworkConfig : NSObject

@property (nonatomic, copy) NSString *ipUrl;

@property (nonatomic, copy) NSString *baseUrl;
@property (nonatomic, strong) NSMutableDictionary *publicParamters; //公共参数
@property (nonatomic, copy) NSString *apiuser;//用户id
@property (nonatomic, copy) NSString *snid;//流水id
@property (nonatomic, copy) NSString *accountid;//账号id
@property (nonatomic, copy) NSString *position;//位置信息
@property (nonatomic, copy) NSString *token;//用户token
@property (nonatomic, copy) NSString *smsid;//短信验证码校验码
@property (nonatomic, copy) NSString *usertoken;




+ (instancetype)sharedNetworkingConfig;

+ (NSString *)api:(NSString *)apiIdentifier;

+ (void)networkConfigTokenWithMethodName:(NSString *)methodName;

@end
