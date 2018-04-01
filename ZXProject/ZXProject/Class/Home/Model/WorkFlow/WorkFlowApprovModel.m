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

@end
