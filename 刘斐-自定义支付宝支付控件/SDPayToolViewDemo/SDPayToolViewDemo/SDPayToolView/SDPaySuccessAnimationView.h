//
//  SDPaySuccessAnimationView.h
//  weatherDemo
//
//  Created by tianNanYiHao on 2017/7/13.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDPaySuccessAnimationView : UIView


/**
 圆环线条的粗细
 */
@property (nonatomic ,assign)CGFloat circleLineWidth;


/**
 圆环背景色
 */
@property (nonatomic ,strong)UIColor *circleBackGroundColor;

/**
 圆环线条的颜色
 */
@property (nonatomic ,strong)UIColor *circleLineColor;

/**
 √号颜色
 */
@property (nonatomic ,strong)UIColor *lineSuccessColor;

/**
 ×号颜色
 */
@property (nonatomic ,strong)UIColor *lineErrorColor;


/**
 创建实例

 @param frame frame
 @return 实例
 */
+ (instancetype)createCircleSuccessView:(CGRect)frame;


/**
 创建图形
 */
- (void)buildPath;


/**
 动画启动
 */
- (void)animationStart;



/**
 清除所有
 */
- (void)animationStopClean;



/**
 动画重开
 */
- (void)animationAgainStart;


/**
 成功动画
 */
- (void)animationSuccess;



@end
