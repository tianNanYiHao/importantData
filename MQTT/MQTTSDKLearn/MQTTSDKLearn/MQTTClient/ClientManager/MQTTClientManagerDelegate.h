//
//  MQTTClientManagerDelegate.h
//  MQTTSDKLearn
//
//  Created by Vie on 2017/3/3.
//  Copyright © 2017年 Vie. All rights reserved.
//



/**
 MQTTClientManager委托事件
 */
#import "MQTTStatus.h"

@protocol MQTTClientManagerDelegate <NSObject>
@optional
/**
 连接状态返回

 @param status 错误码和错误info
 */
-(void)didMQTTReceiveServerStatus:(MQTTStatus *)status;

/**
 服务器推送消息返回

 @param topic 消息主题
 @param dic 消息内容，JSON转字典
 */
-(void)messageTopic:(NSString *)topic data:(NSDictionary *)dic;


/**
 服务器推送消息返回

 @param topic 消息主题
 @param jsonStr 消息内容，JSON字符串
 */
-(void)messageTopic:(NSString *)topic jsonStr:(NSString *)jsonStr;
@end

