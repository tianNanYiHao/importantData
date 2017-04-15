//
//  UIDevice+DeviceoInfo.h
//  selfService
//
//  Created by blue sky on 16/2/18.
//  Copyright © 2016年 sand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (DeviceoInfo)

/**
 *@brief 手机别名
 *@return 返回NSString
 */
+(NSString *)phoneName;

/**
 *@brief 手机系统版本
 *@return 返回NSString
 */
+(NSString *)phoneVersion;


/**
 *@brief 手机型号
 *@return 返回NSString
 */
+(NSString *)phoneModel;


/**
 *@brief  设备版本
 *  @return 返回NSString
 */
+ (NSString*)deviceVersion;

@end
