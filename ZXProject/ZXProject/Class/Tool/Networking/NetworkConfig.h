//
//  NetworkConfig.h
//  ZXProject
//
//  Created by Me on 2018/2/12.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MD5_ID  @"ed40065902934b4eb7f7bb12b20f1900"


extern NSString *const API_UPLOADFILE;//上传文件

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
extern NSString *const API_GETPROJECTDETAIL;//获取项目详细信息
extern NSString *const API_GETORGCONTACTLIST;//获取项目通讯录

#pragma mark ---------------------------------------------------

extern NSString *const API_GETEVENTLIST;//查询事件由自己发起的
extern NSString *const API_SUBMITDUTYEVENT;//提交考勤事件
extern NSString *const API_SUBMITFEEEVENT;//报销费用
extern NSString *const API_SUBMITEVCATION;//出差
extern NSString *const API_SUBMITREPORTEVENT;//呈报
extern NSString *const API_QUERYNEXTSTEPFLOW;//查询流程任务下一环节审核人

extern NSString *const API_DUTYCHECK;//打卡
extern NSString *const API_DUTYRULE;//考勤规则
extern NSString *const API_DUTYINIT;//人员排班
extern NSString *const API_PROJECTDUTYQUERY;//项目人员考勤查询

extern NSString *const API_QUERYEVENTFLOWTASKLIST;//查询事件流程任务列表
extern NSString *const API_QUERYDUTYEVNET;//查询请假事件
extern NSString *const API_QUERYEVACATION;//查询出差事件
extern NSString *const API_QUERYREMIMENT;//查询报销事件
extern NSString *const API_QUERYREPORT;//查询呈报事件
extern NSString *const API_COMFIRMFLOWTASK;//流程任务确认
extern NSString *const API_DELETEFLOWEVENT;//删除流程任务

extern NSString *const API_GETTASKLIST;//获取工作列表
extern NSString *const API_GETPOINTPROJECTREGION;//获取所在的环卫作业区域
extern NSString *const API_GETPROJECTREGIONLIST;//获取项目作业区域列表
extern NSString *const API_ADDTASK;//新增工作事件
extern NSString *const API_ADDEVENT;//新增环卫事件
extern NSString *const API_CONFIRMORGTASK;//完成环卫工作项
extern NSString *const API_CONFIRMEVNTASSIGN;//完成事件派单


@interface NetworkConfig : NSObject

@property (nonatomic, copy) NSString *ipUrl;

@property (nonatomic, copy) NSString *baseUrl;
@property (nonatomic, copy) NSString *apiuser;//用户id
@property (nonatomic, copy) NSString *snid;//流水id
@property (nonatomic, copy) NSString *accountid;//账号id
@property (nonatomic, copy) NSString *position;//位置信息
@property (nonatomic, copy) NSString *token;//用户token
@property (nonatomic, copy) NSString *smsid;//短信验证码校验码
@property (nonatomic, copy) NSString *usertoken;


@property (nonatomic, strong) NSMutableData *responseData;




+ (instancetype)sharedNetworkingConfig;

+ (NSString *)api:(NSString *)apiIdentifier;

+ (NSMutableDictionary *)networkConfigTokenWithMethodName:(NSString *)methodName;

+ (NSString *)appendPulicParamterWithApiUrl:(NSString *)apiUrl withDict:(NSDictionary *)dict;

@end
