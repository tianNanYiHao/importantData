//
//  ViewController.m
//  iOSWaveAnimationDemo
//
//  Created by tianNanYiHao on 2017/8/24.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"
#import "WaveAnimationView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    WaveAnimationView *wav = [[WaveAnimationView alloc] initWithFrame:CGRectMake(40, self.view.bounds.size.height*1/3, self.view.bounds.size.width-80, self.view.bounds.size.height*0.5f)];
    
    wav.backgroundColor = [UIColor colorWithRed:43/255.f green:232/255.f blue:123/255.f alpha:1];
    
    [self.view addSubview:wav];
    
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
