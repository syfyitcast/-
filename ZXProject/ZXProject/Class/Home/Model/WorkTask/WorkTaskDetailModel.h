//
//  WorkTaskDetailModel.h
//  ZXProject
//
//  Created by 刘清 on 2018/4/8.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkTaskDetailModel : NSObject

@property (nonatomic, copy) NSString *centerlat;//中心点纬度
@property (nonatomic, copy) NSString *centerlon;//中心点经度
@property (nonatomic, assign) long employerid;
@property (nonatomic, copy) NSString *employername;
@property (nonatomic, assign) long orgid;//责任组id
@property (nonatomic, copy) NSString *orgname;//责任组名字
@property (nonatomic, assign) long projectorgregionid;//列表id;
@property (nonatomic, copy) NSString *regioncode;//区域编码
@property (nonatomic, copy) NSString *regionname;//区域名字

+ (NSArray *)workTaskDetailModelsWithSource_arr:(NSArray *)arr;

@end
