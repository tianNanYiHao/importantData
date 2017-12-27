//
//  SDPayKeyBoardView.h
//  SDPayToolViewDemo
//
//  Created by tianNanYiHao on 2017/9/8.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SDPayKeyBoardViewDelegate <NSObject>

/**
 键盘返回当前按钮的title

 @param btn 按钮
 */
- (void)payKeyBoardCurrentTitle:(UIButton*)btn;

@end

@interface SDPayKeyBoardView : UIView

@property (nonatomic, weak)id<SDPayKeyBoardViewDelegate>delegate;


/**
 初始化
 
 @param superView 父控件
 @return 实例
 */
+ (instancetype)keyBoardAddWith:(UIView*)superView;


/**
 弹出键盘
 */
- (void)showUpPayKeyBoardView;


/**
 退出键盘
 */
- (void)hiddenDownPayKeyBoardView;


@end
