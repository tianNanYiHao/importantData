//
//  ViewController.m
//  UIBezierCAKeyFrameAnimationMemo
//
//  Created by tianNanYiHao on 2017/8/10.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //贝塞尔曲线
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(50, 100)];
    [path addCurveToPoint:CGPointMake(300, 100) controlPoint1:CGPointMake(150, 50) controlPoint2:CGPointMake(200, 150)];
    
    
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor greenColor].CGColor;
    shapeLayer.borderWidth = 3.f;
    shapeLayer.strokeEnd = 0;
    shapeLayer.lineCap = kCALineCapButt;
    [self.view.layer addSublayer:shapeLayer];
    
    
    CALayer *transLayer = [CALayer layer];
    transLayer.frame = CGRectMake(0, 0, 40, 40);
    transLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:transLayer];
    
    
    
    //曲线前进动画
    CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animation];
    moveAnimation.keyPath = @"transform.x";
    moveAnimation.path = path.CGPath;
    moveAnimation.duration = 4.0f;
    moveAnimation.removedOnCompletion = NO;
    moveAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [shapeLayer addAnimation:moveAnimation forKey:@"moveAnimation"];
    
    
    
    
    //方块沿曲线路径移动
    CAKeyframeAnimation *translateAnimation = [CAKeyframeAnimation animation];
    translateAnimation.keyPath = @"position";
    translateAnimation.repeatCount = 10;
    translateAnimation.path = path.CGPath;
    translateAnimation.fillMode = kCAFillModeForwards;
    translateAnimation.rotationMode = kCAAnimationRotateAuto; //设置自身贴合曲线rotateAuto
    translateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    translateAnimation.duration = 4.0f;
    [transLayer addAnimation:translateAnimation forKey:@"translateAnimation"];
    
    
    

    
    
    
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
