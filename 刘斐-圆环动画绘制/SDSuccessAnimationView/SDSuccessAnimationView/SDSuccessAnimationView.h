//
//  SDSuccessAnimationView.h
//  SDSuccessAnimationView
//
//  Created by tianNanYiHao on 2017/7/19.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDSuccessAnimationView : UIView

/**
 圆环线条的粗细
 */
@property (nonatomic ,assign)CGFloat circleLineWidth;






/**
 √号颜色
 */
@property (nonatomic ,strong)UIColor *lineSuccessColor;

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
- (void)clearAllLayer;



/**
 动画重开
 */
- (void)animationAgainStart;



@end
