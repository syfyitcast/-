//
//  NotificationModel.h
//  ZXProject
//
//  Created by 刘清 on 2018/3/21.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationModel : NSObject

@property (nonatomic, copy) NSString *noticeid;//通知公告id
@property (nonatomic, copy) NSString *content;//内容
@property (nonatomic, copy) NSString *createtime;//创建时间
@property (nonatomic, copy) NSString *title;//标题
@property (nonatomic, copy) NSString *url;//链接地址
@property (nonatomic, assign) int readstatus;//阅读状态
@property (nonatomic, assign) int notificationType;


+ (NSArray *)notificationModelsWithSource_arr:(NSArray *)source_arr andType:(int)type;

@end
