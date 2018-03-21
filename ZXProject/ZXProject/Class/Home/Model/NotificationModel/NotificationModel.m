//
//  NotificationModel.m
//  ZXProject
//
//  Created by 刘清 on 2018/3/21.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "NotificationModel.h"

@implementation NotificationModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self  setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{};

+ (instancetype)notificationModelWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

+ (NSArray *)notificationModelsWithSource_arr:(NSArray *)source_arr andType:(int)type{
    NSMutableArray *tem_arr = [NSMutableArray array];
    for (NSDictionary *dict in source_arr) {
        NotificationModel *model = [NotificationModel notificationModelWithDict:dict];
        model.notificationType = type;
        [tem_arr addObject:model];
    }
    return tem_arr.mutableCopy;
}

@end
