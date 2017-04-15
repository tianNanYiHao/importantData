//
//  NSString+string.h
//  sand_mobile_mask
//
//  Created by blue sky on 14-9-9.
//  Copyright (c) 2014年 sand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NSString (string)


/**
 *@brief 判断字符串是否为空
 *@param param 字符串 参数：传值
 *@return 返回Bool 为空为ture， 不为空为false
 */

+ (BOOL)isNil:(NSString *)param;

/**
 *@brief 拼接字符串
 *@param array  数组    要拼接字符串的数组
 *@param symbol 字符串  隔开符号
 *@return 返回NSString
 */

+ (NSString *)stringAppding:(NSMutableArray *)array symbol:(NSString *)symbol;

/**
 *@brief 拼接字符串
 *@param append  字符串    要拼接字符串的数组
 *@return 返回NSString
 */

+ (NSString *)filenameAppend:(NSString *)append;

/**
 *@brief 拼接字符串(条形码格式)
 *@param content  字符串    要拼接字符串的数组
 *@return 返回NSString
 */
+ (NSString *)oneCodeContentFotmat:(NSString *)content;

/**
 *@brief 拼接字符串(条形码格式)
 *@param param  字符串    要转化拼音的汉子
 *@return 返回NSString
 */
+ (NSString *)hanziToPinyin:(NSString *)param;

/**
 *@brief 文字大小
 *@param font  UIFont  字体
 *@return 返回CGSize
 */
- (CGSize)sizeWithNSStringFont:(UIFont *)font;

/**
 *@brief 手机号格式字符串
 *@param param  字符串    手机号
 *@return 返回NSString
 */
+ (NSString *)phoneNumFormat:(NSString *)param;

@end
