//
//  NSString+URLEncoding.m
//  QuickPos
//
//  Created by Leona on 15/3/24.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "NSString+URLEncoding.h"

@implementation NSString_URLEncoding
- (NSString *)URLEncodedString
{
    NSString *result = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)self,
                                            NULL,
                                            CFSTR("!*'();:@&=+$,/?%#[] "),
                                            kCFStringEncodingUTF8));
    
    return result;
}

- (NSString*)URLDecodedString
{
    NSString *result = (NSString *)
    CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                            (CFStringRef)self,
                                                            CFSTR(""),
                                                            kCFStringEncodingUTF8));
    
    return result;  
}
@end
