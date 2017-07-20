//
//  LFFCircleAnimationView.m
//  LFFCircleAnimationDemo
//
//  Created by tianNanYiHao on 2017/7/12.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "LFFCircleAnimationView.h"

#import "UIView+SetRect.h"
#import "YXEasing.h"


#define radian(degress) ((M_PI * (degress))/180.0f)

@interface LFFCircleAnimationView(){
    CAShapeLayer *circleLayer;
}
@end


@implementation LFFCircleAnimationView


+(instancetype)creatCircleViewWithFrame:(CGRect)frame{
    
    LFFCircleAnimationView *circleView = [[LFFCircleAnimationView alloc] initWithFrame:frame];
    circleView.clockWise = YES;
    circleView.strokeColor = [UIColor blueColor];
    
    return circleView;

}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        
        circleLayer = [CAShapeLayer layer];
        [self.layer addSublayer:circleLayer];
    }
    return self;
}


- (void)buildCircleView{
    
    CGFloat radius = self.bounds.size.width/2;
    CGPoint centPoint = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    
    //顺时针(画整圆)
    if (self.clockWise) {
        self.startAngle = M_PI *(0)/180;
        self.endAngle = M_PI*(360)/180;
    }
    //逆时针
    else
    {
        self.startAngle = M_PI*(360)/180;
        self.endAngle = M_PI*(0)/180;
        
    }
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:centPoint radius:radius startAngle:self.startAngle endAngle:self.endAngle clockwise:self.clockWise];
    
    circleLayer.path = path.CGPath;
    circleLayer.strokeColor = self.strokeColor.CGColor;
    circleLayer.fillColor = [UIColor clearColor].CGColor;
    circleLayer.lineWidth = 3.f;
    
    //圆画好暂时不显示
    circleLayer.strokeEnd = 0.f;
    
}


- (void)strokeEnd:(CGFloat)value animation:(BOOL)animation duration:(CGFloat)Duration{
    
    if (animation) {
        
        CAKeyframeAnimation *keyanimation = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
        keyanimation.duration = Duration;
        
        //30为人眼看得到的帧数
        keyanimation.values = [YXEasing calculateFrameFromValue:circleLayer.strokeEnd toValue:value func:CubicEaseInOut frameCount:Duration*30];
        circleLayer.strokeEnd = value;
        [circleLayer addAnimation:keyanimation forKey:nil];
        
    }else{
        // 关闭动画
        //设置变化动画过程是否显示，默认为YES不显示
        [CATransaction setDisableActions:YES];
        
        circleLayer.strokeEnd = value;
        
        [CATransaction setDisableActions:NO];
    }
    
    
}

- (void)strokeStart:(CGFloat)value animation:(BOOL)animation duration:(CGFloat)duration{
    
    if (animation) {
        CAKeyframeAnimation *keyanimation = [CAKeyframeAnimation animationWithKeyPath:@"strokeStart"];
        keyanimation.duration = duration;
        
        keyanimation.values = [YXEasing calculateFrameFromValue:circleLayer.strokeStart toValue:value func:CircularEaseInOut frameCount:duration * 30];
        circleLayer.strokeStart = value;
        [circleLayer addAnimation:keyanimation forKey:nil];
        
    }
    else{
        // 关闭动画
        //设置变化动画过程是否显示，默认为YES不显示
        [CATransaction setDisableActions:YES];
        
        circleLayer.strokeStart = value;
        
        [CATransaction setDisableActions:NO];
    }
    
    
}


@end
