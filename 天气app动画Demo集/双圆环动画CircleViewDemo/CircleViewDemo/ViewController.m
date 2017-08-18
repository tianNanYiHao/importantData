//
//  ViewController.m
//  CircleViewDemo
//
//  Created by tianNanYiHao on 2017/7/12.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"
#import "CircleView.h"
#import "RotatedAngleView.h"



#import "AppColor.h"
#import "UIView+SetRect.h"



@interface ViewController ()

{
    
}
@property (nonatomic, strong) CircleView         *fullCircle;
@property (nonatomic, strong) CircleView         *showCircle;
@property (nonatomic, strong) RotatedAngleView   *rotateView;

@property (nonatomic, assign) CGFloat percent;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    CGRect circleRect = CGRectZero;
    CGRect rotateRect = CGRectZero;
    
    if (iPhone5_5s || iPhone4_4s) {
        
        circleRect = CGRectMake(0, 0, 100, 100);
        rotateRect = CGRectMake(37, 40, circleRect.size.width, circleRect.size.height);
        
    } else if (iPhone6_6s) {
        
        circleRect = CGRectMake(0, 0, 110, 110);
        rotateRect = CGRectMake(40, 50, circleRect.size.width, circleRect.size.height);
        
    } else if (iPhone6_6sPlus) {
        
        circleRect = CGRectMake(0, 0, 115, 115);
        rotateRect = CGRectMake(45, 55, circleRect.size.width, circleRect.size.height);
        
    } else {
        
        circleRect = CGRectMake(0, 0, 90, 90);
        rotateRect = CGRectMake(25, 15, circleRect.size.width, circleRect.size.height);
    }
    
    
    //前景圆占比背景圆的百分比
    self.percent = 0.43;
    
    
    // 完整的圆-背景圆
    self.fullCircle           = [CircleView createDefaultViewWithFrame:circleRect];
    self.fullCircle.lineColor = COLOR_CIRCLE_;
    [self.fullCircle buildView];
    
    //前景圆
    self.showCircle = [CircleView createDefaultViewWithFrame:circleRect];
    [self.showCircle buildView];


    //可旋转容器View
    self.rotateView = [[RotatedAngleView alloc] initWithFrame:circleRect];
    self.rotateView.center = CGPointMake(100, 100);
    [self.view addSubview:self.rotateView];
    
    //添加子View
    [self.rotateView addSubview:self.fullCircle];
    [self.rotateView addSubview:self.showCircle];
    
    
}
- (IBAction)show:(id)sender {
    
    // 进行参数复位
    [self.fullCircle strokeEnd:0 animated:NO duration:0];
    [self.showCircle strokeEnd:0 animated:NO duration:0];
    [self.fullCircle strokeStart:0 animated:NO duration:0];
    [self.showCircle strokeStart:0 animated:NO duration:0];
    [self.rotateView roateAngle:0];
    
    
    
    CGFloat circleFullPercent = 0.75;
    CGFloat duration          = 1.5;
    // 设置动画
    [self.fullCircle strokeEnd:circleFullPercent animated:YES duration:duration];
    [self.showCircle strokeEnd:circleFullPercent * self.percent animated:YES duration:duration];
    [self.rotateView roateAngle:45.f duration:duration];
    
    
    
}
- (IBAction)hide:(id)sender {
    CGFloat duration          = 0.75;
    CGFloat circleFullPercent = 0.75;
    
    
    [self.fullCircle strokeStart:circleFullPercent animated:YES duration:duration];
    [self.showCircle strokeStart:self.percent * circleFullPercent animated:YES duration:duration];
    [self.rotateView roateAngle:90.f duration:duration];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
