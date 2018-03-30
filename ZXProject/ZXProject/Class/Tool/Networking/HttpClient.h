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

//字典查询
+ (void)zx_httpClientToQueryDictWithDataType:(NSString *)dataType andDataCode:(NSString *)datacode andSuccessBlock:(responseBlock _Nonnull )block;

//用户密码登录
+ (void)zx_httpClientToLoginWithUserName:(NSString *_Nullable)userName andPassword:(NSString *_Nullable)password andSuccessBlock:(responseBlock _Nullable )block;

//用户短信验证码登录
+ (void)zx_httpClientToLoginWithUserName:(NSString *_Nullable)userName andVerifyCode:(NSString *_Nullable)VerifyCode andSmsid:(NSString *_Nullable)smsid andSuccessBlock:(responseBlock _Nullable )block;

//登出
+ (void)zx_httpClientToLogoutWithUserName:(NSString *_Nonnull)userName andSuccessBlock:(responseBlock _Nonnull )block;

//获取短信验证码
+ (void)zx_httpClientToGetVerifyCodeWithType:(int)type andMobile:(NSString *_Nullable)mobile andSuccessBlock:(responseBlock _Nullable )block;

//注册
+ (void)zx_httpClientToRegisterWithMobile:(NSString *_Nullable)mobile andSmcontent:(NSString *_Nullable)content andSmsid:(NSString *_Nullable)smsid andPassword:(NSString * _Nullable)password andSuccessBlock:(responseBlock _Nullable)block;

//修改密码
+ (void)zx_httpClientToForgetPasswordWithMobile:(NSString *_Nullable)mobile andVerifyCode:(NSString *_Nullable)code andSmsid:(NSString *_Nullable)smsid andNewPassword:(NSString *_Nullable)password andSuccessBlock:(responseBlock _Nullable )block;


//项目信息列表
+ (void)zx_httpClientToGetProjectListWithProjectCode:(NSString *_Nonnull)projectCode andProjectName:(NSString *_Nonnull)projectName andSuccessBlock:(responseBlock _Nonnull )block;


//获取环卫事件
+ (void)zx_httpClientToGetProjectEventsWithProjectId:(NSString *_Nullable)projectId andEventsStatus:(NSString *_Nullable)eventStatus andSuccessBlock:(responseBlock _Nullable )block;

//获取通知公告
+ (void)zx_getAppNoticeinfoWithProjectid:(NSString *_Nonnull)projectId andEmployedId:(NSString *_Nullable)employedId andPublishType:(NSString *_Nonnull)type andpublishLevel:(NSString *_Nonnull)level andSuccessBlock:(responseBlock _Nullable )block;

//获取通知消息未阅读数
+ (void)zx_httpClientToGetNotificationReadCountWithProjectid:(NSString *_Nonnull)projectid_Nonnull andEmployerid:(NSString *_Nonnull)employerid andSuccessBlock:(responseBlock _Nonnull )block;

//工作流程
+ (void)zx_httpClientWorkFlowWithProject_id:(NSString *_Nullable)project_id andEmployedId:(NSString *_Nullable)employedId andSubmitmployer:(NSString *_Nonnull)submitemployer andEventType:(NSString *_Nonnull)type andBeginTime:(NSString *_Nonnull)beginTime andEndTime:(NSString *_Nonnull)endTime andEventName:(NSString *_Nonnull)eventName andEventRemark:(NSString *_Nonnull)eventMark andPhotoUrl:(NSString *_Nonnull)photoUrl andSubmitto:(NSString *_Nonnull)submitto;

//待审核考勤事件
+ (void)zx_httpClientToDutyEventlistWithProjectid:(NSString *_Nonnull)projectId andEmployerid:(NSString *_Nonnull)employerid  andFlowTaskStatus:(NSString *_Nonnull)taskStatus andSuccessBlock:(responseBlock _Nonnull )block;

@end
