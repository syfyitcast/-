//
//  ZXCalendar.h
//  ZXProject
//
//  Created by Me on 2018/3/1.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZXCalendarDelegate<NSObject>

@optional

- (void)calendarDelegateMethodWithStartTime:(long)startTime andEndTime:(long)endTime;

@end

@interface ZXCalendar : UIView


@property (nonatomic, weak) id <ZXCalendarDelegate>delegate;


+ (instancetype)zx_CalendarWithFrame:(CGRect)frame;

@end
