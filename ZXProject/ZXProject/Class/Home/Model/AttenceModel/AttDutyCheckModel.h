//
//  AttDutyCheckModel.h
//  ZXProject
//
//  Created by 刘清 on 2018/3/28.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AttDutyCheckModel : NSObject

@property (nonatomic, copy) NSString *beginphotourl;//打卡照片
@property (nonatomic, copy) NSString *beginpositionaddress;//打卡地址
@property (nonatomic, assign) double beginpositionlat;//打卡纬度
@property (nonatomic, assign) double beginpositionlon;//打卡经度
@property (nonatomic, assign) long begintime;//打卡时间
@property (nonatomic, copy) NSString *beginTimeString;//字符串
@property (nonatomic, copy) NSString *dutydate;//打卡日期
@property (nonatomic, assign) int dutyorder;//1上班， 2下班
@property (nonatomic, assign) long employerid;//id
@property (nonatomic, copy) NSString *employername;//名字
@property (nonatomic, copy) NSString *settingname;//打卡描述

@property (nonatomic, copy) NSString *endphotourl;//下班打卡照片
@property (nonatomic, copy) NSString *endpositionaddress;//下班地址描述
@property (nonatomic, assign) double endpositionlat;//下班纬度
@property (nonatomic, assign) double endpositionlon;//下班经度
@property (nonatomic, assign) long endtime;//下班时间
@property (nonatomic, copy) NSString *endTimeString;//字符串



+ (NSArray *)attdutyCheckModelsWithSource_arr:(NSArray *)source_arr;

@end
