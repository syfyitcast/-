//
//  WorkFlowApprovModel.h
//  ZXProject
//
//  Created by 刘清 on 2018/4/1.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkFlowApprovModel : NSObject

@property (nonatomic, copy) NSString *employerid;//id
@property (nonatomic, copy) NSString *employername;//名字
@property (nonatomic, assign) int eventflowid;//事件流程id
@property (nonatomic, assign) int flowtaskid;//任务id
@property (nonatomic, copy) NSString *opinion;//审核意见
@property (nonatomic, assign) long receivetime;//接受时间
@property (nonatomic, assign) long submittime;//提交时间
@property (nonatomic, assign) int submittype;//提交类型 1 退回申请人重填 2 提交下一环节审核 3 提交确认 4 完成流程
@property (nonatomic, assign) int tasktype;//任务类型 1填单 2审核 3确认
@property (nonatomic, copy) NSString *userrank;//职务名称
@property (nonatomic, copy) NSString *submittimeStrin;//提交时间字符串
@property (nonatomic, copy) NSString *receiveTimeString;//接受时间字符串

@property (nonatomic, assign) BOOL isCurrentModel;

+ (NSArray *)workFlowApprovModelsWithSource_arr:(NSArray *)source_arr;

@end
