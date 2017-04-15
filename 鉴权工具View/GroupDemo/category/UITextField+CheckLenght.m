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

@end
