//
//  DateUtil.m
//  DuoYing
//
//  Created by zhjb on 14-12-14.
//  Copyright (c) 2014年 zhjb. All rights reserved.
//

#import "DateUtil.h"

@implementation DateUtil

+(NSDate*) getDateFromStr:(NSString*)str
{
    
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return  [df dateFromString:str];
}

+(NSString*)getCurDayString
{
    NSDate* now = [NSDate date];
    
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyyMMdd"];
    
    return [df stringFromDate:now];
}

+(NSString*)getCurTimeString
{
    NSDate* now = [NSDate date];
    
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyyMMdd-HHmmss"];
    
    return [df stringFromDate:now];
}

+(NSTimeInterval)getIntervalFrom:(NSDate*)date
{
    NSTimeInterval intverva = [date timeIntervalSinceDate:[NSDate date]];
    
    return intverva;
}

+(NSDictionary*)getDayFrom:(NSString*)str
{
    NSTimeInterval interval = [self getIntervalFrom:[self getDateFromStr:str]];
    
    int days = interval /(24*3600);
    
    int hours = (interval - days*24*3600)/3600;
    
    int minutes = (interval - days*24*3600 - hours*3600)/60;
    
    int seconds = (interval - days*24*3600 - hours*3600 - minutes*60);
    
    return @{@"days":@(days),@"hours":@(hours),@"minutes":@(minutes),@"seconds":@(seconds)};
    
}

@end
