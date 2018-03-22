//
//  WorkFlowModel.h
//  ZXProject
//
//  Created by 刘清 on 2018/3/20.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkFlowModel : NSObject

@property (nonatomic, assign) int dutyeventid;//考勤事件主键
@property (nonatomic, assign) int projectid;//项目id
@property (nonatomic, assign) int eventemployerid;//考勤人
@property (nonatomic, copy) NSString *eventemployername;//考勤人姓名
@property (nonatomic, assign) int submitemployerid;//提交人
@property (nonatomic, copy) NSString *submitemployername;//提交人姓名
@property (nonatomic, assign) int eventtype;//事件类型
@property (nonatomic, assign) long begintime;//事件开始时间
@property (nonatomic, assign) long endtime;//事件结束时间

@property (nonatomic, copy) NSString *eventname;//事件名称
@property (nonatomic, copy) NSString *eventremark;//事件说明
@property (nonatomic, assign) long localreceivetime;//流程当前任务接收时间
@property (nonatomic, assign) int  localhandler;//流程当前任务当前处理人
@property (nonatomic, copy) NSString *localhandlername;//流程当前任务当前处理人姓名
@property (nonatomic, assign) int localtasktype;//流程当前任务当前任务类型
@property (nonatomic, assign) int eventflowid;//流程id
@property (nonatomic, copy) NSString *photourl;//对应附件的地址
@property (nonatomic, assign) int flowtaskid;//流程任务id
@property (nonatomic, copy) NSString *typeName;//流程类型
@property (nonatomic, copy) NSString *updateTimeString;//更新时间


+ (NSMutableArray *)workFlowModelsWithSource_arr:(NSArray *)source_arr;

@end
