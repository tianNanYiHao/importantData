//
//  AnimationManagerLff.h
//  customFaceSwitchLFF
//
//  Created by Lff on 16/12/30.
//  Copyright © 2016年 Lff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationManagerLff : UIView


/**
 init
 */
-(instancetype)initWithAnimationDruation:(CGFloat)animationDruation;


/**
 faceLayer move animation //脸平移动画
 
 @param fromPositiom 起始点
 @param toPosition   终点
 */
-(CABasicAnimation*)faceMoveAnimationFromPosition:(CGPoint)fromPositiom toPosition:(CGPoint)toPosition;

/**
 backgroundColor animation //颜色渐变动画
 */
-(CABasicAnimation*)backgroudColorAnimationFormValue:(NSValue*)fromValue toValue:(NSValue*)toValue;

/**
 eyeMouthlayerAnimation //脸内部layer平移动画
 */
-(CABasicAnimation*)eyeMouthLayerAnimationFromValue:(NSValue*)fromValue toValue:(NSValue*)toValue;

/**
 eyeCloseAndOpen 关键帧动画
 */
-(CAKeyframeAnimation*)eyeCloseAndOpenAnimationWithRect:(CGRect)eyeRect;

/**
 mouthOpenAndClose  关键帧动画
 */
-(CAKeyframeAnimation*)mouthOpenAndCloseAnimationHeight:(CGFloat)height on:(BOOL)on;

@end
