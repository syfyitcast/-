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
    for (NSDictionary *dict in tem_arr) {
        WorkFlowModel *model = [WorkFlowModel workFlowModelWithDict:dict];
        [tem_arr addObject:model];
    }
    return tem_arr;
}

- (void)setEventtype:(int)eventtype{
    _eventtype = eventtype;
    switch (eventtype) {
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
    long long time = _localreceivetime / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm"];
    return [formatter stringFromDate:date];
}

@end
