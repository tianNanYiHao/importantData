//
//  SandMQTTClientHelper.h
//  MQTTClientDEMO
//
//  Created by tianNanYiHao on 2017/4/28.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SandMQTTClientNewsBlock)(NSString *dataStr);

@interface SandMQTTClientHelper : NSObject
@property (nonatomic,strong) SandMQTTClientNewsBlock sandmqttClientNewsBlock;


/**
 单例对象
 */
+ (SandMQTTClientHelper*)shareSandMQTTClientInstance;



/**
 用户主题模式

 @param userID 用户ID
 @param block 消息回调
 */
- (void)subscribeToTopicUserID:(NSString*)userID sandMqttNewsBlock:(SandMQTTClientNewsBlock)block;



/**
 广播主题模式

 @param block 消息回调
 */
- (void)subscribeToTopicBoardSandMqttNewsBlock:(SandMQTTClientNewsBlock)block;



/**
 mqtt断开连接
 */
- (void)sandMqttDisConnect;



/**
 mqtt重连
 */
- (void)sandMqttConnect;



/**
 mqtt关闭
 */
- (void)sandMqttClosed;


@end
