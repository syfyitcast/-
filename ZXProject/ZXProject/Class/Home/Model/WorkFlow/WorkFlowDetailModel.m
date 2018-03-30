//
//  WorkFlowDetailModel.m
//  ZXProject
//
//  Created by 刘清 on 2018/3/30.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "WorkFlowDetailModel.h"

@implementation WorkFlowDetailModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{};

+ (instancetype)workFlowDetailModelWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

@end
