//
//  SDActivityView.m
//  MBPHUDProgressLFFDemo
//
//  Created by tianNanYiHao on 2017/6/18.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "SDActivityView.h"
@interface SDActivityView(){
    NSString *imageName;
    
}@end
@implementation SDActivityView

-(instancetype)initWithImage:(NSString*)imgName view:(UIView*)view rectWH:(CGFloat)rectWH{
    if ([super init]) {
        imageName = imgName;
        self.frame = CGRectMake(0, 0, rectWH, rectWH);
        self.center = CGPointMake(view.frame.size.width/2, view.frame.size.height/2);
        self.backgroundColor = [UIColor clearColor];
        [self buildUI];
        [self startAnimation];
    }
    return self;
}




- (void)buildUI{
    UIImage *img = [UIImage imageNamed:imageName];
    UIImageView *imagV = [[UIImageView alloc] init];
    imagV.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    imagV.image = img;
    [self addSubview:imagV];
    
}

-(void)startAnimation{
    
    CAMediaTimingFunction *linearCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.fromValue = (id) 0;
    animation.toValue = @(M_PI*2);
    animation.duration = 1;
    animation.timingFunction = linearCurve;
    animation.removedOnCompletion = NO;
    animation.repeatCount = HUGE;
    animation.fillMode = kCAFillModeForwards;
    animation.autoreverses = NO;
    [self.layer addAnimation:animation forKey:@"rotate"];
    
    
    
}


////绘制一个圆环
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//    UIColor *color = [UIColor blackColor];
//    [color set]; //设置线条颜色
//    
//    UIBezierPath* aPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
//                                                         radius:15
//                                                     startAngle:0
//                                                       endAngle:M_PI*1.7
//                                                      clockwise:YES];
//    aPath.lineWidth = 1.0;
//    aPath.lineCapStyle = kCGLineCapRound; //线条拐角
//    aPath.lineJoinStyle = kCGLineCapRound; //终点处理
//    
//    [aPath stroke];
//    
//    
//}
@end
