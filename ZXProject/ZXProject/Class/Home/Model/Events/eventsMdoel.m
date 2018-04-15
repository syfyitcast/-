//
//  eventsMdoel.m
//  ZXProject
//
//  Created by 刘清 on 2018/3/22.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "eventsMdoel.h"
#import "NetworkConfig.h"

@implementation eventsMdoel

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self  setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{};

+ (instancetype)eventsModelWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

+ (NSArray *)eventsModelsWithSource_arr:(NSArray *)source_arr{
    NSMutableArray *tem_arr = [NSMutableArray array];
    for (NSDictionary *dict in source_arr) {
        eventsMdoel *model = [eventsMdoel eventsModelWithDict:dict];
        [tem_arr addObject:model];
    }
    return tem_arr.mutableCopy;
}

- (NSString *)occourtimeString{
    long long time = _occurtime/ 1000.0;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    return [dateFormatter stringFromDate:date];
}

- (NSString *)timeCount{
    long long time = _occurtime / 1000.0;
    NSTimeInterval timeInterval =  [[NSDate date] timeIntervalSince1970];
    long long chaTime = timeInterval - time;
    long long h = chaTime / 3600.0;
    long long m = (chaTime - h * 3600) / 60.0;
    return [NSString stringWithFormat:@"%02lld:%02lld",h,m];
}

- (NSArray *)photoUrls{
    if (_photoUrls == nil) {
        _photoUrls = [self.photourl componentsSeparatedByString:@"|"];
        if (_photoUrls == nil) {
            _photoUrls = @[[[NetworkConfig sharedNetworkingConfig].ipUrl stringByAppendingString:self.photourl]];
        }else{
            NSMutableArray *tem_arr = [NSMutableArray array];
            for (NSString *subUrl in _photoUrls) {
                NSString *url = [[NetworkConfig sharedNetworkingConfig].ipUrl stringByAppendingString:subUrl];
                [tem_arr addObject:url];
            }
            _photoUrls = tem_arr.mutableCopy;
        }
    }
    return _photoUrls;
}


@end
