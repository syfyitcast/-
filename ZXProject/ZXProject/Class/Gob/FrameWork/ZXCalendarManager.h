//
//  ZXCalendarManager.h
//  ZXProject
//
//  Created by Me on 2018/3/1.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXCalendarManager : NSObject

- (NSArray *)zx_CalendarItemsWithDate:(NSDate *)date;

- (NSArray *)nextMonthDataArr;

- (NSArray *)lastMonthDataArr ;

@end
