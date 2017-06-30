//
//  SDLog.h
//  sandbao
//
//  Created by blue sky on 2016/12/6.
//  Copyright © 2016年 sand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDLog : NSObject

/**
 *@brief 调试日志
 *@param logFlag BOOL 参数：日志标识
 *@return
 */
+ (void)setLogFlag:(BOOL)logFlag;

/**
 *@brief 调试日志
 *@param logParam NSString 参数：日志参数
 *@return
 */
+ (void)logDebug:(NSString *)logParam;

/**
 *@brief 异常错误日志
 *@param logParam NSString 参数：日志参数
 *@return
 */
+ (void)logError:(NSString *)logParam;

/**
 *@brief 网络日志
 *@param logParam NSString 参数：日志参数
 *@return
 */
+ (void)logNetwork:(NSString *)logParam;

/**
 *@brief 警告提示日志
 *@param logParam NSString 参数：日志参数
 *@return
 */
+ (void)logWarn:(NSString *)logParam;

/**
 *@brief 测试日志
 *@param logParam NSString 参数：日志参数
 *@return
 */
+ (void)logTest:(NSString *)logParam;

@end
