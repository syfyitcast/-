//
//  WorkFlowApprovModel.m
//  ZXProject
//
//  Created by 刘清 on 2018/4/1.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "WorkFlowApprovModel.h"

@implementation WorkFlowApprovModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{};

+ (instancetype)workFlowApproModelWithDict:(NSDictionary *)dict{
    return [[WorkFlowApprovModel alloc] initWithDict:dict];
}

+ (NSArray *)workFlowApprovModelsWithSource_arr:(NSArray *)source_arr{
    NSMutableArray *tem_arr = [NSMutableArray array];
    for (NSDictionary *dict in source_arr) {
        WorkFlowApprovModel *model = [WorkFlowApprovModel workFlowApproModelWithDict:dict];
        [tem_arr addObject:model];
    }
    return tem_arr.mutableCopy;
}

- (NSString *)submittimeStrin{
    if (self.submittime == 0) {
        return nil;
    }
    NSTimeInterval time = self.submittime / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter stringFromDate:date];
}

- (NSString *)receiveTimeString{
    if (self.receivetime == 0) {
        return nil;
    }
    NSTimeInterval time = self.receivetime / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter stringFromDate:date];
}

@end
