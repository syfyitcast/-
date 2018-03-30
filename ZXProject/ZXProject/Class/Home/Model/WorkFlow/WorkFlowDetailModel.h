//
//  WorkFlowDetailModel.h
//  ZXProject
//
//  Created by 刘清 on 2018/3/30.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkFlowDetailModel : NSObject

@property (nonatomic, assign) int eventid;//事件主键
@property (nonatomic, assign) int eventflowid;//流程主键;
@property (nonatomic, assign) int  flowtype;//流程类型;
@property (nonatomic, assign) int projectid;//项目id
@property (nonatomic, assign) int employerid;//请假员工主键
@property (nonatomic, copy) NSString *employername;//职员姓名
@property (nonatomic, assign) int submitemployer;//提交流程员工主键
@property (nonatomic, copy) NSString *submitemployername;//提交职员姓名
@property (nonatomic, assign) int dutytype;//请假类型：  1事假 2病假 3带薪假
@property (nonatomic, assign) long begintime;//开始时间
@property (nonatomic, assign) long endtime;//结束时间
@property (nonatomic, copy) NSString *eventname;//事件名称
@property (nonatomic, copy) NSString *eventremark;//事件说明


+ (instancetype)workFlowDetailModelWithDict:(NSDictionary *)dict;

@end
