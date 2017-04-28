//
//  SunViewController.m
//  MQTTClientDEMO
//
//  Created by tianNanYiHao on 2017/4/28.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "SunViewController.h"
#import "SandMQTTClientHelper.h"
@interface SunViewController ()

@end

@implementation SunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"儿子";
    self.view.backgroundColor = [UIColor lightGrayColor];
    [[SandMQTTClientHelper shareSandMQTTClientInstance] subscribeToTopicWithClientID:@"4000001077" sandMqttNewsBlock:^(NSString *dataStr) {
        
        NSLog(@"==== -- ==== %@",dataStr);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:dataStr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        
        [alert show];
    }];
    
    
    
    [[SandMQTTClientHelper shareSandMQTTClientInstance] subscribeToTopicUserID:@"4000001077" clientID:@"4000001077" sandMqttNewsBlock:^(NSString *dataStr) {
        NSLog(@"==== -- ==== %@",dataStr);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:dataStr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        
        [alert show];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
