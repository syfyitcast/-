//
//  ZXCalendarManager.m
//  ZXProject
//
//  Created by Me on 2018/3/1.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "ZXCalendarManager.h"
#import "ZXCalendarItem.h"

@interface ZXCalendarManager()

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic, assign) long day;//天
@property (nonatomic, assign) long month;//月
@property (nonatomic, assign) long year;//年
@property (nonatomic, strong) NSMutableArray *dayArray;

@end

@implementation ZXCalendarManager


- (NSArray *)zx_CalendarItemsWithDate:(NSDate *)date{
    return [self setDayArrWithDate:date];
}

- (NSArray *)setDayArrWithDate:(NSDate *)date {
    self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *nowCompoents =[self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    self.year = nowCompoents.year;
    self.month = nowCompoents.month;
    self.day = nowCompoents.day;
    self.dayArray = [[NSMutableArray alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * nowDate = [dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld",_year,_month,_day]];
    //本月的天数范围
    NSRange dayRange = [_calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:nowDate];
    //上个月的天数范围
    NSRange lastdayRange = [_calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[self setLastMonthWithDay]];
    //本月第一天的NSDate对象
    NSDate *nowMonthfirst = [dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%ld-%d",(long)_year,_month,1]];
    //本月第一天是星期几
    NSDateComponents * components = [_calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:nowMonthfirst];
    //本月最后一天的NSDate对象
    NSDate * nextDay = [dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld",_year,_month,(unsigned long)(long)dayRange.length]];
    NSDateComponents * lastDay = [_calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:nextDay];
    //上个月遗留的天数
    for (NSInteger i = lastdayRange.length - components.weekday + 2; i <= lastdayRange.length; i++) {
        NSString * string = [NSString stringWithFormat:@"%zd",i];
        if (components.weekday == 1) {
            ZXCalendarItem *item = [ZXCalendarItem zx_CalendarItemWithTime:string andType:ZXCalendarItemTypeNextMoth];
            item.day = i;
            [self.dayArray addObject:item];
        }else{
            ZXCalendarItem *item = [ZXCalendarItem zx_CalendarItemWithTime:string andType:ZXCalendarItemTypeNone];
            item.day = i;
            [self.dayArray addObject:item];
        }
    }
    //本月的总天数
    for (NSInteger i = 1; i <= dayRange.length ; i++) {
        ZXCalendarItemType type = ZXCalendarItemTypeNone;
        NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%ld-%zd",_year,_month,i]];
        NSDateComponents * components = [_calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:date];
        if (components.weekday == 1 || components.weekday == 7) {
            type = ZXCalendarItemTypeNextMoth;
            if (i > _day) {
                type = ZXCalendarItemTypeNextMoth;
            }
        }else{
            type = ZXCalendarItemTypeNone;
            if (i > _day) {
                type = ZXCalendarItemTypeNone;
            }
        }
      
        NSString * string = [NSString stringWithFormat:@"%zd",i];
        ZXCalendarItem *item = [ZXCalendarItem zx_CalendarItemWithTime:string andType:type];
        item.day = i;
        NSDateComponents *nowCompoents = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
        long year = nowCompoents.year;
        long month = nowCompoents.month;
        long day = nowCompoents.day;
        if (self.year == year && self.month == month && i == day) {
            item.isSelected = YES;
        }
        [self.dayArray addObject:item];
    }
    //下个月空出的天数
    for (NSInteger i = 1; i <= (7 - lastDay.weekday); i++) {
        NSString * string = [NSString stringWithFormat:@"%zd",i];
        ZXCalendarItem *item = [ZXCalendarItem zx_CalendarItemWithTime:string andType:ZXCalendarItemTypeNextMoth];
        item.day = i;
        [self.dayArray addObject:item];
    }
    NSArray *weekDesItems = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    NSMutableArray *tem_ar = [NSMutableArray array];
    for (int i = 0;i < weekDesItems.count; i ++) {
        NSString *string = weekDesItems[i];
        if ( i == 0 || i == weekDesItems.count - 1) {
             ZXCalendarItem *item = [ZXCalendarItem zx_CalendarItemWithTime:string andType:ZXCalendarItemTypeNextMoth];
            [tem_ar addObject:item];
        }else{
            ZXCalendarItem *item = [ZXCalendarItem zx_CalendarItemWithTime:string andType:ZXCalendarItemTypeNone];
            [tem_ar addObject:item];
        }
    }
    [tem_ar addObjectsFromArray:self.dayArray];
    for (ZXCalendarItem *item in self.dayArray) {
        NSLog(@"itemType = %zd",item.type);
    }
    
    return tem_ar.mutableCopy;
}
//返回上个月第一天的NSDate对象
- (NSDate *)setLastMonthWithDay {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * date = nil;
    if (self.month != 1) {
        date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%ld-%d",self.year,self.month-1,01]];
    }else{
        
        date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%d-%d",self.year - 1,12,01]];
    }
    return date;
}

//下个月的数据
- (NSArray *)nextMonthDataArr {
    [self.dayArray removeAllObjects];
    if (_month == 12) {
        _month = 1;
        _year ++;
    }else {
        _month ++;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * nowDate = [dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld",_year,_month,_day]];
    return [self setDayArrWithDate:nowDate];
}

//上个月的数据
- (NSArray *)lastMonthDataArr {
    [self.dayArray removeAllObjects];
    if (_month == 1) {
        _month = 12;
        _year --;
    }else {
        _month --;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * nowDate = [dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld",_year,_month,_day]];
    return [self setDayArrWithDate:nowDate];
}

- (NSDate *)nextDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * nowDate = [dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld",_year,_month,_day]];
    return nowDate;
}

- (NSDate *)preDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * nowDate = [dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld",_year,_month,_day]];
    return nowDate;
}

- (NSTimeInterval)dayBeginTimeWithDay:(NSInteger)day{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * nowDate = [dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld",_year,_month,day]];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:nowDate];
    return  [[calendar dateFromComponents:components] timeIntervalSince1970] * 1000.0;
}

- (NSTimeInterval)dayEndTimeWithDay:(NSInteger)day{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * nowDate = [dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld",_year,_month,day]];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:nowDate];
    NSDate *startDate = [calendar dateFromComponents:components];
    return  [[calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0] timeIntervalSince1970] * 1000.0;
}

@end
