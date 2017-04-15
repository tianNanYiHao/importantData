//
//  NSString+Money.m
//  sand_mobile_mask
//
//  Created by blue sky on 14-9-9.
//  Copyright (c) 2014年 sand. All rights reserved.
//

#import "NSString+Money.h"

@implementation NSString (Money)

/**
 *@brief 判断字符串是否为空
 *@param param 字符串 参数：金钱字符串
 *@return 返回NSString
 */
+ (NSString *)transfer:(NSString *)param
{
    NSString *result = @"";
    if ([@"" isEqualToString:param] || param == nil) {
        param = @"0";
    }else{
        double doubleParam = [param doubleValue];
        NSString *temp = [NSString stringWithFormat:@"%f", doubleParam];
        NSRange range = [temp rangeOfString:@"."];
        NSUInteger index = range.location;
        result = [param substringWithRange:NSMakeRange(0, index + 3)];
    }
    return result;
}

/**
 *@brief 把金钱转成12位的字符串
 *@param param 字符串 参数：金钱字符串
 *@return 返回NSString
 */
+ (NSMutableString *)moneyToTwelfthUnit:(NSString *)param
{
    NSMutableString *result = nil;
    if ([@"" isEqualToString:param] || param == nil) {
        param = @"0";
    }else{
        double doubleParam = [param doubleValue];
        NSString *temp = [NSString stringWithFormat:@"%f", doubleParam];
        NSRange range = [temp rangeOfString:@"."];
        NSUInteger index = range.location;
        NSString *before = [temp substringWithRange:NSMakeRange(0, index)];
        NSString *after = [temp substringWithRange:NSMakeRange(index +1, 2)];
        
        NSUInteger length = 10 - before.length;
        
        NSMutableString *pingJie = [NSMutableString stringWithFormat:@"%@", @""];
        for (int i = 0; i < length; i++) {
            [pingJie appendFormat:@"%@", @"0"];
        }
        
        result = [NSMutableString stringWithFormat:@"%@%@%@",pingJie, before, after];
    }
    
    return result;
}

/**
 *@brief 把12位的字符串转成金钱
 *@param param 字符串 参数：金钱字符串
 *@return 返回NSString
 */
+ (NSMutableString *)twelfthUnitToMoney:(NSString *)param
{
    NSMutableString *result = nil;
    if ([@"" isEqualToString:param] || param == nil) {
        param = @"0";
    }else{
        NSInteger lenght = param.length;
        if (lenght == 13) {
            NSString *firstStr = [param substringWithRange:NSMakeRange(0, 1)];
            NSString *secondStr = [param substringWithRange:NSMakeRange(1, lenght - 3)];
            NSString *thirdStr = [param substringWithRange:NSMakeRange(lenght - 3, 2)];
            
            NSInteger integerTemp = [secondStr integerValue];
            
            
            result = [NSMutableString stringWithFormat:@"%@%ld.%@", firstStr, integerTemp, thirdStr];
        } else {
            NSString *firstStr = [param substringWithRange:NSMakeRange(0, lenght - 2)];
            NSString *secondStr = [param substringWithRange:NSMakeRange(lenght - 2, 2)];
            
            NSInteger integerTemp = [firstStr integerValue];
            
            
            result = [NSMutableString stringWithFormat:@"%ld.%@", integerTemp, secondStr];
        }
        
    }
    
    return result;
}

/**
 *@brief 把12位的字符串转成格式化的金钱
 *@param param 字符串 参数：金钱字符串
 *@return 返回NSString
 */
+ (NSMutableString *)twelfthUnitToFormatMoney:(NSString *)param
{
    NSMutableString *result = nil;
    NSString *substringResult = nil;
    NSUInteger count = 0;
    if ([@"" isEqualToString:param] || param == nil) {
        param = @"0";
    }else{
        NSInteger lenght = param.length;
        if (lenght == 13) {
            substringResult = [param substringWithRange:NSMakeRange(1, 12)];
        }
        
        substringResult = param;
        
        NSInteger substringResultLenght = substringResult.length;
        
        NSString *beforeStr = [substringResult substringWithRange:NSMakeRange(0, substringResultLenght - 2)];
        
        NSString *afterStr = [substringResult substringWithRange:NSMakeRange(substringResultLenght - 2, 2)];
        
        NSInteger integerTemp = [beforeStr integerValue];
        NSMutableString *str = [NSMutableString stringWithFormat:@"%ld", integerTemp];
        
        if (str.length % 3 == 0) {
            count = str.length / 3;
        } else {
            count = str.length / 3  + 1;
        }
        
        for (int i = 1; i <= count; i++) {
            if (i == 1) {
                [str insertString:@"," atIndex: str.length - i * 3];
            } else if (i == count) {
                str = str;
            }else {
                [str insertString:@"," atIndex:str.length - ((i * 3) + (i - 1))];
            }
        }
        
        result = [NSMutableString stringWithFormat:@"%@.%@", str, afterStr];
        
    }
    
    return result;
}


/**
 *@brief 把字符串转成格式化的金钱
 *@param param 字符串 参数：金钱字符串
 *@return 返回NSString
 */
+ (NSMutableString *)formatMoney:(NSString *)param
{
    NSMutableString *result = nil;
    if ([@"" isEqualToString:param] || param == nil) {
        param = @"0";
    }else{
        double doubleParam = [param doubleValue];
        NSString *temp = [NSString stringWithFormat:@"%f", doubleParam];
        NSRange range = [temp rangeOfString:@"."];
        NSInteger index = range.location;
        NSString *before = [temp substringWithRange:NSMakeRange(0, index)];
        NSString *after = [temp substringWithRange:NSMakeRange(index +1, 2)];
        
        result = [NSMutableString stringWithFormat:@"%@.%@", before, after];
    }
    
    return result;
}


/**
 *@brief  拼接字符串
 *@param param1 字符串 参数：金钱字符串
 *@param param2 字符串 参数：金钱字符串
 *@return 返回NSString
 */
+ (NSString *)stringToMoney:(NSString *)param1 param2:(NSString *)param2
{
    NSString *result = @"";
    
    if ([@"" isEqualToString:param2]) {
        if ([@"¥" isEqualToString:param1] || [@"" isEqualToString:param1]) {
            return @"";
        }
        
        result = [param1 substringWithRange:NSMakeRange(0, param1.length - 1)];
        
        if ([@"¥" isEqualToString:result] || [@"" isEqualToString:result]) {
            return @"";
        }
        
        return result;
    }
    
    result = [@"¥" stringByAppendingString: param1];
    
    NSArray *symbolArray = [result componentsSeparatedByString:@"¥"];
    
    if ((symbolArray.count - 1) > 1) {
        result = [result substringWithRange:NSMakeRange(1, result.length - 1)];
    }
    
    result = [result stringByAppendingString: param2];
    if(result.length == 1){
        if ([@"." isEqualToString:param2] || [@"0" isEqualToString:param2]) {
            return @"";
        }
    }
    
    NSArray *array = [result componentsSeparatedByString:@"."];
    if ((array.count - 1) > 1) {
        result = [result substringWithRange:NSMakeRange(0, result.length - 1)];
    }
    
    NSInteger location = [result rangeOfString:@"."].location;
    if ((array.count - 1) > 0) {
         if ((result.length - 1 - location) > 2) {
             result = [result substringWithRange:NSMakeRange(0, [result rangeOfString:@"."].location + 3)];
         }
    } else {
        if (result.length > 11) {
            result = [result substringWithRange:NSMakeRange(0, result.length - 1)];
        }
    }
    
    return result;
}

/**
 *@brief 格式化金钱
 *@param param 字符串 参数：金钱字符串
 *@return 返回NSString
 */
+ (NSMutableString *)formatSymolMoney:(NSString *)param
{
    NSMutableString *result = nil;
    NSUInteger count = 0;
    if ([@"" isEqualToString:param] || param == nil) {
        param = @"0";
    }else{
        NSString *strParam = [NSString stringWithFormat:@"%.2f", [param doubleValue]];
        
        NSInteger strParamLenght = strParam.length;
        
        NSString *beforeStr = [strParam substringWithRange:NSMakeRange(0, strParamLenght - 3)];
        
        NSString *afterStr = [strParam substringWithRange:NSMakeRange(strParamLenght - 3, 3)];
        
        NSMutableString *str = [NSMutableString stringWithFormat:@"%@", beforeStr];
        
        if (str.length > 3) {
            if (str.length % 3 == 0) {
                count = str.length / 3;
            } else {
                count = str.length / 3  + 1;
            }
            
            for (int i = 1; i <= count; i++) {
                if (i == 1) {
                    [str insertString:@"," atIndex: str.length - i * 3];
                } else if (i == count) {
                    str = str;
                }else {
                    [str insertString:@"," atIndex:str.length - ((i * 3) + (i - 1))];
                }
            }
        }
        
        result = [NSMutableString stringWithFormat:@"%@%@", str, afterStr];
        
    }
    
    return result;
}

@end
