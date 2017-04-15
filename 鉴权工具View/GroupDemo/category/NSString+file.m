//
//  NSString+file.m
//  sand_mobile_mask
//
//  Created by blue sky on 14-8-9.
//  Copyright (c) 2014年 sand. All rights reserved.
//

#import "NSString+file.h"

@implementation NSString (file)

/**
 *@brief 拼接字符串
 *@param append  字符串    要拼接字符串的数组
 *@return 返回NSString
 */
- (NSString *)filenameAppend:(NSString *)append
{
    // 获取没有拓展名的文件名
    NSString *filename = [self stringByDeletingPathExtension];
    
    // 拼接append
    filename = [filename stringByAppendingString:append];
    
    // 拼接拓展名
    NSString *extension = [self pathExtension];
    
    // 生成新的文件名
    return [filename stringByAppendingPathExtension:extension];
}



@end
