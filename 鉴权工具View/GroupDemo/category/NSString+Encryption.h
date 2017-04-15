//
//  NSString+Encryption.h
//  collectionTreasure
//
//  Created by blue sky on 15/7/30.
//  Copyright (c) 2015年 sand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Encryption)

/**
 *@brief sha1加密
 *@param param  字符串  参数
 *@return 返回NSString
 */
+ (NSString *) sha1:(NSString *)param;

/**
 *@brief md5 32 位加密
 *@param param  字符串  参数
 *@return 返回NSString
 */
+ (NSString *)md5WithNSString:(NSString *)param;

/**
*@brief md5 32 位加密 （NSData 转   NSString）
*@param param  NSData  参数
*@return 返回NSString
*/
+ (NSString*)md5WithData:(NSData *)data;

/**
 *@brief 十六进制转换为普通字符串
 *@param param  NSString  参数
 *@return 返回NSString
 */
+ (NSString *)stringFromHexString:(NSString *)param;

/**
 *@brief 普通字符串转换为十六进制
 *@param param  NSString  参数
 *@return 返回NSString
 */
+ (NSString *)hexStringFromString:(NSString *)param;

@end
