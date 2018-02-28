//
//  HomeRightItems.m
//  ZXProject
//
//  Created by Me on 2018/2/25.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "HomeRightItems.h"

@implementation HomeRightItems

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)homeRightItemWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

+ (NSArray *)homeRightItemsWithSource_arr:(NSArray *)source_arr{
    NSMutableArray *tem_arr = [NSMutableArray array];
    for (NSDictionary *dict in source_arr) {
        HomeRightItems *item = [HomeRightItems homeRightItemWithDict:dict];
        [tem_arr addObject:item];
    }
    return tem_arr.mutableCopy;
}

@end
