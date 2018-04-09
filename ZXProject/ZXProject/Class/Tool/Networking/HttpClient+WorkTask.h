//
//  HttpClient+WorkTask.h
//  ZXProject
//
//  Created by Me on 2018/4/5.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "HttpClient.h"

@interface HttpClient (WorkTask)

//获取项目作业区域列表
+ (void)zx_httpClientToGetProjectRegionListWithSuccessBlock:(responseBlock)block;

//获取项目作业区域
+ (void)zx_httpClientToGetWorkTaskPointProjectoRgregionWithPosition:(NSString *)position andSuccessBlock:(responseBlock)block;

//新增环卫工作项
+ (void)zx_httpClientToAddOrgTaskWithEventMark:(NSString *)eventMark andPosition:(NSString *)position andPositionaddress:(NSString *)positionaddress andRegionid:(long)regionid andOrgid:(long)orgid andIableemployerid:(long)iableemployerid andPhotoUrls:(NSString *)photoUrl andSoundUrls:(NSString *)soundUrl andVideoUrls:(NSString *)videoUrl andConfirmemployer:(NSString *)confirmemployer andTaskStatus:(NSString *)taskStatus andOrgTaskid:(NSString *)orgtaskid;

@end
