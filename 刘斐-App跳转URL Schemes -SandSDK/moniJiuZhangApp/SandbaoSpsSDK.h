//
//  SdSpsPay.h
//  moniJiuZhangApp
//
//  Created by tianNanYiHao on 2017/8/1.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SdSpsPayBack)(NSString *urlStr);

@interface SandbaoSpsSDK : NSObject

@property (nonatomic,assign)SdSpsPayBack block;

/**
 处理第三方应用跳转杉德宝方法,传递订单TN号

 @param TNnumber TN号
 */
+(void)jumpToSandBaoForPay:(NSString*)TNnumber;



/**
 处理杉德宝客户端程序通过URL启动第三方应用时传递的数据
 需要在 application:openURL:sourceApplication:annotation:或者application:handleOpenURL中调用
 此方法用于与微博/微信等做区分

 @param url URL
 @return 标识
 */
+(BOOL)canOpenUrl:(NSURL*)url;


/**
  处理杉德宝客户端程序通过URL启动第三方应用时传递的数据,通过block回调处理数据/事件
 需要在 application:openURL:sourceApplication:annotation:或者application:handleOpenURL中调用

 @param url url
 @param block 回调
 @return 标识
 */
+(BOOL)jumpBackPayInfo:(NSURL*)url infoBlock:(SdSpsPayBack)block;



@end
