//
//  WorkFlowDetailModel.m
//  ZXProject
//
//  Created by 刘清 on 2018/3/30.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "WorkFlowDetailModel.h"
#import "NetworkConfig.h"

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

- (NSString *)beginTimeString{
    NSTimeInterval time = self.begintime /  1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [formatter stringFromDate:date];
}

- (NSString *)endTimeString{
    NSTimeInterval time = self.endtime / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [formatter stringFromDate:date];
}

- (NSString *)timeString{
    NSTimeInterval time = (self.endtime - self.begintime) / 1000.0;
    int day = time / ( 3600  * 24 );
    int hours = (time - day * 3600  * 24) / 3600;
    if (day == 0) {
        return [NSString stringWithFormat:@"%zd小时",hours];
    }else if(hours == 0){
        return [NSString stringWithFormat:@"%zd天",day];
    }else{
        return [NSString stringWithFormat:@"%zd天%zd小时",day,hours];
    }
}

- (NSArray *)photoUrls{
    if (self.photourl != nil || self.photourl.length != 0) {
        NSMutableArray *tem_arr = [NSMutableArray array];
        NSArray *urls = [self.photourl componentsSeparatedByString:@"|"];
        if (urls.count != 0) {
            for (NSString *urlstr in urls) {
                NSString *comUrl = [[NetworkConfig sharedNetworkingConfig].ipUrl stringByAppendingString:urlstr];
                [tem_arr addObject:comUrl];
            }
            return tem_arr.mutableCopy;
        }else{
            [tem_arr addObject:[[NetworkConfig sharedNetworkingConfig].ipUrl stringByAppendingString:self.photourl]
             ];
            return tem_arr.mutableCopy;
        }
    }
    return @[];
}

@end
