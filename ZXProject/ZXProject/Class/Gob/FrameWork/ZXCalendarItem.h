//
//  ZXCalendarItem.h
//  ZXProject
//
//  Created by Me on 2018/3/1.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
   ZXCalendarItemTypeNone = 0,
   ZXCalendarItemTypeRight,
   ZXCalendarItemTypeWrong,
   ZXCalendarItemTypeToday,
   ZXCalendarItemTypePreMothRight,
   ZXCalendarItemTypePreMothWrong,
   ZXCalendarItemTypeNextMoth,
}ZXCalendarItemType;

@interface ZXCalendarItem : NSObject

@property (nonatomic, assign) ZXCalendarItemType type;//打卡类型
@property (nonatomic, copy)   NSString *time;//日期

+ (instancetype)zx_CalendarItemWithTime:(NSString *)time  andType:(ZXCalendarItemType)type;

@end



