//
//  eventsMdoel.h
//  ZXProject
//
//  Created by 刘清 on 2018/3/22.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface eventsMdoel : NSObject

@property (nonatomic, copy) NSString *assignvehid;//分配处理车辆
@property (nonatomic, copy) NSString *createuserid;//发起人id
@property (nonatomic, copy) NSString *createusername;//发起人名字
@property (nonatomic, copy) NSString *eventdescription;//事件描述
@property (nonatomic, copy) NSString *eventid;//时间主键
@property (nonatomic, copy) NSString *eventno;//事件编号
@property (nonatomic, copy) NSString *eventstatus;//时间状态
@property (nonatomic, copy) NSString *positionlon;//纬度
@property (nonatomic, copy) NSString *positionlat;//经度
@property (nonatomic, copy) NSString *solveusername;//解决人
@property (nonatomic, copy) NSString *occurtime;//发生时间
@property (nonatomic, copy) NSString *photourl;//照片
@property (nonatomic, copy) NSString *positionaddress;//地址
@property (nonatomic, copy) NSString *solveuserid;//解决人id
@property (nonatomic, copy) NSString *isvehneed;//是否需要车
@property (nonatomic, copy) NSString *timeCount;//经历时间



+ (NSArray *)eventsModelsWithSource_arr:(NSArray *)source_arr;


@end
