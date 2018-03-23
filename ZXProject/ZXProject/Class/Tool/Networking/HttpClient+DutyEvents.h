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



@end
