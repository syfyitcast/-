//
//  NotificationNewsModel.h
//  ZXProject
//
//  Created by Me on 2018/2/26.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationNewsModel : NSObject

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *des;
@property (nonatomic, copy) NSString *time;


+ (NSArray *)notificationNewsModelsWithSource_arr:(NSArray *)source_arr;

@end
