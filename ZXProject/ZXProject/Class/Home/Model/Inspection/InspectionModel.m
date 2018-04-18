//
//  InspectionModel.m
//  ZXProject
//
//  Created by 刘清 on 2018/4/18.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "InspectionModel.h"
#import "NetworkConfig.h"



@implementation InspectionModel


- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self  setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{};

+ (instancetype)inspectionModelWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

+ (NSArray *)inspectionModelsWithSource_arr:(NSArray *)source_arr{
    NSMutableArray *tem_arr = [NSMutableArray array];
    for (NSDictionary *dict in source_arr) {
        InspectionModel *model = [InspectionModel inspectionModelWithDict:dict];
        [tem_arr addObject:model];
    }
    return tem_arr.mutableCopy;
}

- (NSString *)occourtimeString{
    long long time = _patroldate / 1000.0;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    return [dateFormatter stringFromDate:date];
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
