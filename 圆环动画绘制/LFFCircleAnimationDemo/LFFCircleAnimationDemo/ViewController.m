//
//  ViewController.m
//  LFFCircleAnimationDemo
//
//  Created by tianNanYiHao on 2017/7/12.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"
#import "LFFCircleAnimationView.h"

@interface ViewController ()
{
    LFFCircleAnimationView *circleAnimatioView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    circleAnimatioView = [LFFCircleAnimationView creatCircleViewWithFrame:CGRectMake(50, 100, 100, 100)];
    
    [circleAnimatioView buildCircleView];
    
    [self.view addSubview:circleAnimatioView];
    
    
    
    
    
}

- (IBAction)show:(id)sender {
    
    //动画复位
    [circleAnimatioView strokeEnd:0 animation:NO duration:0];
    
    
    
    
    
    [circleAnimatioView strokeEnd:0.75 animation:YES duration:1.5];
    
}


- (IBAction)hide:(id)sender {
    
    [circleAnimatioView strokeStart:0.75 animation:YES duration:0.8];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
