//
//  NextStepModel.h
//  ZXProject
//
//  Created by 刘清 on 2018/3/23.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NextStepModel : NSObject

@property (nonatomic, copy) NSString *companyname;//公司名称
@property (nonatomic, copy) NSString *email;//邮箱
@property (nonatomic, assign) int employerid;//职员id
@property (nonatomic, copy) NSString *employername;//职员姓名
@property (nonatomic, assign) int gender;//性别
@property (nonatomic, copy) NSString *mobileno;//电话号码
@property (nonatomic, assign) int  submittype;//提交类型
@property (nonatomic, copy) NSString *submittypename;//提交类型名称
@property (nonatomic, copy) NSString *userrank;//职务
@property (nonatomic, copy) NSString *workno;//工号

+ (NSDictionary *)nextStepDictWithSource_arr:(NSArray *)source_arr;

@end
