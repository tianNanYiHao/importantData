//
//  ViewController.m
//  CAEmitterLayerDemo
//
//  Created by tianNanYiHao on 2017/8/9.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"
#import "EmitterView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
    EmitterView *emitterV = [[EmitterView alloc] initWithFrame:CGRectMake(50, 50, 200, 200)];
    [self.view addSubview:emitterV];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
