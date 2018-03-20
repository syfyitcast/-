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

@end
