//
//  SDPayToolAnimtion.h
//  SDPayToolViewDemo
//
//  Created by tianNanYiHao on 2017/9/7.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface SDPayAnimtion : NSObject


/**
 支付-遮罩背景动画

 @param view 遮罩背景对象
 @param showState 显示/隐藏
 */
+ (void)maskBackGroundViewAnimation:(UIView*)view showState:(BOOL)showState;



/**
 支付-订单信息(视图)动画

 @param view 支付-订单信息(视图)对象
 @param rect frame
 @param showState 显示/隐藏
 */
+ (void)payToolOrderViewAnimation:(UIView*)view frame:(CGRect)rect showState:(BOOL)showState;


/**
 支付-支付工具列表(视图)动画

 @param view 支付-支付工具列表(视图)对象
 @param rect frame
 @param showState 显示/隐藏
 */
+ (void)payToolListViewAnimation:(UIView*)view frame:(CGRect)rect showState:(BOOL)showState;



/**
 支付-支付密码(视图)动画

 @param view 支付-支付密码(视图)对象
 @param rect frame
 @param showState 显示/隐藏
 */
+ (void)payToolPwdViewAnimation:(UIView*)view frame:(CGRect)rect showState:(BOOL)showState;



/**
 支付-支付键盘(视图)动画

 @param view 支付-支付键盘(视图)对象
 @param rect frame
 @param showState 显示/隐藏
 */
+ (void)payKeyBoardViewAnimation:(UIView*)view frame:(CGRect)rect showState:(BOOL)showState;



/**
 支付 - 视图删除

 @param view 所需删除出的视图
 */
+ (void)payToolHidden:(UIView*)view;

@end
