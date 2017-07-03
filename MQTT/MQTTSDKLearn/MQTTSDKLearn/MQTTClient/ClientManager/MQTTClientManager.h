//
//  MQTTClientManager.h
//  MQTTSDKLearn
//
//  Created by Vie on 2017/3/3.
//  Copyright © 2017年 Vie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MQTTClientManager : NSObject

/**
 单例

 @return self
 */
+(MQTTClientManager *)shareInstance;




/**
 将推送Token提交给消息服务后台保存，目前没有确定接口以及关联token标识（建议第一次提交失败还要继续提交大概3次，3次都失败返回）

 官方文档上建议开发者在每次启动应用时应该都向APNS获取device token并上传给服务器。
 
 @param token 向苹果申请的推送token
 @param flag 提交结果
 */
-(void)pushDeviceToken:(NSString *)token block:(void(^)(BOOL flag))flag;



/**
 MQTT登陆，订阅单个主题

 @param ip 服务器ip
 @param port 服务器端口
 @param userName 用户名
 @param password 密码
 @param topic 订阅的主题，可以订阅的主题与账户是相关联的，例：@"mqtt/test"
 @param isAutoConnect 是否自动重连标识，默认不自动重连
 @param connectCount 自动重连次数
 */
-(void)loginWithIp:(NSString *)ip port:(UInt16)port userName:(NSString *)userName password:(NSString *)password topic:(NSString *)topic isAutoConnect:(BOOL)isAutoConnect isAutoConnectCount:(NSUInteger)connectCount;

/**
 MQTT登陆，订阅多个主题
 
 @param ip 服务器ip
 @param port 服务器端口
 @param userName 用户名
 @param password 密码
 @param topics 订阅的主题，可以订阅的主题与账户是相关联的，例：@{@"mqtt/test":@"mqtt/test",@"mqtt/test1":@"mqtt/test1"}
 @param isAutoConnect 是否自动重连标识，默认不自动重连
 @param connectCount 自动重连次数
 */
-(void)loginWithIp:(NSString *)ip port:(UInt16)port userName:(NSString *)userName password:(NSString *)password topics:(NSDictionary *)topics isAutoConnect:(BOOL)isAutoConnect isAutoConnectCount:(NSUInteger)connectCount;



/**
 断开连接，清空数据
 */
-(void)close;

/**
 注册代理

 @param obj 需要实现代理的对象
 */
-(void)registerDelegate:(id)obj;


/**
  解除代理

 @param obj 需要接触代理的对象
 */
-(void)unRegisterDelegate:(id)obj;
@end
