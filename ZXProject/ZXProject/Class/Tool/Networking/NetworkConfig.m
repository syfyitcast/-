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
NSString *const API_GETEVENTS = @"eventassignlist";//获取环卫事件
NSString *const API_GETAPPNOTICEINFO = @"appnoticeinfo";//获取通知公告
NSString *const API_GETAPPNOTICEREADCOUNT = @"noticenotreadcount";//获取app通知消息未阅读数
NSString *const API_GETAPPREDLIST  = @"noticereaderlist";//获取消息阅读列表
NSString *const API_GETPROJECTLIST = @"getprojectmanangerlist";//获取项目信息
NSString *const API_GETPROJECTDETAIL = @"getprojectdetail";//获取项目详细信息
NSString *const API_GETORGCONTACTLIST = @"getprojectorglist";//获取通讯录

#pragma mark 考勤  --------------------------------------------------------------
NSString *const API_GETEVENTLIST = @"eventlist";//查询事件由自己发起的
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

NSString *const API_QUERYEVENTFLOWTASKLIST = @"eventflowtasklist";//查询事件流程任务列表
NSString *const API_QUERYDUTYEVNET = @"getdutyevent";//查询请假事件
NSString *const API_QUERYEVACATION = @"getbusitravelevent";//查询出差事件
NSString *const API_QUERYREMIMENT  = @"getfeeevent";//查询报销事件
NSString *const API_QUERYREPORT    = @"getreportevent";//查询呈报事件
NSString *const API_COMFIRMFLOWTASK = @"confirmflowtask";//流程任务确认
NSString *const API_DELETEFLOWEVENT = @"deleteflowevent";//删除流程任务

#pragma mark --------------------------------------------------------------  环卫作业

NSString *const API_GETTASKLIST  = @"orgtasklist";//获取工作列表
NSString *const API_GETPOINTPROJECTREGION = @"pointprojectorgregion";//获取所在的环卫作业区域
NSString *const API_GETPROJECTREGIONLIST = @"projectorgregionlist";//获取项目区域列表
NSString *const API_ADDTASK = @"addorgtask";//新增工作事件
NSString *const API_ADDEVENT = @"addpatrolevent";//新增项目环卫事件
NSString *const API_CONFIRMORGTASK = @"confirmorgtask";//完成环卫工作项
NSString *const API_CONFIRMEVNTASSIGN = @"confirmeventassign";//完成事件派单

#pragma mark --------------------------------------------------------------- 巡检任务

NSString *const API_GETINSPECTION = @"patrolrecordlist";//项目巡检报告查询
NSString *const API_ADDINPECTION = @"addpatrolrecord";//新增巡检记录;
NSString *const APT_INSPECTIONTOEVENT = @"patrolrecordtoevent";//巡检记录生成环卫事件

#pragma mark ---------------------------------------------------------------- 设备管理

NSString *const API_GETDEVICEINFO = @"getfacilitylocation";//项目设施列表
NSString *const API_GETDEVICETYPELIST = @"getfacilitytype";//获取设施类型
NSString *const API_ADDFACILITY  = @"addfacility";//获取项目设施
NSString *const API_MODIFYFACILITY = @"modifyfacility";//修改项目设施

#pragma mark ----------------------------------------------------------------- 在线监控

NSString *const API_MONITORPERSON = @"getemployeelocation";//项目人员查询
NSString *const API_MONITORCAR = @"getvehiclelocation";//项目车辆查询

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
        self.position = [NSString stringWithFormat:@"%f,%f",[UserLocationManager sharedUserLocationManager].currentCoordinate.longitude,[UserLocationManager sharedUserLocationManager].currentCoordinate.latitude];
        self.ipUrl = @"http://113.247.222.45:9080";//8088
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

+ (NSString *)appendPulicParamterWithApiUrl:(NSString *)apiUrl withDict:(NSDictionary *)dict{
    NSMutableString *baseUrl = [[self api:apiUrl] stringByAppendingString:@"?"].mutableCopy;
    int i = 0;
    for (NSString *key in dict.allKeys) {
        if (i == dict.allKeys.count - 1) {
            [baseUrl appendString:[NSString stringWithFormat:@"%@=%@",key,dict[key]]];
            return baseUrl;
        }
        [baseUrl appendString:[NSString stringWithFormat:@"%@=%@",key,dict[key]]];
        [baseUrl appendString:@"&"];
         i ++;
    }
    return baseUrl;
}

#pragma mark - setter && getter

+ (NSMutableDictionary *)networkConfigTokenWithMethodName:(NSString *)methodName{
    NetworkConfig *config = [NetworkConfig sharedNetworkingConfig];
    NSString *version =  [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSMutableDictionary *dict =@{
                                @"apiuser":config.apiuser,
                                @"apptime":@(0),
                                @"appversion": [NSString stringWithFormat:@"iOS-%@",version]
                                }.mutableCopy;
    
    [dict setObject:config.accountid forKey:@"accountid"];
    [dict setObject:config.position forKey:@"position"];
    [dict setObject:config.snid forKey:@"snid"];
    NSString *tokenString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",config.apiuser,config.snid,methodName,config.position,config.accountid,config.usertoken,MD5_ID];
    [dict setObject:[Tool MD5ForLower32Bate:tokenString] forKey:@"token"];
    return dict;
}

- (NSString *)position{
    return [NSString stringWithFormat:@"%f,%f",[UserLocationManager sharedUserLocationManager].currentCoordinate.longitude,[UserLocationManager sharedUserLocationManager].currentCoordinate.latitude];
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
