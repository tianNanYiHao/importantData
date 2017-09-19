//
//  SDPayToolView.h
//  SDPayToolViewDemo
//
//  Created by tianNanYiHao on 2017/9/7.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDPayConfig.h"
#import "SDPaySuccessAnimationView.h"


typedef enum {
    SDPayViewNomal = 0,
    SDPayViewOnlyPwd
}SDPayViewStyle;



@protocol SDPayViewDelegate <NSObject>

/**
 返回所选的支付工具

 @param selectPayToolDict 列表所选择的支付工具
 */
- (void)payViewSelectPayToolDic:(NSMutableDictionary*)selectPayToolDict;

/**
 返回支付密码
 successView负责成功动画的开始(转圈动画) / 成功(打钩动画) / 失败(失败动画)
 
 @param pwdStr 密码str
 @param successView 成功动画view对象
 */
- (void)payViewPwd:(NSString*)pwdStr paySuccessView:(SDPaySuccessAnimationView*)successView;

/**
 忘记密码

 @param type 密码类型(paypass/accpass)
 */
- (void)payViewForgetPwd:(NSString*)type;


/**
 添加新支付工具卡
 
 @param type 支付工具类型(paypass/accpass)
 */
- (void)payViewAddPayToolCard:(NSString*)type;

@end




@interface SDPayView : UIView

@property (nonatomic, assign)id<SDPayViewDelegate>delegate;


/**
 支付工具模式- 默认模式/仅密码键盘模式
 */
@property (nonatomic, assign) SDPayViewStyle style;



/**
 类方法-构造:杉德支付工具实例

 @return 实例
 */
+ (instancetype)getPayView;


/**
 统一配置支付信息

 @param payArray 支付工具(包含三个部分:1,可用支付工具 2,添加cell 3,不可用支付工具)
 @param moneyStr 金额信息
 @param orderTypeStr 订单信息
 */
- (void)setPayInfo:(NSArray*)payArray moneyStr:(NSString*)moneyStr orderTypeStr:(NSString*)orderTypeStr;



/**
 显示支付工具
 */
- (void)showPayTool;


/**
 隐藏支付工具
 */
- (void)hidPayTool;

@end
