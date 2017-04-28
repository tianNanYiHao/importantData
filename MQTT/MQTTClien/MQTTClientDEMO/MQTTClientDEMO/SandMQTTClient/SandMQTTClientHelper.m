//
//  SandMQTTClientHelper.m
//  MQTTClientDEMO
//
//  Created by tianNanYiHao on 2017/4/28.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "SandMQTTClientHelper.h"
#import "MQTTClient.h"


#define kMQTTServerHost @"172.28.250.63"
#define kMQTTServerPort 31883
#define kMQTTServerName @"testuser"
#define kMQTTServerPasswd @"0d6be69b264717f2dd33652e212b173104b4a647b7c11ae72e9885f11cd312fb"


#define kMQTTServerTopicUser @"SANDBAO/0003/USER/" // + userID
#define kMQTTServerTopic @"SANDBAO/0003/BROADCAST"


@interface SandMQTTClientHelper ()<MQTTSessionDelegate,MQTTTransportDelegate>
{
    MQTTCFSocketTransport *transport;
    MQTTSession *sessioN;
    
    
    
}
@property (nonatomic ,strong) NSString *clientID;
@end

@implementation SandMQTTClientHelper

//1.静态实例,初始化nil
static SandMQTTClientHelper *sandMqttClientObject = nil;

+ (SandMQTTClientHelper*)shareSandMQTTClientInstance{
    
    static dispatch_once_t onceTokec;
    dispatch_once(&onceTokec, ^{
        sandMqttClientObject = [[SandMQTTClientHelper alloc] init];
        [sandMqttClientObject initMQTTTransPort];
    });
    return sandMqttClientObject;
}

-(void)initMQTTTransPort{
    //1.设置传输类型
    transport = [[MQTTCFSocketTransport alloc] init];
    transport.host = kMQTTServerHost;
    transport.port = kMQTTServerPort;
    
    //2.创建一个任务
    sessioN = [[MQTTSession alloc] init];
    //设置当前任务的传输类型
    sessioN.transport = transport;
    //设置当前任务的代理
    sessioN.delegate = self;
    //设置当前任务的账户/密码
    sessioN.userName = kMQTTServerName;
    sessioN.password = kMQTTServerPasswd;
    //设置当前任务的clienID
//    sessioN.clientId = clientID; //MQTTClient 自动设置不同id
    //设置当前任务的超时时间
    [sessioN connectAndWaitTimeout:1];
    
}


/**
 用户主题模式
 
 @param userID 用户ID
 @param block 消息回调
 */
- (void)subscribeToTopicUserID:(NSString*)userID sandMqttNewsBlock:(SandMQTTClientNewsBlock)block{
    [sessioN subscribeToTopic:[NSString stringWithFormat:@"%@%@",kMQTTServerTopicUser,userID] atLevel:MQTTQosLevelExactlyOnce subscribeHandler:^(NSError *error, NSArray<NSNumber *> *gQoss) {
        if (error) {
            NSLog(@"subscription filed 连接失败:%@",error.description);
        }else{
            NSLog(@"subscription successfull! 连接成功! gQoss : %@",gQoss);  //表示消息送达的服务等级
        }
    }];
}



/**
 广播主题模式
 
 @param block 消息回调
 */
- (void)subscribeToTopicBoardSandMqttNewsBlock:(SandMQTTClientNewsBlock)block{
    _sandmqttClientNewsBlock = block;
    [sessioN subscribeToTopic:kMQTTServerTopic atLevel:MQTTQosLevelExactlyOnce subscribeHandler:^(NSError *error, NSArray<NSNumber *> *gQoss) {
        if (error) {
            NSLog(@"subscription filed 连接失败:%@",error.description);
        }else{
            NSLog(@"subscription successfull! 连接成功! gQoss : %@",gQoss);  //表示消息送达的服务等级
        }
    }];
}


/**
 mqtt断开连接
 */
- (void)sandMqttDisConnect{
    [sessioN disconnect];
}

/**
 mqtt重连
 */
- (void)sandMqttConnect{
    [sessioN connect];
}

/**
 mqtt关闭
 */
- (void)sandMqttClosed{
    [sessioN close];
}





#pragma mark - MQTTSessionDelegate代理
//接受消息
-(void)newMessage:(MQTTSession *)session data:(NSData *)data onTopic:(NSString *)topic qos:(MQTTQosLevel)qos retained:(BOOL)retained mid:(unsigned int)mid{
    
    //用户主题模式
    if ([topic rangeOfString:[NSString stringWithFormat:@"USER/%@",_clientID]].location != NSNotFound) {
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"===> %@",str);
        _sandmqttClientNewsBlock(str);
    }
    //广播主题模式
    if ([topic rangeOfString:@"BROADCAST"].location != NSNotFound) {
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"===> %@",str);
        _sandmqttClientNewsBlock(session.clientId);
        
    }
    
}


@end
