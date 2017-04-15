//
//  NSRegularExpression+Verification.m
//  aunnalMeeting
//
//  Created by blue sky on 15/1/12.
//  Copyright (c) 2015年 sand. All rights reserved.
//

#import "NSRegularExpression+Verification.h"

@implementation NSRegularExpression (Verification)

/**
 *@brief 是否为空
 *@param param 字符串 参数：字符串
 *@return 返回BOOL
 */
+ (BOOL) isNil:(NSString *)param
{
    return [@"" isEqualToString:param] || param == nil;
}

/**
 *@brief 邮箱
 *@param email 字符串 参数：邮箱
 *@return 返回BOOL
 */
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/**
 *@brief 固定电话号码验证
 *@param mobile 字符串 参数：固定电话号码验证
 *@return 返回BOOL
 */
+ (BOOL) validateFixedTelPhone:(NSString *)mobile
{
    NSString *fixedTelPhoneRegex = @"^0([1-9]{1}\\d{1,3}-)\\d{7,8}$";
    NSPredicate *fixedTelPhoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",fixedTelPhoneRegex];
    return [fixedTelPhoneTest evaluateWithObject:mobile];
}

/**
 *@brief 手机号码验证  手机号以13，14， 15，16，17，18，19开头，八个 \d 数字字符
 *@param mobile 字符串 参数：手机号码验证
 *@return 返回BOOL
 */
+ (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13，14，15，18开头，八个 \d 数字字符
     NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
//    NSString *phoneRegex = @"^((10[0-9])|(11[0-9])|(12[0-9])|(13[0-9])|(14[^4,\\D])|(15[^4,\\D])|(16[0-9])|(17[0-9])|(18[0,0-9])|(19[0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

/**
 *@brief 车牌号验证
 *@param carNo 字符串 参数：车牌号验证
 *@return 返回BOOL
 */
+ (BOOL) validateCarNo:(NSString *)carNo
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}

/**
 *@brief 营业注册号码验证
 *@param mobile 字符串 参数：固定电话号码验证
 *@return 返回BOOL
 */
+ (BOOL) validateBusinessLicenseNumber:(NSString *)BusinessLicenseNumber
{
    BOOL result = NO;
    if (BusinessLicenseNumber.length == 15) {
        NSString *BusinessLicenseRegex1 = @"^\\d{15}+$";
        NSPredicate *BusinessLicensePredicate1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",BusinessLicenseRegex1];
        return [BusinessLicensePredicate1 evaluateWithObject:BusinessLicenseNumber];
    } else if (BusinessLicenseNumber.length == 18) {
        NSString *BusinessLicenseRegex = @"^[a-zA-Z0-9]{18}+$";
        NSPredicate *BusinessLicensePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",BusinessLicenseRegex];
        return [BusinessLicensePredicate evaluateWithObject:BusinessLicenseNumber];
    } else {
        result = NO;
        
    }
    return result;
}

/**
 *@brief 车型
 *@param CarType 字符串 参数：车型
 *@return 返回BOOL
 */
+ (BOOL) validateCarType:(NSString *)CarType
{
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:CarType];
}

/**
 *@brief 用户名
 *@param name 字符串 参数：用户名
 *@return 返回BOOL
 */
+ (BOOL) validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}

/**
 *@brief 6位到20位 数字和字母 密码
 *@param passWord 字符串 参数：密码
 *@return 返回BOOL
 */
+ (BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}

/**
 *@brief 数字和字母组合密码
 *@param passWord 字符串 参数：密码
 *@return 返回BOOL
 */
+ (BOOL) validatePasswordNumAndLetter:(NSString *)passWord
{
    NSString *passWordRegex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}

/**
 *@brief 数字和字母组合
 *@param param 字符串 参数：参数
 *@return 返回BOOL
 */
+ (BOOL) validateNumAndLetter:(NSString *)param
{
    NSString *NumAndLetterRegex = @"^[a-zA-Z0-9]+$";
    NSPredicate *NumAndLetterPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",NumAndLetterRegex];
    return [NumAndLetterPredicate evaluateWithObject:param];
}

/**
 *@brief 登录名
 *@param loginName 字符串 参数： 登录名
 *@return 返回BOOL
 */
+ (BOOL) validateLoginName:(NSString *)loginName
{
    //([a-zA-Z0-9_]+$)|([a-zA-Z0-9-]+$)|([a-zA-Z0-9/]+$)|([a-zA-Z0-9_-/]+$)|
    NSString *loginNameRegex = @"^[a-zA-Z0-9_\\-\\/]+$";
    NSPredicate *loginNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",loginNameRegex];
    return [loginNamePredicate evaluateWithObject:loginName];
}

/**
 *@brief 昵称
 *@param nickname 字符串 参数：昵称
 *@return 返回BOOL
 */
+ (BOOL) validateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{2,15}$";
    NSPredicate *nicknamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [nicknamePredicate evaluateWithObject:nickname];
}

/**
 *@brief 身份证号
 *@param identityCard 字符串 参数：身份证号
 *@return 返回BOOL
 */
+ (BOOL)validateIdentityCard:(NSString *)identityCard {
    identityCard = [identityCard stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSInteger length =0;
    if (!identityCard) {
        return NO;
    }else {
        length = identityCard.length;
        
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    NSString *valueStart2 = [identityCard substringToIndex:2];
    BOOL areaFlag =NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return NO;
    }
    
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year =0;
    switch (length) {
        case 15:
            year = [identityCard substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                       options:NSRegularExpressionCaseInsensitive
                                                                         error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                       options:NSRegularExpressionCaseInsensitive
                                                                         error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:identityCard
                                                              options:NSMatchingReportProgress
                                                                range:NSMakeRange(0, identityCard.length)];
            
            if(numberofMatch >0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            
            year = [identityCard substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                       options:NSRegularExpressionCaseInsensitive
                                                                         error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                       options:NSRegularExpressionCaseInsensitive
                                                                         error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:identityCard
                                                              options:NSMatchingReportProgress
                                                                range:NSMakeRange(0, identityCard.length)];
            
            if(numberofMatch >0) {
                int S = ([identityCard substringWithRange:NSMakeRange(0,1)].intValue + [identityCard substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([identityCard substringWithRange:NSMakeRange(1,1)].intValue + [identityCard substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([identityCard substringWithRange:NSMakeRange(2,1)].intValue + [identityCard substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([identityCard substringWithRange:NSMakeRange(3,1)].intValue + [identityCard substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([identityCard substringWithRange:NSMakeRange(4,1)].intValue + [identityCard substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([identityCard substringWithRange:NSMakeRange(5,1)].intValue + [identityCard substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([identityCard substringWithRange:NSMakeRange(6,1)].intValue + [identityCard substringWithRange:NSMakeRange(16,1)].intValue) *2 + [identityCard substringWithRange:NSMakeRange(7,1)].intValue *1 + [identityCard substringWithRange:NSMakeRange(8,1)].intValue *6 + [identityCard substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S %11;
                NSString *M =@"F";
                NSString *JYM =@"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                if ([M isEqualToString:[identityCard substringWithRange:NSMakeRange(17,1)]]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
                
            }else {
                return NO;
            }
        default:
            return NO;
    }
}

/**
 *@brief 银行卡
 *@param bankNum 字符串 参数：银行卡号
 *@return 返回BOOL
 */
+ (BOOL) validateBankCard:(NSString*) bankNum
{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[bankNum length];
    int lastNum = [[bankNum substringFromIndex:cardNoLength-1] intValue];
    
    bankNum = [bankNum substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [bankNum substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}

/**
 *@brief 业务证件号
 *@param businessNum 字符串 参数：业务证件号
 *@return 返回BOOL
 */
+ (BOOL) validatebBusinessNum: (NSString *)businessNum
{
    
    NSScanner* scan = [NSScanner scannerWithString:businessNum];
    int val;
    if ([scan scanInt:&val] != YES && [scan isAtEnd] != YES) {
        return NO;
    }
    
//    //去验证最后一位是否根据MOB11,10校验规则得到1
    int t1 = 10;
//    //去除最后一位检验后的号码校验
    NSString *tmpStr = [businessNum substringWithRange:NSMakeRange(0, businessNum.length - 1)];
    const char *mChar = [tmpStr UTF8String];
    
    for(int i = 0; i < strlen(mChar); i++)
    {
       int mod10 = (t1 + (mChar[i] - '0')) % 10;
        if (mod10 == 0) {
            mod10 = 10;
        } else {
            mod10 = 10;
            t1 = (mod10 * 2) % 11;
        }
    }
    
    if ((t1 + [[businessNum substringFromIndex:(businessNum.length - 1)] intValue]) % 10 != 1) {
        return NO;
    }
    
    return YES;
}


/**
 *@brief  验证特殊字符
 *@param specialChar 字符串 参数：输入字符串
 *@return 返回BOOL
 */
+ (BOOL) validateSpecialChar:(NSString *)specialChar
{
    NSString *specialCharRegex =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    NSPredicate* specialCharPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", specialCharRegex];
    return [specialCharPredicate evaluateWithObject:specialChar];
}

/**
 *@brief  验证空格字符
 *@param blankChar 字符串 参数：输入字符串
 *@return 返回BOOL
 */
+ (BOOL) validateSpecialBlankChar:(NSString *)blankChar
{
    NSString *specialCharRegex = @" ";
    
    if ([specialCharRegex rangeOfString:blankChar].location != NSNotFound) {
        return YES;
    } else {
        return NO;
    }
}

BOOL isNumber (char ch)
{
    if (!(ch >= '0' && ch <= '9')) {
        return FALSE;
    }
    return TRUE;
}

/**
 *@brief 纯数字验证
 *@param pureNum 字符串 参数：纯数字
 *@return 返回BOOL
 */
+ (BOOL) validatePureNum:(NSString *)pureNum
{
    const char *cvalue = [pureNum UTF8String];
    int len = (int)strlen(cvalue);
    for (int i = 0; i < len; i++) {
        if(!isNumber(cvalue[i])){
            return NO;
        }
    }
    return YES;
}

@end
