//
//  HttpClient+DutyEvents.h
//  ZXProject
//
//  Created by 刘清 on 2018/3/23.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "HttpClient.h"

@interface HttpClient (DutyEvents)


//查询下一步审核人
+ (void)zx_httpClientToQueryNextStepApprvoPersonWithFlowType:(NSString *)type andEventId:(NSString *)eventId andFlowTaskId:(NSString *)flowtaskId andSuccessBlock:(responseBlock)block;

//提交审核流程
+ (void)zx_httpClientToSubmitDutyEventWithEventType:(NSString *)eventType andBeginTime:(long long)beginTime andEndTime:(long long)endTime andEventName:(NSString *)eventName andEventMark:(NSString *)eventMark andPhotoUrl:(NSString *)photoUrl andSubmitto:(NSString *)submitto andSuccessBlock:(responseBlock)block;

//考勤打卡
+ (void)zx_httpClientToDutyCheckWithDutytype:(NSString *)dutytype andPositionAdress:(NSString *)positionAdress andPosition:(NSString *)posiotion andPhotoUrl:(NSString *)url andSuccessBlock:(responseBlock)block;

//查询考勤规则
+ (void)zx_httpClientToQueryDutyRuleWithWorkDateFormatter:(NSString *)formatter andSuccessBlock:(responseBlock)block;

//人员排班
+ (void)zx_httpClientToInitWorkDateWithProjectId:(NSString *)projectid andSettingId:(NSString *)settingId andEmployerid:(NSString *)employerid andWorkdates:(NSString *)workDates andSuccessBlock:(responseBlock)block;

//项目人员考勤查询
+ (void)zx_httpClientToQueryProjectDutyWithBeginTime:(long)beginTime andEndTime:(long)time andSuccessBlock:(responseBlock)block;

@end
