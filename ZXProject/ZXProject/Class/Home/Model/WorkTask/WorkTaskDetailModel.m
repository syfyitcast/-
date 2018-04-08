//
//  WorkTaskDetailModel.m
//  ZXProject
//
//  Created by 刘清 on 2018/4/8.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "WorkTaskDetailModel.h"

@implementation WorkTaskDetailModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{};

+ (instancetype)workTaskDetailModelWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}


+ (NSArray *)workTaskDetailModelsWithSource_arr:(NSArray *)arr{
    NSMutableArray *tem_arr = [NSMutableArray array];
    for (NSDictionary *dict in arr) {
        WorkTaskDetailModel *model = [WorkTaskDetailModel workTaskDetailModelWithDict:dict];
        [tem_arr addObject:model];
    }
    return tem_arr.mutableCopy;
}

@end
