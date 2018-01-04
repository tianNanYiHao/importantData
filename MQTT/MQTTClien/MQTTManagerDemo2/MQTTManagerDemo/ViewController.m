//
//  ViewController.m
//  MQTTManagerDemo
//
//  Created by tianNanYiHao on 2018/1/3.
//  Copyright © 2018年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"
#import "SDMQTTManager.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [SDMQTTManager shareMQttManager].clientID = @"213456";
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
