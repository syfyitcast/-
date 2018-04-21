//
//  HttpClient+Inspection.h
//  ZXProject
//
//  Created by 刘清 on 2018/4/18.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "HttpClient.h"

@interface HttpClient (Inspection)

//获取巡检记录
+ (void)zx_httpClinetToGetPatrolReportWithProjectId:(NSString *)projectid andPatroltstatus:(long)status andSuccessBlock:(responseBlock)block;

//新增巡检记录
+ (void)zx_httpClinetToAddPatrolRecordWithPatrolTime:(long)patroltime andPosition:(NSString *)position andPositionAdress:(NSString *)positionAdress andRegionid:(long)regionid andOrgid:(long)orgid andLibleemplotyerid:(long)liableemployerid andPhotourl:(NSString *)photourl andSoundUrl:(NSString *)soudurl andPatrolName:(NSString *)patroltname andPatroltContent:(NSString *)patroltcontent andPatroltstatus:(long)patroltstatus andSuccessBlock:(responseBlock)block;

+ (void)zx_httpClinetToSwitchPatrolToEventWithPatrolRecordid:(long)patrolrecordid  andEventno:(long)eventno andEventType:(long)eventtype andIsvehneed:(int)isvehneed andLiableemployerid:(long)liableemployerid andSolveemployerid:(long)solveemployerid andUrgency:(long)urgency andSendsms:(int)sendsms andEventdescription:(NSString *)eventdescription andSuccessBlock:(responseBlock)block;

@end
