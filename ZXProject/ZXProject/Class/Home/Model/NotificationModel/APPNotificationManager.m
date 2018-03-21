//
//  APPNotificationManager.m
//  ZXProject
//
//  Created by 刘清 on 2018/3/21.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "APPNotificationManager.h"


@implementation APPNotificationManager

+ (instancetype)sharedAppNotificationManager{
    static APPNotificationManager *intance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        intance = [[APPNotificationManager alloc] init];
    });
    return intance;
}

- (void)setNotificationCounts:(NSArray *)notificationCounts{
    _notificationCounts = notificationCounts;
    for (NSDictionary *dict in notificationCounts) {
        if ([dict[@"noticetypeid"] isEqualToString:@"1"]) {
            self.allReadCount = [dict[@"count"] intValue];
        }
        if ([dict[@"noticetypeid"] isEqualToString:@"2"]) {
            self.newCount = [dict[@"count"] intValue];
        }
        if ([dict[@"noticetypeid"] isEqualToString:@"3"]) {
            self.jtCount = [dict[@"count"] intValue];
        }
        if ([dict[@"noticetypeid"] isEqualToString:@"4"]) {
            self.xmCount = [dict[@"count"] intValue];
        }
    }
}

@end
