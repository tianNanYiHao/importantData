//
//  ViewController.m
//  MQTTKitComeOn
//
//  Created by scinan on 15/10/16.
//  Copyright © 2015年 scinan. All rights reserved.
//


/**
 *  MQTT客户端
 */

#import "ViewController.h"

//#define kMQTTServerHost @"iot.eclipse.org"
//#define kTopic @"MQTTExample/Message"

//服务器地址
#define kMQTTServerHost @"172.28.250.63"
#define name @"testuser"
#define passwd @"0d6be69b264717f2dd33652e212b173104b4a647b7c11ae72e9885f11cd312fb"


//String[]{"SANDBAO/0003/USER/" + userId, "SANDBAO/0003/BROADCAST"}

//主题：需要从后台拿到
#define kTopic @"SANDBAO/0003/USER/"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *showMessage;
@property (nonatomic, strong) MQTTClient *client;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //1.在app登录后，后台返回 name＋password＋topic
    
    //2.name＋password用于连接主机
    
    //3.topic 用于订阅主题
    
    

    UILabel *tempShowMessage = self.showMessage;
    
    NSString *clientID = [UIDevice currentDevice].identifierForVendor.UUIDString;
    
    self.client = [[MQTTClient alloc] initWithClientId:clientID];
    self.client.port = 31883;
    //连接服务器  连接后，会通过block将连接结果code返回，然后执行此段代码块
    
    //这个接口是修改过后的接口，修改后抛出了name＋password
    [self.client connectToHost:kMQTTServerHost andName:name andPassword:passwd completionHandler:^(MQTTConnectionReturnCode code) {
        if (code == ConnectionAccepted)//连接成功
        {
            // 订阅
            [self.client subscribe:kTopic withCompletionHandler:^(NSArray *grantedQos) {
                // The client is effectively subscribed to the topic when this completion handler is called
                NSLog(@"subscribed to topic %@", kTopic);
                NSLog(@"return:%@",grantedQos);
            }];
            [self.client subscribe:@"SANDBAO/0003/BROADCAST" withCompletionHandler:^(NSArray *grantedQos) {
                // The client is effectively subscribed to the topic when this completion handler is called
                NSLog(@"subscribed to topic %@", @"SANDBAO/0003/BROADCAST");
                NSLog(@"return:%@",grantedQos);
            }];
        }
    }];
    
    
    //MQTTMessage  里面的数据接收到的是二进制，这里框架将其封装成了字符串
    [self.client setMessageHandler:^(MQTTMessage* message)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            //接收到消息，更新界面时需要切换回主线程
            tempShowMessage.text= message.payloadString;
            NSLog(@"%@",message.payloadString);
        });
    }];  
    
}


- (void)dealloc
{
    // disconnect the MQTT client
    [self.client disconnectWithCompletionHandler:^(NSUInteger code)
    {
        // The client is disconnected when this completion handler is called
        NSLog(@"MQTT is disconnected");
    }];
}
@end
