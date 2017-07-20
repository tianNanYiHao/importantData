//
//  layerview.m
//  popviewtest
//
//  Created by tianNanYiHao on 2017/5/12.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "SDPopview.h"


@interface SDPopview()

@property (nonatomic, strong)CAShapeLayer *popLayer;

@end

@implementation SDPopview


#pragma mark - 懒加载
- (CAShapeLayer *)popLayer
{
    if (nil == _popLayer) {
        _popLayer = [[CAShapeLayer alloc]init];
        [self.layer addSublayer:_popLayer];
    }
    
    return _popLayer;
}



/**
 初始化
 */
-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self setDefulPopViewConfig];
    }
    return self;
}


/**
 设置默认弹出框配置信息
 */
-(void)setDefulPopViewConfig{
    _config = [SDPopViewConfig new];
    _config.triAngelHeight = 8.0;
    _config.triAngelWidth = 10.0;
    _config.containerViewCornerRadius = 10.0;
    _config.roundMargin = 5.0;
    
    // 普通用法
    _config.defaultRowHeight = 44.f;
    _config.tableBackgroundColor = [UIColor whiteColor];
    _config.separatorColor = [UIColor blackColor];
    _config.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _config.textColor = [UIColor blackColor];
    _config.font = [UIFont systemFontOfSize:14.0];

}


/**
 根据frame画弹出框Layer
 */
- (void)setLayerFrame:(CGRect)frame
{
    float apexOfTriangelX = frame.size.width/2;
//    if (_apexOftriangelX == 0) {
//        apexOfTriangelX = frame.size.width - 60;
//    }else
//    {
//        apexOfTriangelX = _apexOftriangelX;
//    }
    
    
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
    self.popLayer.fillColor =  [UIColor greenColor].CGColor;
    
    
    
}
@end
