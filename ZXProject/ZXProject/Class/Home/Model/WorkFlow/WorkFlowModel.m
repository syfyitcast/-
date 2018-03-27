//
//  WorkFlowModel.m
//  ZXProject
//
//  Created by 刘清 on 2018/3/20.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "WorkFlowModel.h"

@implementation WorkFlowModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{};

+ (instancetype)workFlowModelWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

+ (NSMutableArray *)workFlowModelsWithSource_arr:(NSArray *)source_arr{
    NSMutableArray *tem_arr = [NSMutableArray array];
    for (NSDictionary *dict in source_arr) {
        WorkFlowModel *model = [WorkFlowModel workFlowModelWithDict:dict];
        [tem_arr addObject:model];
    }
    return tem_arr;
}

- (void)setFlowtype:(long)flowtype{
    _flowtype = flowtype;
    switch (flowtype) {
        case 1:
            self.typeName = @"请假";
            break;
        case 2:
            self.typeName = @"报销";
            break;
        case 3:
            self.typeName = @"呈报";
            break;
        case 4:
            self.typeName = @"出差";
            break;
        default:
            break;
    }
}

- (NSString *)updateTimeString{
    long long time = _flowsubmittime / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm"];
    return [formatter stringFromDate:date];
}

- (NSString *)countTime{
    long long time = _flowsubmittime / 1000.0;
    NSTimeInterval timeInterval =  [[NSDate date] timeIntervalSince1970];
    long long chaTime = timeInterval - time;
    long long h = chaTime / 3600.0;
    long long m = (chaTime - h * 3600) / 60.0;
    return [NSString stringWithFormat:@"%02lld:%02lld",h,m];
}

@end
