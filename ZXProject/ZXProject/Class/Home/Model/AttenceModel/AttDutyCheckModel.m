//
//  AttDutyCheckModel.m
//  ZXProject
//
//  Created by 刘清 on 2018/3/28.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "AttDutyCheckModel.h"
#import "NetworkConfig.h"

@implementation AttDutyCheckModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)attdutyCheckModelWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

+ (NSArray *)attdutyCheckModelsWithSource_arr:(NSArray *)source_arr{
    NSMutableArray *tem_arr = [NSMutableArray array];
    for (NSDictionary *dict in source_arr) {
        AttDutyCheckModel *model = [AttDutyCheckModel attdutyCheckModelWithDict:dict];
        [tem_arr addObject:model];
    }
    return tem_arr.mutableCopy;
}

- (NSString *)beginTimeString{
    NSTimeInterval time = self.begintime / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    return [formatter stringFromDate:date];
}

- (NSString *)endTimeString{
    NSTimeInterval time = self.endtime / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    return [formatter stringFromDate:date];
}

- (NSString *)beginphotourl{
    if (_beginphotourl != nil) {
        return [NSString stringWithFormat:@"%@%@",[NetworkConfig sharedNetworkingConfig].ipUrl,_beginphotourl];
    }
    return nil;
}

- (NSString *)endphotourl{
    if (_endphotourl != nil) {
        return [NSString stringWithFormat:@"%@%@",[NetworkConfig sharedNetworkingConfig].ipUrl,_endphotourl];
    }
    return nil;
}

@end
