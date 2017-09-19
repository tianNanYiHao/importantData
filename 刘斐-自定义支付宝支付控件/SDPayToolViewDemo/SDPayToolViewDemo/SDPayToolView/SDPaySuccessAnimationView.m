//
//  SDPaySuccessAnimationView.m
//  weatherDemo
//
//  Created by tianNanYiHao on 2017/7/13.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

/**
 圆点坐标：(x0,y0)
 半径：r
 角度：a0
 
 则圆上任一点为：（x1,y1）
 x1   =   x0   +   r   *   cos(ao   *   3.14   /180   )
 y1   =   y0   +   r   *   sin(ao   *   3.14   /180   )
 */


/*
 cos(弧度)=长边：斜边
 */




#import "SDPaySuccessAnimationView.h"
#import "SDPayConfig.h"

//角度转弧度
#define radian(degress) ((M_PI * (degress))/180.f)


@interface SDPaySuccessAnimationView(){
    
    CAShapeLayer *circleBackgroundLayer; //背景圆
    CAShapeLayer *circleAngleLayer;      //弧度圆
    CAShapeLayer *circleSuccessLayer;    // 整圆
    CAShapeLayer *successLineLayer;      //√行Layer
    
    CGRect rectFrame; //保存的frame
    
    
    CGPoint centenPoint; //圆心
    CGFloat radius; //半径
    CGFloat startAngle;  //起始角度
    CGFloat endAngle;   //结束角度
    BOOL    clockWise;  //是否顺时针
    
    
    
    CGFloat successTime; //成功模式的执行时间(固定)
    
    
}
@end

@implementation SDPaySuccessAnimationView


#pragma mark -  ********************************func For Public*********************************


/**
 初始化

 @param frame frame
 @return 实例
 */
+ (instancetype)createCircleSuccessView:(CGRect)frame{
    
    SDPaySuccessAnimationView *rectView  = [[SDPaySuccessAnimationView alloc] initWithFrame:frame];
    return rectView;
    
}


- (instancetype)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        
        //相关属性初始化
        rectFrame = frame;
        _circleLineWidth = 6.5f;
        radius = frame.size.width/2 - _circleLineWidth/2;
        centenPoint = CGPointMake(frame.size.width/2.f, frame.size.height/2.f);
        clockWise = YES;
        
        [self addAllLayer];
        
    }
    return self;
    
}

/**
 添加各图层
 */
- (void)addAllLayer{
    
    //0.背景圆
    circleBackgroundLayer = [CAShapeLayer layer];
    circleBackgroundLayer.frame = CGRectMake(0, 0, rectFrame.size.width, rectFrame.size.height);
    [self.layer addSublayer:circleBackgroundLayer];
    
    //1.弧度圆
    circleAngleLayer = [CAShapeLayer layer];
    //一定要设置CAShapeLayer在superLayer上的frame(否则不以锚点旋转)
    circleAngleLayer.frame = CGRectMake(0, 0, rectFrame.size.width, rectFrame.size.height);
    [self.layer addSublayer:circleAngleLayer];
    
    //2.整圆
    circleSuccessLayer = [CAShapeLayer layer];
    circleSuccessLayer.frame = CGRectMake(0, 0, rectFrame.size.width, rectFrame.size.height);
    [self.layer addSublayer:circleSuccessLayer];
    
    //3.√号
    successLineLayer = [CAShapeLayer layer];
    successLineLayer.frame = CGRectMake(0, 0, rectFrame.size.width, rectFrame.size.height);
    [self.layer addSublayer:successLineLayer];

}

#pragma mark - 绘制图形
/**
 创建图形
 */
- (void)buildPath{
    
    if (clockWise) {
        startAngle = radian(100);
        endAngle = radian(190);
    }
    
    //默认色彩
    if (_circleLineColor == nil || _circleBackGroundColor == nil || _lineSuccessColor == nil) {
        _circleBackGroundColor = [UIColor darkGrayColor];
        _circleLineColor = Rgba(42, 167, 220);
        _lineSuccessColor = Rgba(29, 204, 140);
    }
    
    //1.
    [self buildCirclrBackgroundLayer];
    //2.
    [self buildCircleAngleLayer];
    //3.
    [self buildCircleSuccsessLayer];
    //4.
    [self buildSuccsessLineLayer];
    
}

- (void)buildCirclrBackgroundLayer{
    //0.背景圆
    UIBezierPath *pathZero = [UIBezierPath bezierPathWithArcCenter:centenPoint radius:radius startAngle:radian(0) endAngle:radian(360) clockwise:clockWise];
    
    circleBackgroundLayer.path = pathZero.CGPath;
    circleBackgroundLayer.fillColor = [UIColor clearColor].CGColor;
    circleBackgroundLayer.strokeColor = _circleBackGroundColor.CGColor;
    circleBackgroundLayer.lineWidth = _circleLineWidth;
    circleBackgroundLayer.strokeEnd = 1;

}
- (void)buildCircleAngleLayer{
    //1.弧度圆
    UIBezierPath *pathOne = [UIBezierPath bezierPathWithArcCenter:centenPoint radius:radius startAngle:startAngle endAngle:endAngle clockwise:clockWise];
    circleAngleLayer.path = pathOne.CGPath;
    circleAngleLayer.fillColor = [UIColor clearColor].CGColor;
    circleAngleLayer.strokeColor = _circleLineColor.CGColor;
    circleAngleLayer.lineWidth = _circleLineWidth;
    circleAngleLayer.lineCap = kCALineCapRound;
    circleAngleLayer.strokeEnd = 0;

}
- (void)buildCircleSuccsessLayer{
    //2.整圆
    UIBezierPath *pathTwo = [UIBezierPath bezierPathWithArcCenter:centenPoint radius:radius startAngle:endAngle endAngle:endAngle+radian(360) clockwise:clockWise];
    circleSuccessLayer.path = pathTwo.CGPath;
    circleSuccessLayer.fillColor = [UIColor clearColor].CGColor;
    circleSuccessLayer.strokeColor = _lineSuccessColor.CGColor;
    circleSuccessLayer.lineWidth = _circleLineWidth;
    circleSuccessLayer.lineCap = kCALineCapRound;
    circleSuccessLayer.strokeEnd = 0;

}
- (void)buildSuccsessLineLayer{
    //3.√型
    UIBezierPath *pathThree = [UIBezierPath bezierPath];
    //√号起始点所占半径的比例
    CGFloat scaleNum = 0.718;
    //√号整体的偏移量
    CGFloat rightOffset = 0.f;
    CGFloat downOffset = 3.f;
    
    
    //point1
    CGFloat pointOneX = radius * scaleNum - rightOffset;
    CGFloat pointOneY = radius + downOffset;
    CGPoint pointOne = CGPointMake(pointOneX, pointOneY);
    //point2
    CGFloat pointTwoX = radius - rightOffset;
    CGFloat pointTwoY = radius + radius*(1-scaleNum) + downOffset;
    CGPoint pointTwo  = CGPointMake(pointTwoX, pointTwoY);
    
    //point3
    /*
     所用公式 : cos(弧度)=长边：斜边
     
     point1 与 point2 的点与圆心形成等边直角三角形
     point1 与 point2 以及 point3 要形成以point2脚为 x角度 的三角
     
     bline 为圆心到point2的直角边
     cline 为point2以夹角(x弧度) 与横半径相交的 斜边
     aline 即为 圆心到point3的值 = >  point3的 x坐标
     基于对角三角形, point3的 y 坐标 可更具需求相等或比例
     */
    
    //直角三角形长边
    CGFloat bline = radius*(1-scaleNum);
    CGFloat cline = bline/cos(radian(43));
    CGFloat aline = sqrt(cline*cline - bline*bline);
    
    CGFloat pointThrX = radius + aline*2 - rightOffset;
    CGFloat pointThrY =  radius - radius*(1-scaleNum) + downOffset;
    
    CGPoint pointThree = CGPointMake(pointThrX, pointThrY);
    
    [pathThree moveToPoint:pointOne];
    [pathThree addLineToPoint:pointTwo];
    [pathThree addLineToPoint:pointThree];
    
    ///路径不关闭 则不会连成形状
    //[pathThree closePath];
//    [pathThree stroke];
    
    successLineLayer.path = pathThree.CGPath;
    successLineLayer.fillColor = [UIColor clearColor].CGColor;
    successLineLayer.strokeColor = _lineSuccessColor.CGColor;
    
    successLineLayer.lineWidth = _circleLineWidth;
    successLineLayer.lineCap = kCALineCapRound;
    successLineLayer.lineJoin = kCALineJoinRound;
    successLineLayer.strokeEnd = 0;
}
    




#pragma mark - 清除所有Layer
- (void)animationStopClean{
    //删除
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
   
}
#pragma mark - 动画在开
- (void)animationAgainStart{
    
    [self addAllLayer];
    [self buildPath];
    [self animationStart];
    
}


#pragma mark - 动画启动

- (void)animationStart{
    
    [self circeleAngleLayerRotateAnimation:YES duration:2.f strokeStart:0 strokeEnd:1];
    
}



#pragma mark -  ********************************func For Private*********************************


//弧度圆-rotate旋转动画
- (void)circeleAngleLayerRotateAnimation:(BOOL)animation duration:(CGFloat)durationtime strokeStart:(CGFloat)stroleStart strokeEnd:(CGFloat)stroleEnd{
    
    successTime = 2*durationtime;
    
    //圆弧旋转动画
    if (animation) {
        //设置strokeStart/End 可自动生成一个30帧的动画
        circleAngleLayer.strokeStart = stroleStart;
        circleAngleLayer.strokeEnd = stroleEnd;
        
        CABasicAnimation *rotaAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotaAnimation.duration = durationtime;
        rotaAnimation.fromValue = @(radian(0));
        rotaAnimation.toValue = @(radian(360*successTime));
        rotaAnimation.repeatCount = MAXFLOAT;
        rotaAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [circleAngleLayer addAnimation:rotaAnimation forKey:@"CircleAngleRotate"];
        
        //延时执行弧度圆收尾动画 (successTime 确保弧度圆旋转位置不偏差)
//        [self performSelector:@selector(animationSuccess) withObject:nil afterDelay:successTime];
    }

}

#pragma mark - 弧度圆收尾动画 (由start方向收缩到end方向)
- (void)animationSuccess{
     //(延迟successTime时间后删除动画, 弧度圆rotate旋转到倍数位置, 确保了弧度圆旋转位置与初始位置相同)
    [circleAngleLayer removeAnimationForKey:@"CircleAngleRotate"];
    
    //弧度圆收尾动画
    [self circleAngleLayerStrokeStart:1 animation:YES duration:0.3];
    
}
- (void)circleAngleLayerStrokeStart:(CGFloat)value animation:(BOOL)animation duration:(CGFloat)durationtime{
    //过滤错误的值(0~1)
    if (value >= 1) {
        value = 1;
    }else if(value <= 0){
        value = 0;
    }
    if (animation) {
        
        CAKeyframeAnimation *strokeStartAnimation = [CAKeyframeAnimation animationWithKeyPath:@"strokeStart"];
        strokeStartAnimation.duration = durationtime;
//        strokeStartAnimation.values = [YXEasing calculateFrameFromValue:circleAngleLayer.strokeStart toValue:value func:ExponentialEaseIn frameCount:30 * durationtime];
        circleAngleLayer.strokeStart = value;
        [circleAngleLayer addAnimation:strokeStartAnimation forKey:@"CircleAngleStart"];
        
        [self cricleSuccessLayerAndSuccessLineLayer];
    }
    
}

//整圆-关键帧动画 √号-关键帧动画
- (void)cricleSuccessLayerAndSuccessLineLayer{
    //延迟执行绘制整圆动画
    [self performSelector:@selector(cricleSuccessLayerAnimation) withObject:nil afterDelay:0.3];
    //延迟执行绘制√号动画
    [self performSelector:@selector(successLineLayerAnimation) withObject:nil afterDelay:0.3];
}


#pragma mark - 绘制整圆动画
- (void)cricleSuccessLayerAnimation{
    [circleAngleLayer removeFromSuperlayer];
    [circleAngleLayer removeAnimationForKey:@"CircleAngleStart"];
    [self cricleSuccessLayerStrokeStart:1 duration:1.5];
    
}
- (void)cricleSuccessLayerStrokeStart:(CGFloat)value duration:(CGFloat)duratimTime{
    CAKeyframeAnimation *successAnimation = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
//    successAnimation.values = [YXEasing calculateFrameFromValue:circleSuccessLayer.strokeEnd toValue:value func:QuinticEaseOut frameCount:30 * duratimTime];
    successAnimation.duration = duratimTime;
    circleSuccessLayer.strokeEnd = value;
    [circleSuccessLayer addAnimation:successAnimation forKey:nil];
    
}


#pragma mark - √号动画执行
- (void)successLineLayerAnimation{
    [self successLineLayerStrokeStart:1 duration:1.5f];
}
- (void)successLineLayerStrokeStart:(CGFloat)value duration:(CGFloat)durationtime{
    
    CAKeyframeAnimation *strokeStartAnimation = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
    strokeStartAnimation.duration = durationtime;
//    strokeStartAnimation.values = [YXEasing calculateFrameFromValue:successLineLayer.strokeEnd toValue:value func:QuinticEaseOut frameCount:30 * durationtime];
    successLineLayer.strokeEnd = value;
    [successLineLayer addAnimation:strokeStartAnimation forKey:@"SuccessLineAnimation"];
    
    [self performSelector:@selector(postNitifaction) withObject:self afterDelay:durationTime*2];
}

- (void)postNitifaction{
    [[NSNotificationCenter defaultCenter] postNotificationName:PaySuccessAnimationNotifaction object:nil];
}

@end
