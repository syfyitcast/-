//
//  AttDutySettingModel.m
//  ZXProject
//
//  Created by 刘清 on 2018/3/27.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "AttDutySettingModel.h"

@implementation AttDutySettingModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{};

+ (instancetype)attDutySettingModelWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}


+ (NSArray *)attDutySettingModelsWithSource_arr:(NSArray *)source_arr{
    NSMutableArray *tem_arr = [NSMutableArray array];
    for (NSDictionary *dict in source_arr) {
        AttDutySettingModel *model = [AttDutySettingModel attDutySettingModelWithDict:dict];
        [tem_arr addObject:model];
    }
    return tem_arr.mutableCopy;
}


#pragma mark - setter && getter

- (NSString *)begintimeString{
    if (_begintimeString == nil) {
        long time = self.begintime /  1000.0;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yy/MM/dd hh:mm"];
        _begintimeString = [formatter stringFromDate:date];
    }
    return _begintimeString;
}

- (NSString *)endtimeString{
    if (_endtimeString == nil) {
        long time = self.endtime / 1000.0;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yy/MM/dd hh:mm"];
        _endtimeString = [formatter stringFromDate:date];
    }
    return _endtimeString;
}

@end
