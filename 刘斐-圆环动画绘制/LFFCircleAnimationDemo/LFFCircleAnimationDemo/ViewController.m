//
//  ViewController.m
//  LFFCircleAnimationDemo
//
//  Created by tianNanYiHao on 2017/7/12.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"
#import "LFFCircleAnimationView.h"
#import "LFFRotateView.h"

@interface ViewController ()
{
    LFFCircleAnimationView *fullCircleView;
    LFFCircleAnimationView *showCircleView;
    LFFRotateView *rotateView;
}

@property (nonatomic, assign)CGFloat  present; //前景圆所占比例
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    CGRect circleRect = CGRectMake(0, 0, 100, 100);
    self.present = 0.43;
    
    
    
    //背景圆环(整圆)
    fullCircleView = [LFFCircleAnimationView creatCircleViewWithFrame:circleRect];
    fullCircleView.strokeColor = [UIColor grayColor];
    [fullCircleView buildCircleView];
    
    //前景圆环
    showCircleView = [LFFCircleAnimationView creatCircleViewWithFrame:circleRect];
    [showCircleView buildCircleView];
    
    //旋转的容器View
    rotateView = [[LFFRotateView alloc] initWithFrame:circleRect];
    rotateView.center = CGPointMake(100, 100);
    [self.view addSubview:rotateView];
    
    //容器view添加两个圆环
    [rotateView addSubview:fullCircleView];
    [rotateView addSubview:showCircleView];
    
    
    
    
}

- (IBAction)show:(id)sender {
    
    //动画复位
    [fullCircleView strokeEnd:0 animation:NO duration:0];
    [showCircleView strokeEnd:0 animation:NO duration:0];
    [fullCircleView strokeStart:0 animation:NO duration:0];
    [showCircleView strokeStart:0 animation:NO duration:0];
    [rotateView rotateAngle:0];
    
    
    
    
    [fullCircleView strokeEnd:0.75 animation:YES duration:1.5];
    [showCircleView strokeEnd:0.75*self.present animation:YES duration:1.5];
    [rotateView rotateAngle:45.f duration:1.5];
    
}


- (IBAction)hide:(id)sender {
    
    [fullCircleView strokeStart:0.75 animation:YES duration:0.8];
    [showCircleView strokeStart:0.75*self.present animation:YES duration:0.8];
    [rotateView rotateAngle:90.f duration:0.8f];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
