//
//  WorkTaskModel.m
//  ZXProject
//
//  Created by Me on 2018/3/5.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "WorkTaskModel.h"
#import "NetworkConfig.h"

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
            _photoUrls = @[[[NetworkConfig sharedNetworkingConfig].ipUrl stringByAppendingString:self.beforephotourl]];
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

- (NSArray *)afterPhotoUrls{
    if (_afterPhotoUrls == nil) {
        _afterPhotoUrls = [self.afterphotourl componentsSeparatedByString:@"|"];
        if (_afterPhotoUrls == nil) {
            _afterPhotoUrls = @[[[NetworkConfig sharedNetworkingConfig].ipUrl stringByAppendingString:self.afterphotourl]];
        }else{
            NSMutableArray *tem_arr = [NSMutableArray array];
            for (NSString *subUrl in _afterPhotoUrls) {
                NSString *url = [[NetworkConfig sharedNetworkingConfig].ipUrl stringByAppendingString:subUrl];
                [tem_arr addObject:url];
            }
            _afterPhotoUrls = tem_arr.mutableCopy;
        }
    }
    return _afterPhotoUrls;
}

- (NSArray *)beforeSoundUrls{
    if (_beforeSoundUrls == nil) {
        _beforeSoundUrls = [self.beforesoundourl componentsSeparatedByString:@"|"];
        if (_beforeSoundUrls == nil) {
            _beforeSoundUrls = @[[[NetworkConfig sharedNetworkingConfig].ipUrl stringByAppendingString:self.beforesoundourl]];
        }else{
            NSMutableArray *tem_arr = [NSMutableArray array];
            for (NSString *subUrl in _beforeSoundUrls) {
                NSString *url = [[NetworkConfig sharedNetworkingConfig].ipUrl stringByAppendingString:subUrl];
                [tem_arr addObject:url];
            }
            _beforeSoundUrls = tem_arr.mutableCopy;
        }
    }
    return _beforeSoundUrls;
}

- (NSArray *)afterSoundUrls{
    if (_afterSoundUrls == nil) {
        _afterSoundUrls = [self.aftersoundurl componentsSeparatedByString:@"|"];
        if (_afterSoundUrls == nil) {
            _afterSoundUrls = @[[[NetworkConfig sharedNetworkingConfig].ipUrl stringByAppendingString:self.aftersoundurl]];
        }else{
            NSMutableArray *tem_arr = [NSMutableArray array];
            for (NSString *subUrl in _afterSoundUrls) {
                NSString *url = [[NetworkConfig sharedNetworkingConfig].ipUrl stringByAppendingString:subUrl];
                [tem_arr addObject:url];
            }
            _afterSoundUrls= tem_arr.mutableCopy;
        }
    }
    return _afterSoundUrls;
}

- (NSString *)occurtime{
    unsigned long long time = _beforetime / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:date];
}

- (NSString *)afterTimeString{
    unsigned long long time = _aftertime / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:date];
}

@end
