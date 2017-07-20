//
//  LFFRotateView.h
//  LFFCircleAnimationDemo
//
//  Created by tianNanYiHao on 2017/7/12.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LFFRotateView : UIView




/**
 旋转

 @param angle 角度
 @param duration 动画时长
 */
-(void)rotateAngle:(CGFloat)angle duration:(CGFloat)duration;


/**
 重置旋转起始

 @param angle 角度
 */
- (void)rotateAngle:(CGFloat)angle;

@end
