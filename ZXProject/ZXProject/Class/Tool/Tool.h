//
//  Tool.h
//  FYTICKET
//
//  Created by pengkang on 16/7/15.
//  Copyright © 2016年 ZXH. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

@interface Tool : NSObject


/**
 *  获得两个日期之间的天数差值
 *
 *  @param fromDate 起始日期
 *  @param endDate  结束日期
 *
 *  @return 天数
 */
+(NSInteger)dayBetweenDate:(NSDate *)fromDate toDate:(NSDate *)endDate;



/**
 *  获取该月月天数
 *
 *  @param date 日期
 *
 *  @return 天数
 */
+(NSInteger)daysFromDate:(NSDate *)date;

/**
 *  得到字节数
 *
 *  @param strtemp 字符串
 *
 *  @return 字节数
 */
+(int)stringConvertToInt:(NSString*)strtemp;


/**
 *  判断字符串是否为空
 *
 *
 *  @return bool
 */
+(BOOL) isBlankString:(NSString *)string;


/**
 *  获取时间字符串
 *
 *  @param time 10位标准时间
 *
 *  @return yyyy-MM-dd hh:mm:ss
 */
+(NSString *)stringFromStandardTime:(NSInteger)time;

+(UIViewController *)appRootViewController;

+(UIViewController *)topViewController;


/**
 *  获取 周几 字符
 *
 *  @param dateString 日期格式 yyyy-MM-dd
 *
 */
+(NSString *)getWeekdayFrom:(NSString *)dateString;


+(NSArray *)getAllProperty:(id)object;

//设备版本
+(NSString *)getDeviceVersion;

//设备IP
+(NSString *)getDeviceIPAddresses;

+(NSString *)getMacAddress;
//设备名称
+(NSString *)getDeviceName;

+ (BOOL)hasSetProxy:(NSString *)urlStr;

+ (void)openEventServiceWithBolck:(void(^)(BOOL flag))returnBolck;

@end
