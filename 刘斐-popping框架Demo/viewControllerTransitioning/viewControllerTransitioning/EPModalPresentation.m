//
//  EPModalPresentation.m
//  viewControllerTransitioning
//
//  Created by tianNanYiHao on 2018/3/27.
//  Copyright © 2018年 tianNanYiHao. All rights reserved.
//

#import "EPModalPresentation.h"

@interface EPModalPresentation()
{
    EPModalPresentationStyle myStyle;
}
@end


@implementation EPModalPresentation


- (instancetype)initWithStyle:(EPModalPresentationStyle)style{
    if ([super init]) {
        myStyle = style;
        self.transitionDuration = 0.5f;
    }
    return self;
}

- (void)setTransitionDuration:(NSTimeInterval)transitionDuration{
    _transitionDuration = transitionDuration;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return _transitionDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    if (myStyle == EPModalPresentationPresent) {
        [self presetnAnimation:transitionContext];
    }
    if (myStyle == EPModalPresentationDismiss) {
        [self dismissAnimation:transitionContext];
    }
    
}

//presetn
- (void)presetnAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromeVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC    = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //
    UIView *tempView = [fromeVC.view snapshotViewAfterScreenUpdates:NO];
    fromeVC.view.hidden = YES;
    
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:tempView];
    [containerView addSubview:toVC.view];
    
    toVC.view.frame = CGRectMake(0, toVC.view.frame.size.height,  toVC.view.frame.size.width, toVC.view.frame.size.height);
    toVC.view.layer.cornerRadius = 10;
    toVC.view.layer.masksToBounds = YES;
    toVC.view.userInteractionEnabled = YES;
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.f usingSpringWithDamping:0.35f initialSpringVelocity:1/0.35f options:0 animations:^{
        
        tempView.frame = CGRectMake(tempView.frame.size.width/4, tempView.frame.size.height/4, tempView.frame.size.width/2, tempView.frame.size.height/2);
        tempView.alpha = 0.3f;
        toVC.view.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 300, toVC.view.frame.size.width, 300);
        
    } completion:^(BOOL finished) {
        
    }];
    
    
    
}

//dismiss
- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromeVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    UIView *tempView = [containerView.subviews firstObject];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.f usingSpringWithDamping:0.35 initialSpringVelocity:1/0.35f options:0 animations:^{
        tempView.frame = [UIScreen mainScreen].bounds;
        tempView.alpha = 1.f;
        fromeVC.view.alpha = 0.3f;
        fromeVC.view.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, 0, 0);
    } completion:^(BOOL finished) {
        toVC.view.hidden = YES;
        [tempView removeFromSuperview];
    }];
    
}

@end
