//
//  NotificationNewsModel.m
//  ZXProject
//
//  Created by Me on 2018/2/26.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "NotificationNewsModel.h"

@implementation NotificationNewsModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)notificationNewsModelWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{};

+ (NSArray *)notificationNewsModelsWithSource_arr:(NSArray *)source_arr{
    NSMutableArray *tem_arr = [NSMutableArray array];
    for (NSDictionary *dict in source_arr) {
        NotificationNewsModel *model = [NotificationNewsModel notificationNewsModelWithDict:dict];
        [tem_arr addObject:model];
    }
    return tem_arr.mutableCopy;
}

@end
