//
//  WorkTaskModel.h
//  ZXProject
//
//  Created by Me on 2018/3/5.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkTaskModel : NSObject

@property (nonatomic, copy) NSString *eventid;
@property (nonatomic, copy) NSString *eventdescription;//事件描述
@property (nonatomic, copy) NSString *eventstatus;//事件状态
@property (nonatomic, copy) NSString *photourl;//照片url

@property (nonatomic, copy) NSString *positionlon;//位置纬度
@property (nonatomic, copy) NSString *positionlat;//位置经度
@property (nonatomic, copy) NSString *positionaddress;//位置地址
@property (nonatomic, copy) NSString *assignvehid;//分配处理车辆
@property (nonatomic, copy) NSString *soundurl;//声频url
@property (nonatomic, strong) NSString *videourl;//视频url

@property (nonatomic, copy) NSString *eventtypename;//事件类型名称
@property (nonatomic, copy) NSString *occurtime;//上报时间
@property (nonatomic, copy) NSString *solveusername;//上报负责人
@property (nonatomic, copy) NSString *mobileno;//联系方式

@property (nonatomic, strong) NSArray *photoUrls;


+ (NSMutableArray *)workTaskModelsWithSource_arr:(NSArray *)source_arr;

@end
