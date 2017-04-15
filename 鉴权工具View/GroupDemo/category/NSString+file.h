//
//  NSString+file.h
//  sand_mobile_mask
//
//  Created by blue sky on 14-8-9.
//  Copyright (c) 2014年 sand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (file)

/**
 *@brief 拼接字符串
 *@param append  字符串    要拼接字符串的数组
 *@return 返回NSString
 */
- (NSString *)filenameAppend:(NSString *)append;

@end
