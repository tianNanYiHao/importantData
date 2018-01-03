//
//  ViewController.m
//  MQTTClientDEMO
//
//  Created by tianNanYiHao on 2017/4/27.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"
#import "SunViewController.h"
#import "SandMQTTClientHelper.h"



#import "MQTTClient.h"

#define kMQTTServerHost @"172.28.247.111"
#define kMQTTServerPort 61613
#define kMQTTServerName @"testuser"
#define kMQTTServerPasswd @"0d6be69b264717f2dd33652e212b173104b4a647b7c11ae72e9885f11cd312fb"


#define kMQTTServerTopic1 @"SANDBAO/0003/USER/4000001077" //4000001077 userID
#define kMQTTServerTopic2 @"SANDBAO/0003/#"


@interface ViewController ()<MQTTSessionDelegate,MQTTTransportDelegate>
{
    MQTTSession *sessioN;
    SunViewController *sunvc;
}
@property (weak, nonatomic) IBOutlet UITextField *topicTextfiled;
@end

@implementation ViewController

//MQTT断开连接
- (IBAction)MQTTDisconnect:(id)sender {
    [[SandMQTTClientHelper shareSandMQTTClientInstance] sandMqttDisConnect];
    
}
//MQTT重新连接
- (IBAction)MQTTConnect:(id)sender {
    [[SandMQTTClientHelper shareSandMQTTClientInstance] sandMqttConnect];
}
//MQTT关闭
- (IBAction)MQTTClose:(id)sender {
    [[SandMQTTClientHelper shareSandMQTTClientInstance] sandMqttClosed];
}

//MQTT取消定于某个主题
- (IBAction)unsubscritionTopic:(id)sender {
    _topicTextfiled.text = kMQTTServerTopic2;
    [sessioN unsubscribeTopic:kMQTTServerTopic2];
}

//跳转
- (IBAction)pushVC:(id)sender {
    sunvc = [[SunViewController alloc] init];
    [self.navigationController pushViewController:sunvc animated:YES];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"爸爸";
    self.view.backgroundColor = [UIColor whiteColor];

    
    
    


    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
