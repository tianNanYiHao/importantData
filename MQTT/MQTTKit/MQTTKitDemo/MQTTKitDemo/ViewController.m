//
//  ViewController.m
//  MQTTKitDemo
//
//  Created by tianNanYiHao on 2017/4/28.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"
#import "MQTTKit.h"
//服务器地址
#define kMQTTServerHost @"172.28.250.63"
#define kMQTTServerPort 31883
#define kMQTTServerName @"testuser"
#define kMQTTServerPasswd @"0d6be69b264717f2dd33652e212b173104b4a647b7c11ae72e9885f11cd312fb"


#define kMQTTServerTopic1 @"SANDBAO/0003/USER/4000001077" //4000001077 userID
#define kMQTTServerTopic2 @"SANDBAO/0003/BROADCAST"

@interface ViewController ()
{
    MQTTClient *client;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    client = [[MQTTClient alloc] initWithClientId:[NSString stringWithFormat:@"%ld",random()%100]];
    [client connectToHost:kMQTTServerHost completionHandler:^(MQTTConnectionReturnCode code) {
        
    }];
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
