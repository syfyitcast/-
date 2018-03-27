//
//  AttDutySettingModel.h
//  ZXProject
//
//  Created by 刘清 on 2018/3/27.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AttDutySettingModel : NSObject

@property (nonatomic, copy) NSString *settingname;
@property (nonatomic, assign) long begintime;
@property (nonatomic, assign) long endtime;
@property (nonatomic, copy) NSString *begintimeString;
@property (nonatomic, copy) NSString *endtimeString;


+ (NSArray *)attDutySettingModelsWithSource_arr:(NSArray *)source_arr;




@end
