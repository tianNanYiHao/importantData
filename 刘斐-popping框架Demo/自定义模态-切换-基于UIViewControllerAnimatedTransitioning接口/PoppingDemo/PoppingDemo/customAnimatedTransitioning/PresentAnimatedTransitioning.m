//
//  PresentAnimatedTransitioning.m
//  PoppingDemo
//
//  Created by tianNanYiHao on 2017/8/7.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "PresentAnimatedTransitioning.h"
#import <POP/POP.h>

@implementation PresentAnimatedTransitioning


/**
 设置该类中,动画执行的时间

 @param transitionContext 上下文信息
 @return 时间
 */
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    return 0.5f;
}


/**
 具体动画方法

 @param transitionContext 上下文信息
 */
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    //一.设置视图
    //1.获取切出控制器的视图view
    UIView *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
    //1.1 设置切出时的色彩模式
    fromView.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
    //1.2 使之不能响应点击
    fromView.userInteractionEnabled = NO;
    
    
    //2 创建底色遮盖view
    UIView *maskView = [[UIView alloc] initWithFrame:fromView.bounds];
    maskView.backgroundColor =  [UIColor colorWithRed:52/255.0f  green:152/255.0f  blue:219/255.0f alpha:1.f];
    maskView.layer.opacity = 0.0;
    
    //3.获取切入控制器的视图view
    UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    //3.1 设置出场位置
    toView.frame = CGRectMake(0, 0, CGRectGetWidth(transitionContext.containerView.bounds)  - 100, CGRectGetHeight(transitionContext.containerView.bounds)- 400);
    toView.center = CGPointMake(transitionContext.containerView.center.x, -transitionContext.containerView.center.y);
    
    [transitionContext.containerView addSubview:maskView];
    [transitionContext.containerView addSubview:toView];
    
    
    //二.利用pop框架来增加动画
    //1.positionY动画
    POPSpringAnimation *positionYAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    positionYAnimation.toValue = @(transitionContext.containerView.center.y);
    positionYAnimation.springBounciness = 20.f;
    [positionYAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        //必须通知TransitionContext动画结束,会自动删除添加的view
        [transitionContext completeTransition:YES];
    }];
    
    //2.scale动画
    POPSpringAnimation *scaleXYAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleXYAnimation.springBounciness = 20;
    scaleXYAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0.5, 0.5)];
    
    //3.maskView颜色变深动画
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.toValue = @(0.3f);
    
    [toView.layer pop_addAnimation:positionYAnimation forKey:@"positionYAnimation"];
    [toView.layer pop_addAnimation:scaleXYAnimation forKey:@"scaleXYAnimation"];
    [maskView.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
    
    
    
    
}


@end
