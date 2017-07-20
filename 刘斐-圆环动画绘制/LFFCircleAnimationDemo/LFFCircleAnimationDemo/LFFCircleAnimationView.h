//
//  LFFCircleAnimationView.h
//  LFFCircleAnimationDemo
//
//  Created by tianNanYiHao on 2017/7/12.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LFFCircleAnimationView : UIView

//圆绘制的起点
@property (nonatomic, assign) CGFloat startAngle;

//圆绘制的终点
@property (nonatomic, assign) CGFloat endAngle;

//圆的半径
@property (nonatomic, assign) CGFloat radius;

//是否顺时针绘制
@property (nonatomic, assign) BOOL    clockWise;

//圆描边的颜色
@property (nonatomic, strong) UIColor *strokeColor;





//实例一个圆动画
+(instancetype)creatCircleViewWithFrame:(CGRect)frame;

//圆动画view属性赋值
-(void)buildCircleView;

//圆动画开始,往strokeEnd方向运动
- (void)strokeEnd:(CGFloat)value animation:(BOOL)animation duration:(CGFloat)Duration;


//圆动画开始,往strokeStart方向运动
- (void)strokeStart:(CGFloat)value animation:(BOOL)animation duration:(CGFloat)duration;



@end
