//
//  SDWaveViwe.m
//  SDWaveAnimationView
//
//  Created by tianNanYiHao on 2017/8/25.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "SDWaveViwe.h"

@interface SDWaveViwe()
{
    CAShapeLayer *waveLayerOne;
    CAShapeLayer *waveLayerTwo;
    CADisplayLink *displayLink;
    
    CGFloat speed;   //波移动速度
    CGFloat offsetX; //波在X轴上的位置
    CGFloat offsetY; //波在Y轴上的位置
    CGFloat waveWidth; //波在view上的宽度
    CGFloat A;         //波的振幅
    
    
    
}
@end


@implementation SDWaveViwe



- (instancetype)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        speed = 8.f;
        offsetX = 2.f;
        A = 8.f;
        offsetY = self.bounds.size.height * (1);
        waveWidth = self.bounds.size.width;
        
        
        waveLayerOne = [CAShapeLayer layer];
        waveLayerOne.fillColor = [UIColor colorWithRed:255/255.f green:255/255.f blue:255/255.f alpha:0.6f].CGColor;
        [self.layer addSublayer:waveLayerOne];
        
        waveLayerTwo = [CAShapeLayer layer];
        waveLayerTwo.fillColor = [UIColor colorWithRed:240/255.f green:240/255.f blue:240/255.f alpha:0.4f].CGColor;
        [self.layer addSublayer:waveLayerTwo];
        

        //定时器
        displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(drawWaveLayer)];
        [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        
    }return self;
    
}


- (void)setScaleRang:(float)scaleRang{
    
    _scaleRang = scaleRang;

    
}




- (void)drawWaveLayer{
    
    [self drawWaveOne];
    [self drawWaveTwo];
}

//以60fps绘制水波浪layer
- (void)drawWaveOne{
    /*
     正弦型函数解析式：y=Asin（ωx+φ）+h
     余弦型函数解析式：y=Acos（ωx+φ）+h
     */
    
    offsetY -= _waveSpeed;
    if (offsetY< self.bounds.size.height * (1-_scaleRang)) {
        offsetY = self.bounds.size.height * (1-_scaleRang);
    }
    
    
    offsetX += speed;
    
    CGFloat y = 0;
    
    CGFloat ω = 2.5*M_PI / waveWidth;
    CGFloat φ = offsetX*M_PI/360;
    CGFloat h = offsetY;
    
    
    CGMutablePathRef path = CGPathCreateMutable();
    //起点
    CGPathMoveToPoint(path, nil, 0, offsetY);
    
    
    for (int x = 0; x <= waveWidth; x++) {
        y = A *sin(ω * x + (-φ)) + h;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    //左下角点
    CGPathAddLineToPoint(path, nil, waveWidth, self.bounds.size.height);
    
    //右下角点
    CGPathAddLineToPoint(path, nil, 0, self.bounds.size.height);
    
    //关闭路径
    CGPathCloseSubpath(path);
    
    waveLayerOne.path = path;
    
    //释放
    CGPathRelease(path);
    
}

- (void)drawWaveTwo{
    /*
     正弦型函数解析式：y=Asin（ωx+φ）+h
     余弦型函数解析式：y=Acos（ωx+φ）+h
     */

    offsetX += speed;
    
    CGFloat y = 0;
    
    CGFloat ω = 2.0*M_PI / waveWidth;
    CGFloat φ = offsetX*M_PI/210;
    CGFloat h = offsetY;
    
    
    CGMutablePathRef path = CGPathCreateMutable();
    //起点
    CGPathMoveToPoint(path, nil, 0, offsetY);
    
    
    for (int x = 0; x <= waveWidth; x++) {
        y = A *sin(ω * x + (-φ)) + h;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    //左下角点
    CGPathAddLineToPoint(path, nil, waveWidth, self.bounds.size.height);
    
    //右下角点
    CGPathAddLineToPoint(path, nil, 0, self.bounds.size.height);
    
    //关闭路径
    CGPathCloseSubpath(path);
    
    waveLayerTwo.path = path;
    
    //释放
    CGPathRelease(path);
}









@end
