//
//  SDPopContainerViwe.m
//  popviewtest
//
//  Created by tianNanYiHao on 2017/5/24.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "SDPopContainerViwe.h"
#import "SDPopViewConfig.h"

@interface SDPopContainerViwe(){
    
}

@end


@implementation SDPopContainerViwe

#pragma mark - 懒加载
- (CAShapeLayer *)popLayer
{
    if (nil == _popLayer) {
        _popLayer = [[CAShapeLayer alloc]init];
        [self.layer addSublayer:_popLayer];
    }
    
    return _popLayer;
}

- (void)setApexOftriangelX:(CGFloat)apexOftriangelX
{
    _apexOftriangelX = apexOftriangelX;
    [self setLayerFrame:self.frame];
    
}




/**
 初始化

 @param config 配置信息
 @return PopOverVieConfiguration实例
 */
- (instancetype)initWithConfig:(SDPopViewConfig *)config
{
    self = [super init];
    if (self) {
        // kvo 监控自己的 frame 属性变化
        [self addObserver:self forKeyPath:@"frame" options:0 context:NULL];
        _config = config;
    }
    return self;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"frame"]) {
        CGRect newFrame = CGRectNull;
        if([object valueForKeyPath:keyPath] != [NSNull null]) {
            newFrame = [[object valueForKeyPath:keyPath] CGRectValue];
            [self setLayerFrame:newFrame];
            
        }
    }
}



/**
 根据frame画弹出框Layer
 */
- (void)setLayerFrame:(CGRect)frame
{
    float apexOfTriangelX;
    if (_apexOftriangelX == 0) {
        apexOfTriangelX = frame.size.width - 60;
    }else
    {
        apexOfTriangelX = _apexOftriangelX;
    }
    
    
    // 尖角必须在边框左右之间
    if (apexOfTriangelX > frame.size.width - _config.containerViewCornerRadius) {
        apexOfTriangelX = frame.size.width - _config.containerViewCornerRadius - 0.5 * _config.triAngelWidth;
    }else if (apexOfTriangelX < _config.containerViewCornerRadius) {
        apexOfTriangelX = _config.containerViewCornerRadius + 0.5 * _config.triAngelWidth;
    }
    
    
    //贝塞尔路径
    /*
     贝塞尔路径如下图 起点P0为三角的顶点  逆时针 P0->P6
     
     ___/\___
     |      |
     |______|
     
     */
    
    CGPoint point0 = CGPointMake(apexOfTriangelX, 0);
    CGPoint point1 = CGPointMake(apexOfTriangelX - _config.triAngelWidth/2, _config.triAngelHeight);
    
    CGPoint point2 = CGPointMake(_config.containerViewCornerRadius, _config.triAngelHeight);
    CGPoint point2_center = CGPointMake(_config.containerViewCornerRadius, _config.triAngelHeight + _config.containerViewCornerRadius);
    
    CGPoint point3 = CGPointMake(0, frame.size.height - _config.containerViewCornerRadius);
    CGPoint point3_center = CGPointMake(_config.containerViewCornerRadius, frame.size.height - _config.containerViewCornerRadius);
    
    CGPoint point4 = CGPointMake(frame.size.width - _config.containerViewCornerRadius, frame.size.height);
    CGPoint point4_center = CGPointMake(frame.size.width - _config.containerViewCornerRadius, frame.size.height - _config.containerViewCornerRadius);
    
    CGPoint point5 = CGPointMake(frame.size.width, _config.triAngelHeight + _config.containerViewCornerRadius);
    CGPoint point5_center = CGPointMake(frame.size.width - _config.containerViewCornerRadius, _config.triAngelHeight + _config.containerViewCornerRadius);
    
    CGPoint point6 = CGPointMake(apexOfTriangelX + 0.5 * _config.triAngelWidth, _config.triAngelHeight);
    
    
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:point0];
    [path addLineToPoint:point1];
    [path addLineToPoint:point2];
    [path addArcWithCenter:point2_center radius:_config.containerViewCornerRadius startAngle:3*M_PI_2 endAngle:M_PI clockwise:NO];
    
    [path addLineToPoint:point3];
    [path addArcWithCenter:point3_center radius:_config.containerViewCornerRadius startAngle:M_PI endAngle:M_PI_2 clockwise:NO];
    
    [path addLineToPoint:point4];
    [path addArcWithCenter:point4_center radius:_config.containerViewCornerRadius startAngle:M_PI_2 endAngle:0 clockwise:NO];
    
    [path addLineToPoint:point5];
    [path addArcWithCenter:point5_center radius:_config.containerViewCornerRadius startAngle:0 endAngle:3*M_PI_2 clockwise:NO];
    
    [path addLineToPoint:point6];
    [path closePath];
    
    
    
    self.popLayer.path = path.CGPath;
    self.popLayer.fillColor =  _config.layerBackGroundColor.CGColor;
    
    
    
}

#pragma mark - 删除kvo
- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"frame"];
}

@end
