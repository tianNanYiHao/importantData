//
//  NSString+Money.h
//  sand_mobile_mask
//
//  Created by blue sky on 14-9-9.
//  Copyright (c) 2014年 sand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Money)

/**
 *@brief 判断字符串是否为空
 *@param param 字符串 参数：金钱字符串
 *@return 返回NSString
 */
+ (NSString *)transfer:(NSString *)param;

/**
 *@brief 把金钱转成12位的字符串
 *@param param 字符串 参数：金钱字符串
 *@return 返回NSString
 */
+ (NSMutableString *)moneyToTwelfthUnit:(NSString *)param;

/**
 *@brief 把12位的字符串转成金钱
 *@param param 字符串 参数：金钱字符串
 *@return 返回NSString
 */
+ (NSMutableString *)twelfthUnitToMoney:(NSString *)param;

/**
 *@brief 把12位的字符串转成格式化的金钱
 *@param param 字符串 参数：金钱字符串
 *@return 返回NSString
 */
+ (NSMutableString *)twelfthUnitToFormatMoney:(NSString *)param;

/**
 *@brief 把字符串转成格式化的金钱
 *@param param 字符串 参数：金钱字符串
 *@return 返回NSString
 */
+ (NSMutableString *)formatMoney:(NSString *)param;

/**
 *@brief  拼接字符串
 *@param param1 字符串 参数：金钱字符串
 *@param param2 字符串 参数：金钱字符串
 *@return 返回NSString
 */
+ (NSString *)stringToMoney:(NSString *)param1 param2:(NSString *)param2;

/**
 *@brief 格式化金钱
 *@param param 字符串 参数：金钱字符串
 *@return 返回NSString
 */
+ (NSMutableString *)formatSymolMoney:(NSString *)param;

@end
