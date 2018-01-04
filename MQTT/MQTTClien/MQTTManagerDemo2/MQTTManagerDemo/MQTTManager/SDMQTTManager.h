//
//  SDMQTTManager.h
//  MQTTManagerDemo
//
//  Created by tianNanYiHao on 2018/1/3.
//  Copyright © 2018年 tianNanYiHao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MQTTClient/MQTTClient.h>

@protocol SDMQTTManagerDelegate<NSObject>

@required
- (void)messageTopic:(NSString*)toPic dataDic:(NSDictionary*)dic;

@end

@interface SDMQTTManager : NSObject

@property (nonatomic, strong) NSString *clientID;

@property (nonatomic, weak) id<SDMQTTManagerDelegate>delegate;

/**
 单例实例化

 @return 实例
 */
+ (instancetype)shareMQttManager;


/**
 订阅单条广播

 @param topic 广播URL
 @param qosLevel 接受消息级别 
 */
- (void)subscaribeTopic:(NSString*)topic atLevel:(MQTTQosLevel)qosLevel;


@end
