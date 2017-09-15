//
//  SDPayToolAnimtion.m
//  SDPayToolViewDemo
//
//  Created by tianNanYiHao on 2017/9/7.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "SDPayAnimtion.h"
#import "SDPayConfig.h"


@implementation SDPayAnimtion

//支付-遮罩背景动画
+ (void)maskBackGroundViewAnimation:(UIView *)view showState:(BOOL)showState{

    if (showState) {
        [UIView animateWithDuration:durationTime delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            view.superview.hidden = NO;
            view.alpha = maskViewShowAlpha;
        } completion:^(BOOL finished) {
            
        }];
    }else{
        [UIView animateWithDuration:durationTime delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
             view.alpha = maksViewHidAlpha;
        } completion:^(BOOL finished) {
            view.superview.hidden = YES;
            [view removeFromSuperview];
        }];
    }
}


//支付-订单信息(视图)动画
+ (void)payToolOrderViewAnimation:(UIView *)view frame:(CGRect)rect showState:(BOOL)showState{
    
    if (showState) {
        [UIView animateWithDuration:durationTime delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            view.frame = rect;
        } completion:^(BOOL finished) {
            
        }];
    }else{
        [UIView animateWithDuration:durationTime delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            view.frame = rect;
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
    }
}

//支付-支付工具列表(视图)动画

+ (void)payToolListViewAnimation:(UIView *)view frame:(CGRect)rect showState:(BOOL)showState{
    
    if (showState) {
        [UIView animateWithDuration:durationTime delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            view.frame = rect;
        } completion:^(BOOL finished) {
            
        }];
    }else{
        [UIView animateWithDuration:durationTime delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            view.frame = rect;
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
    }
}

//支付-支付密码(视图)动画
+ (void)payToolPwdViewAnimation:(UIView*)view frame:(CGRect)rect showState:(BOOL)showState{
    
    if (showState) {
        [UIView animateWithDuration:durationTime delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            view.frame = rect;
        } completion:^(BOOL finished) {
            
        }];
    }else{
        [UIView animateWithDuration:durationTime delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            view.frame = rect;
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
    }
}

//支付-支付键盘(视图)动画
+ (void)payKeyBoardViewAnimation:(UIView*)view frame:(CGRect)rect showState:(BOOL)showState{
    
    if (showState) {
        [UIView animateWithDuration:durationTime delay:durationTime options:UIViewAnimationOptionCurveEaseInOut animations:^{
            view.frame = rect;
        } completion:^(BOOL finished) {
            
        }];
    }else{
        [UIView animateWithDuration:durationTime delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            view.frame = rect;
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
    }
}


@end
