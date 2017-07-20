//
//  AnimationManagerLff.m
//  customFaceSwitchLFF
//
//  Created by Lff on 16/12/30.
//  Copyright © 2016年 Lff. All rights reserved.
//

#import "AnimationManagerLff.h"
@interface AnimationManagerLff(){
    
}
@property (nonatomic,assign)CGFloat animationDruation;
@end

@implementation AnimationManagerLff

-(instancetype)initWithAnimationDruation:(CGFloat)animationDruation{
    if (self = [super init]) {
        _animationDruation = animationDruation;
    }return self;
}


/**
 faceLayer move animation //脸平移动画

 @param fromPositiom 起始点
 @param toPosition   终点
 */
-(CABasicAnimation*)faceMoveAnimationFromPosition:(CGPoint)fromPositiom toPosition:(CGPoint)toPosition{
    CABasicAnimation *moveFaceAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveFaceAnimation.fromValue = [NSValue valueWithCGPoint:fromPositiom];
    moveFaceAnimation.toValue = [NSValue valueWithCGPoint:toPosition];
    moveFaceAnimation.duration = _animationDruation *2/3;
    moveFaceAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]; //缓进缓出
    moveFaceAnimation.removedOnCompletion = NO; //动画完成后不删除
    moveFaceAnimation.fillMode = kCAFillModeForwards;  //填充模式
    return moveFaceAnimation;
}


/**
 backgroundColor animation //颜色渐变动画
 */
-(CABasicAnimation*)backgroudColorAnimationFormValue:(NSValue*)fromValue toValue:(NSValue*)toValue{
    CABasicAnimation *colorAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    colorAnimation.fromValue = fromValue;
    colorAnimation.toValue = toValue;
    colorAnimation.duration = _animationDruation*2/3;
    colorAnimation.removedOnCompletion = NO; //动画完成后不删除
    colorAnimation.fillMode = kCAFillModeForwards;
    return colorAnimation;
}


/**
 eyeMouthlayerAnimation //脸内部layer平移动画
 */
-(CABasicAnimation*)eyeMouthLayerAnimationFromValue:(NSValue*)fromValue toValue:(NSValue*)toValue{
    CABasicAnimation *eyeLayerAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"]; 
    eyeLayerAnimation.fromValue = fromValue;
    eyeLayerAnimation.toValue = toValue;
    eyeLayerAnimation.duration = _animationDruation*1/3;
    eyeLayerAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    eyeLayerAnimation.removedOnCompletion = NO;
    eyeLayerAnimation.fillMode = kCAFillModeForwards;
    return  eyeLayerAnimation;
}


/**
 eyeCloseAndOpen 关键帧动画
 */
-(CAKeyframeAnimation*)eyeCloseAndOpenAnimationWithRect:(CGRect)eyeRect{
    
    CGFloat timeCount = _animationDruation*20; //(获取动画时间内的eyeRect变化==20次)
    CGFloat x = eyeRect.origin.x;
    CGFloat y = eyeRect.origin.y;
    CGFloat width = eyeRect.size.width;
    CGFloat height = eyeRect.size.height;
    NSMutableArray *rectArr = [NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<timeCount; i++) {
        if (i < timeCount / 3) {
            // close
            height = height - eyeRect.size.height / (timeCount / 3);
        } else if (i >= timeCount / 3 && i < timeCount * 2 / 3) {
            // zero
            height = 0;
        } else {
            // open
            height = height + eyeRect.size.height / (timeCount / 3);
        }
        y = (eyeRect.size.height-height)/2;
        [rectArr addObject:[NSValue valueWithCGRect:CGRectMake(x, y, width, height)]];
    }
    
    CAKeyframeAnimation *eyeCloseOpenAnimation = [CAKeyframeAnimation animationWithKeyPath:@"eyeRect"];
    eyeCloseOpenAnimation.values = rectArr;
    eyeCloseOpenAnimation.duration = _animationDruation/3;
    eyeCloseOpenAnimation.removedOnCompletion = NO;
    eyeCloseOpenAnimation.fillMode = kCAFillModeForwards;
    return eyeCloseOpenAnimation;
}


/**
 mouthOpenAndClose  关键帧动画
 */
-(CAKeyframeAnimation*)mouthOpenAndCloseAnimationHeight:(CGFloat)height on:(BOOL)on{
    
    CGFloat timeCoutn = _animationDruation*20;
    NSMutableArray *arrVlue = [NSMutableArray arrayWithCapacity:0];
    CGFloat changeVlue = on?height:0;
    
    
    for(int i=0;i<timeCoutn;i++){
        if (on) {
            changeVlue -=  changeVlue/timeCoutn;
        }else{
            changeVlue += changeVlue/timeCoutn;
        }
        [arrVlue addObject:@(changeVlue)];
    }
    CAKeyframeAnimation *mouthOpenCloseAnimation = [CAKeyframeAnimation animationWithKeyPath:@"mouthOpenClose"];
    mouthOpenCloseAnimation.values = arrVlue;
    mouthOpenCloseAnimation.removedOnCompletion = NO;
    mouthOpenCloseAnimation.fillMode = kCAFillModeForwards;
    mouthOpenCloseAnimation.duration = _animationDruation/3;
    return mouthOpenCloseAnimation;
    
}


@end
