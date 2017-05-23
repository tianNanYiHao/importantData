//
//  UITextField+CheckLenght.m
//  selfService
//
//  Created by blue sky on 15/12/30.
//  Copyright © 2015年 sand. All rights reserved.
//

#import "UITextField+CheckLenght.h"
#import <objc/runtime.h>

@implementation UITextField (CheckLenght)

static char minKey;
static char maxKey;

/**
 *@brief 检验手机号码长度
 *@param index  int    索引
 *@param param  NSString串    时间参数
 *@return 返回NSString
 */
+ (void)checkPhoneNum:(UITextField *)textField
{
    
}

/**
 *@brief 检验最小长度
 *@param index  int    长度值
 *@return 返回NSString
 */
- (void)setMinLenght:(NSString *)newMinLenght
{
    objc_setAssociatedObject(self, &minKey, newMinLenght ,OBJC_ASSOCIATION_ASSIGN);
}

- (NSString *)minLenght
{
    return objc_getAssociatedObject(self, &minKey);
}


/**
 *@brief 检验最大长度
 *@param index  int    长度值
 *@return 返回NSString
 */
- (void)setMaxLenght:(NSString *)newMaxLenght
{
    objc_setAssociatedObject(self, &maxKey, newMaxLenght ,OBJC_ASSOCIATION_ASSIGN);
}

- (NSString *)maxLenght
{
    return objc_getAssociatedObject(self, &maxKey);
}



/**
 密码正则校验
 
 @param pwd 密码
 @param regular 下发的正则
 @return 校验结果
 */
+(BOOL)regularPassWd:(NSString*)pwd regular:(NSString*)regular{
    
    NSString *passWordRegex = regular;
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:pwd];
}




/**
 支付(纯数字)密码连续输入+过于简单校验
 
 @param pwd 密码
 @return 检验结果
 */
+(BOOL)passWdTooSimple:(NSString*)pwd{
    
    
    //1.匹配3位以上的重复数字
    NSString *passWordRegex1 = @"([\\d])\\1{2,}";
    NSPredicate *passWordPredicate1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex1];
    if([passWordPredicate1 evaluateWithObject:pwd] == YES){
        return NO;
    }
    
    //2.匹配6位顺增或顺降
    NSString *passWordRegex2 = @"(?:(?:0(?=1)|1(?=2)|2(?=3)|3(?=4)|4(?=5)|5(?=6)|6(?=7)|7(?=8)|8(?=9)){5}|(?:9(?=8)|8(?=7)|7(?=6)|6(?=5)|5(?=4)|4(?=3)|3(?=2)|2(?=1)|1(?=0)){5})\\d";
    NSPredicate *passWordPredicate2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex2];
    if([passWordPredicate2 evaluateWithObject:pwd] == YES){
        return NO;
    }
    
    //3.匹配111222 111122类型
    NSString *passWordRegex3 = @"([\\d])\\1{1,}([\\d])\\2{1,}";
    NSPredicate *passWordPredicate3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex3];
    if([passWordPredicate3 evaluateWithObject:pwd] == YES){
        return NO;
    }
    
    return YES;
}


@end
