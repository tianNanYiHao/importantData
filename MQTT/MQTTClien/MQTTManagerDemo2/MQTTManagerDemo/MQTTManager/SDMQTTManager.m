//
//  SDMQTTManager.m
//  MQTTManagerDemo
//
//  Created by tianNanYiHao on 2018/1/3.
//  Copyright © 2018年 tianNanYiHao. All rights reserved.
//

#import "SDMQTTManager.h"




//mqtt端口/地址
//#define kIP @"172.28.250.63"   //开发
//#define kPort 61613
#define kIP @"172.28.247.111"
#define kPort 61613
//#define kIP @"????"  //生产
//#define kPort ????
#define kMqttuserNmae @"testuser"
#define kMqttpasswd   @"0d6be69b264717f2dd33652e212b173104b4a647b7c11ae72e9885f11cd312fb"
#define kMqttTopicUSERID(USERID) [NSString stringWithFormat:@"SANDBAO/0003/USER/%@",USERID]
#define kMqttTopicBROADCAST @"SANDBAO/0003/BROADCAST"

@interface SDMQTTManager()<MQTTSessionDelegate>{
    
}
@property (nonatomic, strong) MQTTCFSocketTransport *transport; //mqtt传输层
@property (nonatomic, strong) MQTTSession           *session;   //mqtt会话

@end



static SDMQTTManager *mqttManager = nil;

@implementation SDMQTTManager

//单例实例化
+ (instancetype)shareMQttManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mqttManager = [[SDMQTTManager alloc] init];
    });
    return mqttManager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mqttManager = [super allocWithZone:zone];
    });
    return mqttManager;
}

- (instancetype)init{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([super init]) {
            [self setInfo];
        }
    });
    return self;
}

- (void)setInfo{
#pragma mark MQTT对象初始化
    //初始化 - mqtt传输层对象
    self.transport = [[MQTTCFSocketTransport alloc] init];
    //初始化 -mqtt会话对象
    self.session = [[MQTTSession alloc] init];
    
#pragma mark 数据服务层设置
    //设置服务器地址 +端口号
    self.transport.host = kIP;
    self.transport.port = kPort;
    //是否使用tls协议，mosca是支持tls的，如果使用了要设置成true
    self.transport.tls = false;
    
#pragma mark 会话层设置
    //设置账户+登陆密码
    self.session.transport = self.transport;
    self.session.delegate = self;
    self.session.userName = kMqttuserNmae;
    self.session.password = kMqttpasswd;
    
    
    //设置心跳时间，单位秒，每隔固定时间发送心跳包
    self.session.keepAliveInterval = 30;
    
    //session是否清除(默认true)，这个需要注意，如果是false，代表保持登录，如果客户端离线了再次登录就可以接收到离线消息。注意：QoS为1和QoS为2，并需订阅和发送一致
    self.session.cleanSessionFlag = false;
}

//切换用户
- (void)setClientID:(NSString *)clientID{
    
    _clientID = clientID;
    
    //客户端id，需要特别指出的是这个id需要全局唯一，因为服务端是根据这个来区分不同的客户端的，默认情况下一个id登录后，假如有另外的连接以这个id登录，上一个连接会被踢下线,(杉德宝使用用户sToken作为当前用户的clientID)
    self.session.clientId = _clientID;
    
    //会话链接并设置超时时间(最后设置,否则代理不会执行),网络情况不好时,建议设置超时时间小一点
    [self.session connectAndWaitTimeout:1];
}

- (void)subscaribeTopic:(NSString *)topic atLevel:(MQTTQosLevel)qosLevel{
    
    if (self.session) {
        [self.session subscribeToTopic:topic atLevel:MQTTQosLevelExactlyOnce subscribeHandler:^(NSError *error, NSArray<NSNumber *> *gQoss) {
            if (error) {
                NSLog(@"连接失败");
            }else{
                NSLog(@"连接成功");
            }
        }];
    }
    
}

#pragma mark - MQTTSessionDelegate
- (void)handleEvent:(MQTTSession *)session event:(MQTTSessionEvent)eventCode error:(NSError *)error{
    
    NSDictionary *events = @{
                             @(MQTTSessionEventConnected): @"connected",
                             @(MQTTSessionEventConnectionRefused): @"connection refused",
                             @(MQTTSessionEventConnectionClosed): @"connection closed",
                             @(MQTTSessionEventConnectionError): @"connection error",
                             @(MQTTSessionEventProtocolError): @"protocoll error",
                             @(MQTTSessionEventConnectionClosedByBroker): @"connection closed by broker"
                             };
    NSLog(@"%@",[NSString stringWithFormat:@"\n-----------------MQTT连接状态-----------------%@",[events objectForKey:@(eventCode)]]);
    
}

- (void)newMessage:(MQTTSession *)session data:(NSData *)data onTopic:(NSString *)topic qos:(MQTTQosLevel)qos retained:(BOOL)retained mid:(unsigned int)mid{
    
    NSString *jsonStr=[NSString stringWithUTF8String:data.bytes];
    NSLog(@"%@",[NSString stringWithFormat:@"-----------------MQTT收到消息主题：%@内容：%@",topic,jsonStr]);
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    if ([SDMQTTManager shareMQttManager].delegate && [[SDMQTTManager shareMQttManager].delegate respondsToSelector:@selector(messageTopic:dataDic:)]) {
        [[SDMQTTManager shareMQttManager].delegate messageTopic:topic dataDic:dic];
    }
    
}

























@end

