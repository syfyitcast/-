//
//  DeviceInfoModel.m
//  ZXProject
//
//  Created by 刘清 on 2018/4/20.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "DeviceInfoModel.h"
#import "NetworkConfig.h"

@implementation DeviceInfoModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self  setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{};

+ (instancetype)deviceInfoModelWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

+ (NSArray *)deviceInfoModelsWithSource_arr:(NSArray *)source_arr{
    NSMutableArray *tem_arr = [NSMutableArray array];
    for (NSDictionary *dict in source_arr) {
        DeviceInfoModel *model = [DeviceInfoModel deviceInfoModelWithDict:dict];
        [tem_arr addObject:model];
    }
    return tem_arr.mutableCopy;
}

#pragma mark - setter && getter

- (NSString *)updateTimeString{
    if (_updateTimeString == nil) {
        long long time = _gpstime / 1000.0;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
        _updateTimeString = [dateFormatter stringFromDate:date];
    }
    return _updateTimeString;
}

- (NSArray *)photoUrls{
    if (_photoUrls == nil) {
        _photoUrls = [self.photourl componentsSeparatedByString:@"|"];
        if (_photoUrls == nil) {
            if (self.photourl != nil) {
                _photoUrls = @[[[NetworkConfig sharedNetworkingConfig].ipUrl stringByAppendingString:self.photourl]];
            }
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
