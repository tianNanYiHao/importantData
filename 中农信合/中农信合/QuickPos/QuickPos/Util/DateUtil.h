//
//  DateUtil.h
//  DuoYing
//
//  Created by zhjb on 14-12-14.
//  Copyright (c) 2014年 zhjb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtil : NSObject

+(NSDictionary*)getDayFrom:(NSString*)str;

+(NSString*)getCurDayString;

+(NSString*)getCurTimeString;

@end
