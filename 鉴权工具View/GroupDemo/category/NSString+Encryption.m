//
//  NSString+Encryption.m
//  collectionTreasure
//
//  Created by blue sky on 15/7/30.
//  Copyright (c) 2015年 sand. All rights reserved.
//

#import "NSString+Encryption.h"
#include <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>

@implementation NSString (Encryption)

/**
 *@brief sha1加密
 *@param param  字符串  参数
 *@return 返回NSString
 */
+ (NSString *) sha1:(NSString *)param;
{
    const char *cstr = [param cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:param.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

/**
 *@brief md5 32 位加密
 *@param param  字符串  参数
 *@return 返回NSString
 */
+ (NSString *)md5WithNSString:(NSString *)param
{
    const char *cStr = [param UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

/**
 *@brief md5 32 位加密 （NSData 转   NSString）
 *@param param  NSData  参数
 *@return 返回NSString
 */
+ (NSString*)md5WithData:(NSData *)data{
    unsigned char result[16];
    CC_MD5([data bytes], (int)[data length], result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
    
}


/**
 *@brief 十六进制转换为普通字符串
 *@param param  NSString  参数
 *@return 返回NSString
 */
+ (NSString *)stringFromHexString:(NSString *)param
{
    char *myBuffer = (char *)malloc((int)[param length] / 2 + 1);
    bzero(myBuffer, [param length] / 2 + 1);
    for (int i = 0; i < [param length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [param substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    
    return unicodeString;
}


/**
 *@brief 普通字符串转换为十六进制
 *@param param  NSString  参数
 *@return 返回NSString
 */
+ (NSString *)hexStringFromString:(NSString *)param
{
    NSData *myD = [param dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr]; 
    } 
    return hexStr; 
}

@end
