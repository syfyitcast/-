//
//  APPNotificationManager.h
//  ZXProject
//
//  Created by 刘清 on 2018/3/21.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APPNotificationManager : NSObject

@property (nonatomic, strong) NSArray *notificationCounts;
@property (nonatomic, assign) int allReadCount;
@property (nonatomic, assign) int newCount;
@property (nonatomic, assign) int jtCount;
@property (nonatomic, assign) int xmCount;

+ (instancetype)sharedAppNotificationManager;

@end
