//
//  eventsMdoel.h
//  ZXProject
//
//  Created by 刘清 on 2018/3/22.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface eventsMdoel : NSObject

@property (nonatomic, assign) long eventstatus;//事件状态


@property (nonatomic, copy) NSString *assignvehid;//分配处理车辆
@property (nonatomic, copy) NSString *createemployer;//发起人id
@property (nonatomic, copy) NSString *createemployername;//发起人名字
@property (nonatomic, copy) NSString *eventdescription;//事件描述
@property (nonatomic, copy) NSString *assignid;//事件主键
@property (nonatomic, copy) NSString *eventno;//事件编号

@property (nonatomic, copy) NSString *positionlon;//纬度
@property (nonatomic, copy) NSString *positionlat;//经度
@property (nonatomic, copy) NSString *solveusername;//解决人
@property (nonatomic, assign) long  createtime;//发生时间
@property (nonatomic, copy) NSString *photourl;//照片
@property (nonatomic, copy) NSString *soundurl;//音频URL
@property (nonatomic, copy) NSString *positionaddress;//地址
@property (nonatomic, copy) NSString *solveuserid;//解决人id
@property (nonatomic, copy) NSString *isvehneed;//是否需要车
@property (nonatomic, copy) NSString *timeCount;//经历时间
@property (nonatomic, assign) long finishtime;//完成时间;
@property (nonatomic, copy) NSString *finishtimesSting;//完成时间字符串

@property (nonatomic, copy) NSString *solvesoundurl;//处理后音频URL
@property (nonatomic, copy) NSString *solvephotourl;//处理后音频

@property (nonatomic, copy) NSString *liableemployername;//负责人
@property (nonatomic, copy) NSString *liableemployer;//

@property (nonatomic, copy) NSString *receiveemployer;//处理人
@property (nonatomic, copy) NSString *receiveemployername;//处理后人
@property (nonatomic, copy) NSString *solveopinion;//处理后说明

@property (nonatomic, copy) NSString *regionname;//紧急程度名称
@property (nonatomic, copy) NSString *urgencyname;//紧急程度

@property (nonatomic, strong) NSArray *photoUrls;//照片url;
@property (nonatomic, strong) NSArray *soundUrls;
@property (nonatomic, strong) NSString *occourtimeString;
@property (nonatomic, assign) long begintime;//开始处理时间
@property (nonatomic, copy) NSString *beginString;


@property (nonatomic, strong) NSArray *afterPhotoUrls;
@property (nonatomic, strong) NSArray *afterSoundUrls;



+ (NSArray *)eventsModelsWithSource_arr:(NSArray *)source_arr;


@end
