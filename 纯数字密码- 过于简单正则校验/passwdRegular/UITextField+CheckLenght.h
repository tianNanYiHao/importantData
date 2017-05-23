//
//  UITextField+CheckLenght.h
//  selfService
//
//  Created by blue sky on 15/12/30.
//  Copyright © 2015年 sand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (CheckLenght)

//设置最小长度
- (void)setMinLenght:(NSString *)newMinLenght;
- (NSString *)minLenght;

//设置最大长度
- (void)setMaxLenght:(NSString *)newMaxLenght;
- (NSString *)maxLenght;


/**
 密码正则校验
 
 @param pwd 密码
 @param regular 下发的正则
 @return 校验结果
 */
+(BOOL)regularPassWd:(NSString*)pwd regular:(NSString*)regular;

/**
 支付(纯数字)密码连续输入+过于简单校验
 
 @param pwd 密码
 @return 检验结果
 */
+(BOOL)passWdTooSimple:(NSString*)pwd;

@end
