//
//  ViewController.m
//  MQTTClientDEMO
//
//  Created by tianNanYiHao on 2017/4/27.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"
#import "MQTTClient.h"

#define kMQTTServerHost @"172.28.250.63"
#define kMQTTServerPort 31883
#define kMQTTServerName @"testuser"
#define kMQTTServerPasswd @"0d6be69b264717f2dd33652e212b173104b4a647b7c11ae72e9885f11cd312fb"


#define kMQTTServerTopic1 @"SANDBAO/0003/USER/4000001077" //4000001077 userID
#define kMQTTServerTopic2 @"SANDBAO/0003/BROADCAST"


@interface ViewController ()<MQTTSessionDelegate,MQTTTransportDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //1.设置传输类型
    MQTTCFSocketTransport *transport = [[MQTTCFSocketTransport alloc] init];
    transport.host = kMQTTServerHost;
    transport.port = kMQTTServerPort;
    
    //2.创建一个任务
    MQTTSession *session = [[MQTTSession alloc] init];
    //设置当前任务的传输类型
    session.transport = transport;
    //设置当前任务的代理
    session.delegate = self;
    //设置当前任务的账户/密码
    session.userName = kMQTTServerName;
    session.password = kMQTTServerPasswd;
    //设置当前任务的clienID
    session.clientId = @"";
    //设置当前任务的超时时间
    BOOL success = [session connectAndWaitTimeout:10];
    
    
    
    
    //订阅一个主题Topic
    if (success) {
        [session subscribeTopic:kMQTTServerTopic2];
    }
    
    
    
    
}

#pragma mark - MQTTSessionDelegate代理
//接受消息
-(void)newMessage:(MQTTSession *)session data:(NSData *)data onTopic:(NSString *)topic qos:(MQTTQosLevel)qos retained:(BOOL)retained mid:(unsigned int)mid{
    
    NSLog(@" === session = %@",session);
    NSLog(@" === data = %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    NSLog(@" === topic = %@",topic);
    NSLog(@" === qos = %d",qos);
    NSLog(@" === retained = %d",retained);
    NSLog(@" === mid = %u",mid);
    
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
