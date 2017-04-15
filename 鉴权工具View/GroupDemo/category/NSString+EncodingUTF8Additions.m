//
//  NSString+EncodingUTF8Additions.m
//  selfService
//
//  Created by blue sky on 15/11/12.
//  Copyright © 2015年 sand. All rights reserved.
//

#import "NSString+EncodingUTF8Additions.h"

@implementation NSString (EncodingUTF8Additions)

/**
 *@brief 编码
 *@param param  数据
 *@return 返回NSString
 */
+(NSString *) URLEncodingUTF8String:(NSString *)param
{
    NSString *result = (__bridge NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)param, NULL, CFSTR(":/?#[]@!$&’()*+,;=%"),
kCFStringEncodingUTF8);
    return result;
}

/**
 *@brief 编码
 *@param param  数据
 *@return 返回NSString
 */
+(NSString *) URLDecodingUTF8String:(NSString *)param
{
    NSString *result = (__bridge NSString *) CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (CFStringRef)param, CFSTR(""), kCFStringEncodingUTF8);
    return result;
}

@end
