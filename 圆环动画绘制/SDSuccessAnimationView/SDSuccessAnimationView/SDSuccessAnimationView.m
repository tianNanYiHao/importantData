//
//  SDSuccessAnimationView.m
//  SDSuccessAnimationView
//
//  Created by tianNanYiHao on 2017/7/19.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "SDSuccessAnimationView.h"
#import "YXEasing.h"
//角度转弧度
#define radian(degress) ((M_PI * (degress))/180.f)

#define RRBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface SDSuccessAnimationView()
{
    CAShapeLayer *circleSuccessLayer;    // 整圆
    CAShapeLayer *successLineLayer;      //√行Layer
    
    CGRect rectFrame; //保存的frame
    
    CGPoint centenPoint; //圆心
    CGFloat radius; //半径
    CGFloat startAngle;  //起始角度
    CGFloat endAngle;   //结束角度
    BOOL    clockWise;  //是否顺时针

}
@end

@implementation SDSuccessAnimationView

#pragma mark -  ********************************func For Public*********************************


/**
 初始化
 
 @param frame frame
 @return 实例
 */
+ (instancetype)createCircleSuccessView:(CGRect)frame{
    
    SDSuccessAnimationView *rectView  = [[SDSuccessAnimationView alloc] initWithFrame:frame];
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
        startAngle = radian(340);
        endAngle = radian(350);
    }else{
        startAngle = radian(0);
        endAngle = radian(1);
        
    }
    
    //默认色彩
    if ( _lineSuccessColor == nil) {

        _lineSuccessColor = RRBA(29, 204, 140, 1);
    }
    
    //3.
    [self buildCircleSuccsessLayer];
    //4.
    [self buildSuccsessLineLayer];
    
}

- (void)buildCircleSuccsessLayer{
    //2.整圆
    UIBezierPath *pathTwo = [UIBezierPath bezierPathWithArcCenter:centenPoint radius:radius startAngle:startAngle endAngle:endAngle+radian(360) clockwise:clockWise];
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
    [pathThree stroke];
    
    successLineLayer.path = pathThree.CGPath;
    successLineLayer.fillColor = [UIColor clearColor].CGColor;
    successLineLayer.strokeColor = _lineSuccessColor.CGColor;
    
    successLineLayer.lineWidth = _circleLineWidth;
    successLineLayer.lineCap = kCALineCapRound;
    successLineLayer.lineJoin = kCALineJoinRound;
    successLineLayer.strokeEnd = 0;
}





#pragma mark - 清除所有Layer
- (void)clearAllLayer{
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
    
    [self cricleSuccessLayerAndSuccessLineLayer];
}



#pragma mark -  ********************************func For Private*********************************




//整圆-关键帧动画 √号-关键帧动画
- (void)cricleSuccessLayerAndSuccessLineLayer{
    //延迟执行绘制整圆动画
    [self performSelector:@selector(cricleSuccessLayerAnimation) withObject:nil afterDelay:0.f];
    //延迟执行绘制√号动画
    [self performSelector:@selector(successLineLayerAnimation) withObject:nil afterDelay:0.f];
}


#pragma mark - 绘制整圆动画
- (void)cricleSuccessLayerAnimation{
    
    [self cricleSuccessLayerStrokeStart:1 duration:1.5];
    
}
- (void)cricleSuccessLayerStrokeStart:(CGFloat)value duration:(CGFloat)duratimTime{
    CAKeyframeAnimation *successAnimation = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
    successAnimation.values = [YXEasing calculateFrameFromValue:circleSuccessLayer.strokeEnd toValue:value func:QuinticEaseOut frameCount:30 * duratimTime];
    successAnimation.duration = duratimTime;
    circleSuccessLayer.strokeEnd = value;
    [circleSuccessLayer addAnimation:successAnimation forKey:nil];
    
}


#pragma mark - √号动画执行
- (void)successLineLayerAnimation{
    [self successLineLayerStrokeStart:1 duration:1.5f];
}
- (void)successLineLayerStrokeStart:(CGFloat)value duration:(CGFloat)durationTime{
    
    CAKeyframeAnimation *strokeStartAnimation = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
    strokeStartAnimation.duration = durationTime;
    strokeStartAnimation.values = [YXEasing calculateFrameFromValue:successLineLayer.strokeEnd toValue:value func:QuinticEaseOut frameCount:30 * durationTime];
    successLineLayer.strokeEnd = value;
    [successLineLayer addAnimation:strokeStartAnimation forKey:@"SuccessLineAnimation"];
    
    
}



@end
