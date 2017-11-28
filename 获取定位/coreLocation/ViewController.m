//
//  ViewController.m
//  coreLocation
//
//  Created by tianNanYiHao on 2017/11/28.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"
#import "SDLocationManager.h"

@interface ViewController ()

@property (nonatomic, strong) SDLocationManager *locationManager;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.locationManager = [[SDLocationManager alloc] init];
    
    [self.locationManager startLocaton];
    
    
    
}



- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
