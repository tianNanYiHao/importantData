//
//  NSDate+time.m
//  sand_mobile_mask
//
//  Created by blue sky on 14-8-28.
//  Copyright (c) 2014年 sand. All rights reserved.
//

#import "NSDate+time.h"

@implementation NSDate (time)

/**
 *@brief 获取当前系统时间
 *@return 返回NSString
 */
+ (NSString *)currentTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //设置时间显示的格式。
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *result = [formatter stringFromDate: [NSDate date]];
    
    return result;
}

/**
 *@brief 格式化时间 0:yyyyMMddHHmmss   1:yyyy-MM-dd HH:mm:ss   2:yyyy-MM-dd    3:yyyyMMdd
 *@param index  int    索引
 *@param param  NSString串    时间参数
 *@return 返回NSString
 */
+ (NSString *)formatTime:(int)index dateParam:(NSDate *)param
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //设置时间显示的格式。
    switch (index) {
        case 0:
        {
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
        }
            break;
        case 1:
        {
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        }
            break;
        case 2:
        {
            [formatter setDateFormat:@"yyyy-MM-dd"];
        }
            break;
        case 3:
        {
            [formatter setDateFormat:@"yyyyMMdd"];
        }
            break;
            
        default:
            break;
    }

    
    NSString *result = [formatter stringFromDate: param];
    
    return result;
}

/**
 *@brief 格式化时间 0:yyyyMMddHHmmss   1:yyyy-MM-dd HH:mm:ss   2:yyyy-MM-dd   3:HH:mm:ss
 *@param index  int    索引
 *@param param  NSString串    时间参数
 *@return 返回NSString
 */
+ (NSString *)formatTime:(int)index param:(NSString *)param
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    //设置时间显示的格式。
    switch (index) {
        case 0:
        {
            [inputFormatter setDateFormat:@"yyyyMMddHHmmss"];
        }
            break;
        case 1:
        {
            [inputFormatter setDateFormat:@"yyyyMMddHHmmss"];
        }
            break;
        case 2:
        {
            [inputFormatter setDateFormat:@"yyyyMMdd"];
        }
            break;
        case 3:
        {
            [inputFormatter setDateFormat:@"HHmmss"];
        }
            break;
            
        default:
            break;
    }
    
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSDate *inputDate = [inputFormatter dateFromString:param];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    //设置时间显示的格式。
    switch (index) {
        case 0:
        {
            [outputFormatter setDateFormat:@"yyyyMMddHHmmss"];
        }
            break;
        case 1:
        {
            [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        }
            break;
        case 2:
        {
            [outputFormatter setDateFormat:@"yyyy-MM-dd"];
        }
            break;
        case 3:
        {
            [outputFormatter setDateFormat:@"HH:mm:ss"];
        }
            break;
            
        default:
            break;
    }
    
    NSString *result = [outputFormatter stringFromDate: inputDate];
    
    return result;
}

/**
 *@brief index 0:yyyyMMddHHmmss   1:yyyyMMdd   2:HHmmss   返回 天数
 *@param index  int    日期格式索引
 *@param oneParam  NSString    第一个日期
 *@param anotherParam   NSString    第二个日期
 *@return 返回int
 */
+ (int)dayIntervalFromLastDate:(int)index withOneneParam:(NSString *)oneParam  withAnotherDate:(NSString *)anotherParam
{
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    
    switch (index) {
        case 0:
        {
            [date setDateFormat:@"yyyyMMddHHmmss"];
        }
            break;
        case 1:
        {
            [date setDateFormat:@"yyyyMMdd"];
        }
            break;
        case 2:
        {
            [date setDateFormat:@"HHmmss"];
        }
            break;
            
        default:
            break;
    }
    
    NSDate *d1=[date dateFromString:oneParam];
    
    NSTimeInterval late1=[d1 timeIntervalSince1970]*1;
    
    NSDate *d2=[date dateFromString:anotherParam];
    
    NSTimeInterval late2=[d2 timeIntervalSince1970]*1;
    
    NSTimeInterval cha=late2 -late1;
    
    NSString *day=@"";
//    NSString *house=@"";
//    NSString *min=@"";
//    NSString *sen=@"";
//    
//    sen = [NSString stringWithFormat:@"%d", (int)cha%60];
//    //        min = [min substringToIndex:min.length-7];
//    //    秒
//    sen=[NSString stringWithFormat:@"%@", sen];
//    
//    min = [NSString stringWithFormat:@"%d", (int)cha/60%60];
//    //        min = [min substringToIndex:min.length-7];
//    //    分
//    min=[NSString stringWithFormat:@"%@", min];
//    
//    //    小时
//    house = [NSString stringWithFormat:@"%d", (int)cha/3600];
//    //        house = [house substringToIndex:house.length-7];
//    house=[NSString stringWithFormat:@"%@", house];
    
    day = [NSString stringWithFormat:@"%d", (int)cha/3600 / 24];
    day = [NSString stringWithFormat:@"%@", day];
    
    
    
    return [day intValue];
}

/**
 *@brief index 0:yyyyMMddHHmmss   1:yyyyMMdd   2:HHmmss   返回 0:一样   1:前者日期大于后者日期   －1:前者时期小于后者日期
 *@param index  int    日期格式索引
 *@param oneDate  NSDate    第一个日期
 *@param anotherDate   NSDate    第二个日期
 *@return 返回int
 */
+(int)compareDate:(int)index withOneDate:(NSDate *)oneDate withAnotherDate:(NSDate *)anotherDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    switch (index) {
        case 0:
        {
            [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
        }
            break;
        case 1:
        {
            [dateFormatter setDateFormat:@"yyyyMMdd"];
        }
            break;
        case 2:
        {
            [dateFormatter setDateFormat:@"HHmmss"];
        }
            break;
            
        default:
            break;
    }
    NSString *oneDateStr = [dateFormatter stringFromDate:oneDate];
    NSString *anotherDateStr = [dateFormatter stringFromDate:anotherDate];
    NSDate *dateA = [dateFormatter dateFromString:oneDateStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDateStr];
    NSComparisonResult result = [dateA compare:dateB];
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
    
}

/**
 *@brief index 0:yyyyMMddHHmmss   1:yyyyMMdd   2:HHmmss   返回 0:一样   1:前者日期大于后者日期   －1:前者时期小于后者日期
 *@param index  int    日期格式索引
 *@param oneParam  NSString    第一个日期
 *@param anotherParam   NSString    第二个日期
 *@return 返回int
 */
+(int)compareDate:(int)index withOneneParam:(NSString *)oneParam withAnotherParam:(NSString *)anotherParam
{
    
    NSDateFormatter *inputFormatter= [[NSDateFormatter alloc] init];
    
    switch (index) {
        case 0:
        {
            [inputFormatter setDateFormat:@"yyyyMMddHHmmss"];
        }
            break;
        case 1:
        {
            [inputFormatter setDateFormat:@"yyyyMMdd"];
        }
            break;
        case 2:
        {
            [inputFormatter setDateFormat:@"HHmmss"];
        }
            break;
            
        default:
            break;
    }
    
    NSDate *inputOneDate = [inputFormatter dateFromString:oneParam];
    NSDate *inputAnotherDate = [inputFormatter dateFromString:anotherParam];

    NSComparisonResult result = [inputOneDate compare:inputAnotherDate];
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
    
}

@end
