//
//  NSDate+time.h
//  sand_mobile_mask
//
//  Created by blue sky on 14-8-28.
//  Copyright (c) 2014年 sand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (time)

/**
 *@brief 获取当前系统时间
 *@return 返回NSString
 */
+ (NSString *)currentTime;

/**
 *@brief 格式化时间 0:yyyyMMddHHmmss   1:yyyy-MM-dd HH:mm:ss   2:yyyy-MM-dd  3:yyyyMMdd
 *@param index  int    索引
 *@param param  NSString串    时间参数
 *@return 返回NSString
 */
+ (NSString *)formatTime:(int)index dateParam:(NSDate *)param;

/**
 *@brief 格式化时间 0:yyyyMMddHHmmss   1:yyyy-MM-dd HH:mm:ss   2:yyyy-MM-dd   3:HH:mm:ss
 *@param index  int    索引
 *@param param  NSString串    时间参数
 *@return 返回NSString
 */
+ (NSString *)formatTime:(int)index param:(NSString *)param;

/**
 *@brief index 0:yyyyMMddHHmmss   1:yyyyMMdd   2:HHmmss   返回 天数
 *@param index  int    日期格式索引
 *@param oneParam  NSString    第一个日期
 *@param anotherParam   NSString    第二个日期
 *@return 返回int
 */
+ (int)dayIntervalFromLastDate:(int)index withOneneParam:(NSString *)oneParam  withAnotherDate:(NSString *)anotherParam;

/**
 *@brief index 0:yyyyMMddHHmmss   1:yyyyMMdd   2:HHmmss   返回 0:一样   1:前者日期大于后者日期   －1:前者时期小于后者日期
 *@param index  int    日期格式索引
 *@param oneDate  NSDate    第一个日期
 *@param anotherDate   NSDate    第二个日期
 *@return 返回int
 */
+(int)compareDate:(int)index withOneDate:(NSDate *)oneDate withAnotherDate:(NSDate *)anotherDate;

/**
 *@brief index 0:yyyyMMddHHmmss   1:yyyyMMdd   2:HHmmss   返回 0:一样   1:前者日期大于后者日期   －1:前者时期小于后者日期
 *@param index  int    日期格式索引
 *@param oneParam  NSString    第一个日期
 *@param anotherParam   NSString    第二个日期
 *@return 返回int
 */
+(int)compareDate:(int)index withOneneParam:(NSString *)oneParam withAnotherParam:(NSString *)anotherParam;

@end
