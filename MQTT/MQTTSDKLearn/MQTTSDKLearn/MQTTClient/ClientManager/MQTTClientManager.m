//
//  MQTTClientManager.m
//  MQTTSDKLearn
//
//  Created by Vie on 2017/3/3.
//  Copyright © 2017年 Vie. All rights reserved.
//

#import "MQTTClientManager.h"
#import "MQTTClientManagerDelegate.h"
#import "MQTTClient.h"
#import <UIKit/UIDevice.h>
#import "MQTTStatus.h"

@interface MQTTClientManager ()<MQTTSessionDelegate>

typedef void(^flagBlock)(BOOL flag) ;//定义block

@property(nonatomic, weak)      id<MQTTClientManagerDelegate> delegate;//代理
@property(nonatomic, strong)    MQTTSession *mqttSession;
@property(nonatomic, strong)    MQTTCFSocketTransport *transport;//连接服务器属性
@property(nonatomic, strong)    NSString *ip;//服务器ip地址
@property(nonatomic)            UInt16 port;//服务器ip地址
@property(nonatomic, strong)    NSString *userName;//用户名
@property(nonatomic, strong)    NSString *password;//密码
@property(nonatomic, strong)    NSString *topic;//单个主题订阅
@property(nonatomic, strong)    NSDictionary *topics;//多个主题订阅
@property(nonatomic, strong)    MQTTStatus *mqttStatus;//连接服务器状态
@property(nonatomic, copy)      flagBlock flag;//目前只用于返回token上传结果
@property(nonatomic, assign)    BOOL   isAutoConnect;//是否自动重连标识
@property(nonatomic, assign)    NSUInteger connectCount;//自动重连次数
@property(nonatomic, assign)    NSUInteger nowCount;//当前已经重连的次数
@end

@implementation MQTTClientManager

#pragma mark 懒加载
-(MQTTSession *)mqttSession{
    if (!_mqttSession) {
        /*app包名+|iOS|+设备信息作为连接id确保唯一性(也可换其他方式)*/
        NSString *clientID=[NSString stringWithFormat:@"%@|iOS|%@",[[NSBundle mainBundle] bundleIdentifier],[UIDevice currentDevice].identifierForVendor.UUIDString];
        NSLog(@"-----------------MQTT连接的ClientID-----------------%@",@"111");
        _mqttSession=[[MQTTSession alloc] initWithClientId:clientID];
    }
    return _mqttSession;
}

-(MQTTCFSocketTransport *)transport{
    if (!_transport) {
        _transport=[[MQTTCFSocketTransport alloc] init];
    }
    return _transport;
}
-(MQTTStatus *)mqttStatus{
    if (!_mqttStatus) {
        _mqttStatus=[[MQTTStatus alloc] init];
    }
    return _mqttStatus;
}
#pragma mark 对外方法
/**
 单例
 
 @return self
 */
+(MQTTClientManager *)shareInstance{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance=[[self alloc] init];
    });
    return instance;
}

/**
 将推送Token提交给消息服务后台保存，目前没有确定接口以及关联token标识（建议第一次提交失败还要继续提交大概3次，3次都失败返回）
 
 官方文档上建议开发者在每次启动应用时应该都向APNS获取device token并上传给服务器。
 
 @param token 向苹果申请的推送token
 @param flag 提交结果
 */
-(void)pushDeviceToken:(NSString *)token block:(void(^)(BOOL flag))flag{
    self.flag=flag;
    NSLog(@"假装token传输到服务器成功:%@",token);
    self.flag(true);
}

/**
 MQTT登陆，订阅单个主题
 
 @param ip 服务器ip
 @param port 服务器端口
 @param userName 用户名
 @param password 密码
 @param topic 订阅的主题，可以订阅的主题与账户是相关联的，例：@"mqtt/test"
 @param isAutoConnect 是否自动重连标识，默认不自动重连
 @param coonectCount 自动重连次数
 */
-(void)loginWithIp:(NSString *)ip port:(UInt16)port userName:(NSString *)userName password:(NSString *)password topic:(NSString *)topic isAutoConnect:(BOOL)isAutoConnect isAutoConnectCount:(NSUInteger)coonectCount{
    self.topic=topic;
    self.isAutoConnect=isAutoConnect;
    self.connectCount=coonectCount;
    self.nowCount=0;
    [self loginWithIp:ip port:port userName:userName password:password];
}

/**
 MQTT登陆，订阅多个主题
 
 @param ip 服务器ip
 @param port 服务器端口
 @param userName 用户名
 @param password 密码
 @param topics 订阅的主题，可以订阅的主题与账户是相关联的，例：@{@"mqtt/test":@"mqtt/test",@"mqtt/test1":@"mqtt/test1"}
 @param isAutoConnect 是否自动重连标识，默认不自动重连
 @param coonectCount 自动重连次数
 */
-(void)loginWithIp:(NSString *)ip port:(UInt16)port userName:(NSString *)userName password:(NSString *)password topics:(NSDictionary *)topics isAutoConnect:(BOOL)isAutoConnect isAutoConnectCount:(NSUInteger)coonectCount{
    self.topics=topics;
    self.isAutoConnect=isAutoConnect;
    self.connectCount=coonectCount;
    self.nowCount=0;
    [self loginWithIp:ip port:port userName:userName password:password];
}
-(void)loginWithIp:(NSString *)ip port:(UInt16)port userName:(NSString *)userName password:(NSString *)password {
    self.ip=ip;
    self.port=port;
    self.userName=userName;
    self.password=password;
    
    [self loginMQTT];

}
/*实际登陆处理*/
-(void)loginMQTT{
    //当前登录次数增加
    self.nowCount++;
    NSLog(@"-----------------登陆MQTT第%lu次-----------------",(unsigned long)self.nowCount);
    
    /*设置ip和端口号*/
    self.transport.host=_ip;
    self.transport.port=_port;
    
    /*设置MQTT账号和密码*/
    self.mqttSession.transport=self.transport;//给MQTTSession对象设置基本信息
    self.mqttSession.delegate=self;//设置代理
    [self.mqttSession setUserName:_userName];
    [self.mqttSession setPassword:_password];
    
    //会话链接并设置超时时间
    [self.mqttSession connectAndWaitTimeout:20];
}
/**
 断开连接，清空数据
 */
-(void)close{
    NSLog(@"-----------------MQTT主动断开连接-----------------");
    [_mqttSession close];
    _delegate=nil;//代理
    _mqttSession=nil;
    _transport=nil;//连接服务器属性
    _ip=nil;//服务器ip地址
    _port=0;//服务器ip地址
    _userName=nil;//用户名
    _password=nil;//密码
    _topic=nil;//单个主题订阅
    _topics=nil;//多个主题订阅
    _mqttStatus=nil;//连接服务器状态
    _flag=nil;//目前只用于返回token上传结果
    _isAutoConnect=nil;//是否自动重连标识
    _connectCount=0;//自动重连次数
    _nowCount=0;//当前已经重连的次数
}

/**
 注册代理
 
 @param obj 需要实现代理的对象
 */
-(void)registerDelegate:(id)obj{
    NSLog(@"-----------------MQTT委托代理对象：%@-----------------",NSStringFromClass([obj class]));
    self.delegate=obj;
}


/**
 解除代理
 
 @param obj 需要接触代理的对象
 */
-(void)unRegisterDelegate:(id)obj{
    NSLog(@"-----------------MQTT取消代理对象-----------------");
    self.delegate=nil;
}

#pragma mark MQTTClientManagerDelegate
/*连接成功回调*/
-(void)connected:(MQTTSession *)session{
    NSLog(@"-----------------MQTT成功建立连接-----------------");
    if (_topic) {
        NSLog(@"-----------------MQTT订阅单个主题-----------------");
        [self.mqttSession subscribeTopic:_topic];
    }else if(_topics){
        NSLog(@"-----------------MQTT订阅多个个主题-----------------");
        [self.mqttSession subscribeToTopics:_topics];
    }
}
/*连接状态回调*/
-(void)handleEvent:(MQTTSession *)session event:(MQTTSessionEvent)eventCode error:(NSError *)error{
    NSDictionary *events = @{
                             @(MQTTSessionEventConnected): @"connected",
                             @(MQTTSessionEventConnectionRefused): @"账号或密码错误，服务器拒绝连接",
                             @(MQTTSessionEventConnectionClosed): @"connection closed",
                             @(MQTTSessionEventConnectionError): @"connection error",
                             @(MQTTSessionEventProtocolError): @"protocoll error",
                             @(MQTTSessionEventConnectionClosedByBroker): @"connection closed by broker"
                             };
     NSLog(@"-----------------MQTT连接状态%@-----------------",[events objectForKey:@(eventCode)]);
    
    switch (eventCode) {
        case MQTTSessionEventConnected:
        {
            [self handleMQTTResults:events event:eventCode];
        }
            break;
        case MQTTSessionEventConnectionClosed:
        {
            //Closed目前情况看不管什么错误都会通知，再和实际的错误通知一起就等于通知了2次
        }
            break;
        case MQTTSessionEventConnectionRefused:{
            //服务器拒绝的账号密码错误直接提示
            [self handleMQTTResults:events event:eventCode];
        }
        default:
        {
            //是否自动重连
            if (self.isAutoConnect) {
                //当前重连次数是否超过最大限制
                if (self.nowCount<self.connectCount) {
                    //延迟重登，避免mqtt缓冲区处理不及时崩溃
                    [self performSelector:@selector(loginMQTT) withObject:nil afterDelay:0.3];
                }else{
                    [self handleMQTTResults:events event:eventCode];
                }
            }else{
                [self handleMQTTResults:events event:eventCode];
            }
        }
            break;
    }
}

/*处理服务器结果*/
-(void)handleMQTTResults:(NSDictionary *)events event:(MQTTSessionEvent)eventCode{
    self.nowCount=0;
    [self.mqttStatus setStatusCode:eventCode];
    [self.mqttStatus setStatusInfo:[events objectForKey:@(eventCode)]];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(didMQTTReceiveServerStatus:)]) {
        [self.delegate didMQTTReceiveServerStatus:self.mqttStatus];
    }
}
/*收到消息，消息的回执MQTTClient里面自己处理了(acknowledged)*/
-(void)newMessage:(MQTTSession *)session data:(NSData *)data onTopic:(NSString *)topic qos:(MQTTQosLevel)qos retained:(BOOL)retained mid:(unsigned int)mid{
    NSString *jsonStr=[NSString stringWithUTF8String:data.bytes];
     NSLog(@"-----------------MQTT收到消息主题：%@内容：%@",topic,jsonStr);
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(messageTopic:data:)]) {
        [self.delegate messageTopic:topic data:dic];
    }
    if (self.delegate&&[self.delegate respondsToSelector:@selector(messageTopic:jsonStr:)]) {
        [self.delegate messageTopic:topic jsonStr:jsonStr];
    }
}


@end
