//
//  ZXCalendarItem.m
//  ZXProject
//
//  Created by Me on 2018/3/1.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "ZXCalendarItem.h"

@implementation ZXCalendarItem

+ (instancetype)zx_CalendarItemWithTime:(NSString *)time  andType:(ZXCalendarItemType)type{
    ZXCalendarItem *item = [[ZXCalendarItem alloc] init];
    item.time = time;
    item.type = type;
    return item;
}



@end
