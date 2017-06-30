//
//  SDNetwork.h
//  sandbaocontrol
//
//  Created by blue sky on 2016/11/24.
//  Copyright © 2016年 sand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDFile.h"

//网络类型
typedef NS_ENUM(NSInteger, NetworkType) {
    NETWORN_NONE = 0,
    NETWORN_WIFI = 1,
    NETWORN_2G = 2,
    NETWORN_3G = 3,
    NETWORN_4G = 4,
    NETWORN_MOBILE = 5
};

@interface SDNetwork : NSObject

//请求超时时间
@property (nonatomic, assign) NSInteger timeoutInterval;
//网络上传超时时间
@property (nonatomic, assign) NSInteger timeoutInterval_up;


/**
 *@brief 网络类型
 *@return WIFI, 4G, 3G, 2G, NO-NETWORK
 */
- (NSString *)stringWithNetworkType;

/**
 *@brief 网络类型
 *@return 0：没有网络 --- 1:WiFi --- 2:2G --- 3:3G --- 4:4G --- 5:NETWORN_MOBILE
 */
- (NSInteger)integerWithNetworkType;


/**
 *@brief 系统httpPost 请求(key的模式)
 *@param requestUrl 字符串 参数标示：请求地址
 *@param messageInfo 字符串 参数标示：业务信息
 *@return 字符串
 */
- (NSString *)httpSystemPost:(NSString *)requestUrl messageInfo:(NSString *)messageInfo;


/**
 *@brief 系统httpPost 请求(key的模式)(带有header)
 *@param requestUrl 字符串 参数标示：请求地址
 *@param headerFieldsDic 字典 参数标示：请求头
 *@param messageInfo 字符串 参数标示：业务信息
 *@return 字符串
 */
- (NSString *)httpSystemPost:(NSString *)requestUrl headerFieldsDic:(NSDictionary *)headerFieldsDic messageInfo:(NSString *)messageInfo;

/**
 *@brief 系统httpJsonPost 请求（json的模式）
 *@param requestUrl 字符串 参数标示：请求地址
 *@param messageInfo 字符串 参数标示：业务信息
 *@return 字符串
 */
- (NSString *)httpSystemJsonPost:(NSString *)requestUrl messageInfo:(NSString *)messageInfo;

#pragma mark - 上传文件
/**
 *@brief 上传文件
 *@param requestUrl NSURL 参数标示：请求地址
 *@param SDFileInfo SDFile 参数标示：文件信息
 *@param messageInfo  字符串  参数标示：报文信息
 *@return
 */
- (NSString *)upFile:(NSString *)requestUrl SDFileInfo:(SDFile *)SDFileInfo messageInfo:(NSString *)messageInfo;

@end
