//
//  NextStepModel.m
//  ZXProject
//
//  Created by 刘清 on 2018/3/23.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "NextStepModel.h"

@implementation NextStepModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{};

+ (instancetype)nextStepModelWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

+ (NSDictionary *)nextStepDictWithSource_arr:(NSArray *)source_arr{
    NSMutableDictionary *MDict = [NSMutableDictionary dictionary];
    for (NSDictionary *dict in source_arr) {
        NextStepModel *model = [NextStepModel nextStepModelWithDict:dict];
        if ([MDict objectForKey:model.submittypename]) {
            NSMutableArray *arr = (NSMutableArray *)MDict[model.submittypename];
            [arr addObject:model];
        }else{
            NSMutableArray *arr = [NSMutableArray array];
            [arr addObject:model];
            [MDict setObject:arr forKey:model.submittypename];
        }
    }
    return MDict.mutableCopy;
}

@end
