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
    //前景wave
    CAShapeLayer *waveLayerZero;
    
    //中.后景wave
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
        //防止水波浪layer超出边际
        self.layer.masksToBounds = YES;
        
        speed =3.f;
        offsetX = 2.f;
        A = 3.f;
        offsetY = self.bounds.size.height * (1);
        waveWidth = self.bounds.size.width;
        

        //后
        waveLayerTwo = [CAShapeLayer layer];
        waveLayerTwo.fillColor = [UIColor colorWithRed:219/255.f green:219/255.f blue:219/255.f alpha:0.1f].CGColor;
        [self.layer addSublayer:waveLayerTwo];
        
        //中
        waveLayerOne = [CAShapeLayer layer];
        waveLayerOne.fillColor = [UIColor colorWithRed:219/255.f green:219/255.f blue:219/255.f alpha:0.15f].CGColor;
        [self.layer addSublayer:waveLayerOne];
        
 
        //前 (由于前景wave与 中后景wave 叠加,导致颜色很深,故alpha设置为0.03f)
        waveLayerZero = [CAShapeLayer layer];
        waveLayerZero.fillColor = [UIColor colorWithRed:219/255.f green:219/255.f blue:219/255.f alpha:0.2f].CGColor;
        [self.layer addSublayer:waveLayerZero];
        
        

        //定时器
        displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(drawWaveLayer)];
        [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        
    }return self;
    
}

- (void)setWaveUpRang:(float)waveUpRang{
    _waveUpRang = waveUpRang;
    
}

- (void)setWaveChangA:(float)waveChangA{
    _waveChangA = waveChangA;
    A = _waveChangA;
}

- (void)setWavaChangeSpeed:(float)wavaChangeSpeed{
    _wavaChangeSpeed = wavaChangeSpeed;
    speed = _wavaChangeSpeed;
}


- (void)drawWaveLayer{
    
    //设置高度
    offsetY -= _waveUpSpeed;
    if (offsetY< self.bounds.size.height * (1-_waveUpRang)) {
        offsetY = self.bounds.size.height * (1-_waveUpRang);
        
    }
    
    
    
    [self drawWaveZero];
    
    [self drawWaveOne];
    [self drawWaveTwo];
    
    
    
}


//以60fps绘制水波浪layer
- (void)drawWaveZero{
    
    /*
     正弦型函数解析式：y=Asin（ωx+φ）+h
     余弦型函数解析式：y=Acos（ωx+φ）+h
     */
    
    offsetX += speed;
    
    CGFloat y = 0;
    
    CGFloat ω = 3*M_PI / waveWidth;
    CGFloat φ = offsetX*M_PI/180;
    CGFloat h = offsetY + 10;
    
    
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
    
    waveLayerZero.path = path;
    
    //释放
    CGPathRelease(path);
    
}


- (void)drawWaveOne{
    /*
     正弦型函数解析式：y=Asin（ωx+φ）+h
     余弦型函数解析式：y=Acos（ωx+φ）+h
     */
    
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
