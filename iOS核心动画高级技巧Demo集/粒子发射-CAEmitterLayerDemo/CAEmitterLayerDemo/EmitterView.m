//
//  EmitterView.m
//  CAEmitterLayerDemo
//
//  Created by tianNanYiHao on 2017/8/9.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "EmitterView.h"

@interface EmitterView(){
    
    CGSize size;
    CGRect cirframe;
    
}

@end

@implementation EmitterView


- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        size =  frame.size;
        cirframe = frame;

        [self createCA];
        
    }return self;
}


- (void)createCA{
    
    
    //masklayer
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];
    CAShapeLayer *cirLayer = [CAShapeLayer layer];
    cirLayer.path = path.CGPath;
    cirLayer.fillColor = [UIColor redColor].CGColor;
    
    //渐变layer
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, size.width, size.height);
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:29/255.0f green:204/255.0f blue:140/255.0f alpha:1].CGColor,
                             (__bridge id)[UIColor colorWithRed:171/255.0f green:243/255.0f blue:131/255.0f alpha:1].CGColor
                             ];
    gradientLayer.startPoint = CGPointMake(0.5f,1);
    gradientLayer.endPoint = CGPointMake(0.5f, 0);
    [self.layer addSublayer:gradientLayer];
    
    self.layer.mask = cirLayer;
    
    
    //emitterLayer
    UIImage *emitterCellname = [UIImage imageNamed:@"圆"];
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    
    
    //设置粒子源(粒子发射范围)的形状
    emitterLayer.emitterShape = kCAEmitterLayerPoint;
    //粒子发射模式
    emitterLayer.renderMode = kCAEmitterLayerVolume;
    emitterLayer.emitterSize = size;
   
    emitterLayer.emitterPosition = CGPointMake(size.width/2, size.height);
    
    CAEmitterCell *emitterCell = [CAEmitterCell emitterCell];
    emitterCell.name = @"圆";
    emitterCell.enabled = YES;
    emitterCell.contents = (__bridge id)emitterCellname.CGImage;
    
    
    //粒子出生速度和存在时间
    emitterCell.birthRate = 2;
    emitterCell.lifetime = 8.f;
    
    //粒子向屏幕右方(+)向偏移及偏移范围大小
    emitterCell.velocity = 10;
    emitterCell.velocityRange = -10;
    
    //粒子沿y轴方向发射加速度分量
    emitterCell.yAcceleration = -40;
    
    //粒子在发射点可以发射的角度
    emitterCell.emissionRange = -M_PI;
    
    //粒子大小/范围/变化速率
    emitterCell.scale = 0.1;
    emitterCell.scaleRange = 0.1;
    emitterCell.scaleSpeed = 0.2;
    
    //粒子过滤器放大模式
    emitterCell.magnificationFilter = kCAFilterNearest;
    emitterCell.minificationFilter = kCAFilterTrilinear;
    
    emitterLayer.emitterCells = @[emitterCell];
    [self.layer addSublayer:emitterLayer];
    
}

@end
