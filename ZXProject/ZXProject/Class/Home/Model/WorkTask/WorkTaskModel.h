//
//  WorkTaskModel.h
//  ZXProject
//
//  Created by Me on 2018/3/5.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkTaskModel : NSObject

@property (nonatomic, copy) NSString *orgtaskid;//环卫工作项id
@property (nonatomic, assign) long taskstatus;//状态
@property (nonatomic, assign) long taskdate;//工作日期
@property (nonatomic, assign) long beforetime;//处理前时间
@property (nonatomic, assign) long aftertime;//处理后时间
@property (nonatomic, copy) NSString *taskcontent;//需处理说明
@property (nonatomic, assign) double positionlon;//经度;
@property (nonatomic, assign) double positionlat;//纬度;
@property (nonatomic, copy) NSString *positionaddress;//地址说明
@property (nonatomic, copy) NSString *regionid;//作业区域id
@property (nonatomic, copy) NSString *regionname;//作业区域名称
@property (nonatomic, copy) NSString *orgid;//项目组织id
@property (nonatomic, copy) NSString *orgname;//项目组织名称
@property (nonatomic, copy) NSString *submitemployerid;//提交人id
@property (nonatomic, copy) NSString *submitemployername;//提交人姓名
@property (nonatomic, copy) NSString *confirmemployerid;//确认人id
@property (nonatomic, copy) NSString *liableemployerid;//责任人Id
@property (nonatomic, copy) NSString *liableemployename;//责任人姓名
@property (nonatomic, copy) NSString *confirmemployername;//确认人姓名
@property (nonatomic, copy) NSString *beforephotourl;//处理前图像
@property (nonatomic, copy) NSString *beforevideourl;//处理前视频
@property (nonatomic, copy) NSString *beforesoundurl;//处理前音频
@property (nonatomic, copy) NSString *afterphotourl;//处理后图像
@property (nonatomic, copy) NSString *aftervideourl;//处理后视频
@property (nonatomic, copy) NSString *aftersoundurl;//处理后音频
@property (nonatomic, copy) NSString *confirmcontent;//处理说明
@property (nonatomic, copy) NSString *doingphotourl;//处理中图像
@property (nonatomic, copy) NSString *doingvideourl;//处理中视频
@property (nonatomic, copy) NSString *doingsoundurl;//处理中音频

@property (nonatomic, copy) NSString *occurtime;//字符串



@property (nonatomic, strong) NSArray *photoUrls;


+ (NSMutableArray *)workTaskModelsWithSource_arr:(NSArray *)source_arr;

@end
