//
//  SDPayToolPwdView.h
//  SDPayToolViewDemo
//
//  Created by tianNanYiHao on 2017/9/8.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "SDPayToolBaseView.h"
@class SDPaySuccessAnimationView;

@protocol SDPayToolPwdViewDelegate <NSObject>

/**
 从密码页跳转回订单信息视图
 */
- (void)payToolPwdViewjumpBackToPayToolOrderView;

/**
 忘记密码跳且返回密码类型

 @param type 密码类型
 */
- (void)payToolPwdForgetReturnPwdType:(NSString*)type;

/**
 输入六位支付密码

 @param pwdStr 密码
 @param successView 成功动画view对象
 */
- (void)payToolPwd:(NSString*)pwdStr paySuccessView:(SDPaySuccessAnimationView*)successView;


@end

@interface SDPayToolPwdView : SDPayToolBaseView

@property (nonatomic, assign)id<SDPayToolPwdViewDelegate>delegate;


/**
 是否仅支付密码View展示
 */
@property (nonatomic, assign)BOOL isOnlyPayToolPwdViewStyle;



/**
 需要输入支付密码的支付工具对象
 */
@property (nonatomic, strong) NSDictionary *selectpayToolDic;

/**
 添加杉德支付键盘
 */
- (void)addSDPayKeyBoardView;



@end
