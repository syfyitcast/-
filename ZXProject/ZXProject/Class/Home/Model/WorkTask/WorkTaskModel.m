//
//  WorkTaskModel.m
//  ZXProject
//
//  Created by Me on 2018/3/5.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "WorkTaskModel.h"

@implementation WorkTaskModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)workModelWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{};

+ (NSMutableArray *)workTaskModelsWithSource_arr:(NSArray *)source_arr{
    NSMutableArray *tem_arr = [NSMutableArray array];
    for (NSDictionary *dict in source_arr) {
        WorkTaskModel *model = [WorkTaskModel workModelWithDict:dict];
        [tem_arr addObject:model];
    }
    return tem_arr;
}

#pragma mark - setter && getter

- (NSArray *)photoUrls{
    if (_photoUrls == nil) {
        _photoUrls = [self.beforephotourl componentsSeparatedByString:@"|"];
        if (_photoUrls == nil) {
            _photoUrls = @[self.beforephotourl];
        }
    }
    return _photoUrls;
}

- (NSString *)occurtime{
    unsigned long long time = _beforetime / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:date];//1520243876000
                                            //1520243876000
}

@end
