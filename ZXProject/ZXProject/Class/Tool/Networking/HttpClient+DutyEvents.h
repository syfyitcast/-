//
//  HttpClient+DutyEvents.h
//  ZXProject
//
//  Created by 刘清 on 2018/3/23.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "HttpClient.h"

@interface HttpClient (DutyEvents)

//流程由自己发起
+ (void)zx_httpClientToQueryEventListBySelfWithEventStatus:(NSString *)eventStatus andFlowtype:(NSString *)flowtype andSuccessBlock:(responseBlock)block;

//查询下一步审核人
+ (void)zx_httpClientToQueryNextStepApprvoPersonWithFlowType:(NSString *)type andEventId:(NSString *)eventId andFlowTaskId:(NSString *)flowtaskId andSuccessBlock:(responseBlock)block;

//提交请假审核流程
+ (void)zx_httpClientToSubmitDutyEventWithEventType:(NSString *)eventType andBeginTime:(long long)beginTime andEndTime:(long long)endTime andEventName:(NSString *)eventName andEventMark:(NSString *)eventMark andPhotoUrl:(NSString *)photoUrl andSubmitto:(NSString *)submitto andSuccessBlock:(responseBlock)block;

//出差
+ (void)zx_httpClientToSubmitEvectionEventWithEventName:(NSString *)eventName andEventMark:(NSString *)eventMark andFromcity:(NSString *)fromcity andToCity:(NSString *)city andBeginTime:(long)beginTime andEndTime:(long)endTime andTransmode:(NSString *)transmode andSubmitto:(NSString *)submitto andSuccessBlock:(responseBlock)block;

 //报销费用
+ (void)zx_httpClientToSubmitReimentEventWithFeetype:(NSString *)feetype andBeginTime:(long)beginTime andEndTime:(long)endTime andFeemoney:(NSString *)feemoney andEventName:(NSString *)eventName andEventMark:(NSString *)eventMark andPhotoUrl:(NSString *)url andSubmitto:(NSString *)submitto andSuccessBlock:(responseBlock)block;
//呈报
+ (void)zx_httpClientToSubmitReportWithReportType:(NSString *)reportType andEventName:(NSString *)eventName andEventMark:(NSString *)eventMark andPhotoUrl:(NSString *)photoUrl andSubmitto:(NSString *)submitto andSuccessBlock:(responseBlock)block;

//考勤打卡
+ (void)zx_httpClientToDutyCheckWithDutytype:(NSString *)dutytype andPositionAdress:(NSString *)positionAdress andPosition:(NSString *)posiotion andPhotoUrl:(NSString *)url andSuccessBlock:(responseBlock)block;

//查询考勤规则
+ (void)zx_httpClientToQueryDutyRuleWithWorkDateFormatter:(NSString *)formatter andSuccessBlock:(responseBlock)block;

//人员排班
+ (void)zx_httpClientToInitWorkDateWithProjectId:(NSString *)projectid andSettingId:(NSString *)settingId andEmployerid:(NSString *)employerid andWorkdates:(NSString *)workDates andSuccessBlock:(responseBlock)block;

//项目人员考勤查询
+ (void)zx_httpClientToQueryProjectDutyWithBeginTime:(long)beginTime andEndTime:(long)time andSuccessBlock:(responseBlock)block;

//查询事件详情
+ (void)zx_httpClientToQueryDutyEventsWithEventId:(long)eventid andFlowType:(long)flowType  andSuccessBlock:(responseBlock)block;
//查询事件流程任务列表
+ (void)zx_httpClientToQueryEventFlowTasklistWithEventid:(int)eventid andflowtype:(int)flowtype andSuccessBlock:(responseBlock)block;

//流程任务确认
+ (void)zx_httpClientToConfirmflowtaskWithEventFlowid:(long)eventFlowid andFlowtaskid:(long)flowTaskid andCheckOpion:(NSString *)checkOpion andSubmitto:(long)submitto andSubmittype:(long)type andSuccessBlock:(responseBlock)block;

//删除流程事件
+ (void)zx_httpClientToDeleteFlowEventWithEventid:(long)eventid andFlowtype:(long)flowtype andSuccessBlock:(responseBlock)block;

@end
