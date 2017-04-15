//
//  NSString+string.m
//  sand_mobile_mask
//
//  Created by blue sky on 14-9-9.
//  Copyright (c) 2014年 sand. All rights reserved.
//

#import "NSString+string.h"
#import <UIKit/UIKit.h>

@implementation NSString (string)

/**
 *@brief 判断字符串是否为空
 *@param param 字符串 参数：传值
 *@return 返回Bool 为空为ture， 不为空为false
 */

+ (BOOL)isNil:(NSString *)param
{
    if([@"" isEqualToString:param] && param == nil){
        return true;
    }else {
        return false;
    }
}

/**
 *@brief 拼接字符串
 *@param array  数组    要拼接字符串的数组
 *@param symbol 字符串  隔开符号
 *@return 返回NSString
 */

+ (NSString *)stringAppding:(NSMutableArray *)array symbol:(NSString *)symbol
{
    NSInteger count = array.count;
    NSString * result = @"";
    
    for (int i = 0; i < count; i++) {
        if (0 == i) {
            result = [result stringByAppendingString:array[i]];
        }else{
            result = [result stringByAppendingString:symbol];
            result = [result stringByAppendingString:array[i]];
        }
    }
    return result;
}

/**
 *@brief MD5加密
 *@param signString 字符串
 *@return 返回NSString
 */

+ (NSString *)createMD5:(NSString *)signString
{
//    const char* cStr = [signString UTF8String];
    unsigned char result[16];
    
//    CC_MD5(cStr, strlen(cStr), result);
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X", result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
}

/**
 *@brief 通过区分字符串验证邮箱
 *@param email 字符串
 *@return 返回Bool 正确为true，  错误犯错
 */

+(BOOL)validateEmail:(NSString*)email
{
    if((0 != [email rangeOfString:@"@"].length) &&
       (0 != [email rangeOfString:@"."].length))
    {
        NSCharacterSet* tmpInvalidCharSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
        NSMutableCharacterSet* tmpInvalidMutableCharSet = [tmpInvalidCharSet mutableCopy];
        [tmpInvalidMutableCharSet removeCharactersInString:@"_-"];
        
        
        NSRange range1 = [email rangeOfString:@"@"
                                      options:NSCaseInsensitiveSearch];
        
        //取得用户名部分
        NSString* userNameString = [email substringToIndex:range1.location];
        NSArray* userNameArray   = [userNameString componentsSeparatedByString:@"."];
        
        for(NSString* string in userNameArray)
        {
            NSRange rangeOfInavlidChars = [string rangeOfCharacterFromSet: tmpInvalidMutableCharSet];
            if(rangeOfInavlidChars.length != 0 || [string isEqualToString:@""])
                return NO;
        }
        
        //取得域名部分
        NSString *domainString = [email substringFromIndex:range1.location+1];
        NSArray *domainArray   = [domainString componentsSeparatedByString:@"."];
        
        for(NSString *string in domainArray)
        {
            NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet:tmpInvalidMutableCharSet];
            if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])
                return NO;
        }
        
        return YES;
    }
    else {
        return NO;
    }
}

/**
 *@brief 利用正则表达式验证邮箱
 *@param email 字符串
 *@return 返回Bool
 */

+(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/**
 *@brief 判断字符串是否包含特殊字符
 *@param myString 字符串
 *@return 返回Bool 包含为 true， 不包含为false
 */

+(BOOL)isValidateString:(NSString *)myString
{
    NSCharacterSet *nameCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"] invertedSet];
    NSRange userNameRange = [myString rangeOfCharacterFromSet:nameCharacters];
    if (userNameRange.location != NSNotFound) {
        //NSLog(@"包含特殊字符");
        return FALSE;
    }else{
        return TRUE;
    }
}

/**
 *@brief 拼接字符串
 *@param append  字符串    要拼接字符串的数组
 *@return 返回NSString
 */

+ (NSString *)filenameAppend:(NSString *)append
{
    // 1.获取没有拓展名的文件名
    NSString *filename = [append stringByDeletingPathExtension];
    
    // 2.拼接append
    filename = [filename stringByAppendingString:append];
    
    // 3.拼接拓展名
    NSString *extension = [append pathExtension];
    
    // 4.生成新的文件名
    return [filename stringByAppendingPathExtension:extension];
}

/**
 *@brief 拼接字符串(条形码格式)
 *@param content  字符串    要拼接字符串的数组
 *@return 返回NSString
 */
+ (NSString *)oneCodeContentFotmat:(NSString *)content
{
    NSString *symbol = @"   ";
    NSString *oneContent = [content substringWithRange:NSMakeRange(0, 4)];
    NSString *twoContent = [content substringWithRange:NSMakeRange(4, 4)];
    NSString *threeContent = [content substringWithRange:NSMakeRange(8, 4)];
    NSString *fourContent = [content substringWithRange:NSMakeRange(12, content.length - 12)];
    
    NSMutableString *result = [NSMutableString stringWithFormat:@"%@%@%@%@%@%@%@", oneContent, symbol, twoContent, symbol, threeContent, symbol, fourContent];
    
    return result;
}

/**
 *@brief 拼接字符串(条形码格式)
 *@param param  字符串    要转化拼音的汉子
 *@return 返回NSString
 */
+ (NSString *)hanziToPinyin:(NSString *)param
{
    NSMutableString *str;
    if ([param length])
    {
        str = [[NSMutableString alloc] initWithString:param];
        // 先转换为带声调的拼音
        CFStringTransform (( CFMutableStringRef )str, NULL , kCFStringTransformMandarinLatin , NO );
        // 再转换为不带声调的拼音
        CFStringTransform (( CFMutableStringRef )str, NULL , kCFStringTransformStripDiacritics , NO );
    }
    
    return str;
}

/**
 *@brief 文字大小
 *@param font  UIFont  字体
 *@return 返回CGSize
 */
- (CGSize)sizeWithNSStringFont:(UIFont *)font
{
    CGSize size =  [self sizeWithAttributes:@{NSFontAttributeName:font}];
    
    return CGSizeMake(size.width + 5, size.height);
}

/**
 *@brief 手机号格式字符串
 *@param param  字符串    手机号
 *@return 返回NSString
 */
+ (NSString *)phoneNumFormat:(NSString *)param
{
    if (param.length <= 0) {
        return  @"";
    }
    return [NSString stringWithFormat:@"%@%@%@", [param substringWithRange:NSMakeRange(0, 3)], @"****", [param substringWithRange:NSMakeRange(7, 4)]];
}

@end
