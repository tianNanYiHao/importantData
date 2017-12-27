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


//支付控件类型
typedef NS_ENUM(NSInteger,SDPayViewStyle){
    //常规模式
    SDPayViewNomal = 0,
    //仅密码模式
    SDPayViewOnlyPwd
};

//支付工具添加卡类型
typedef NS_ENUM(NSInteger,SDPayViewAddCardType) {
    //添加银行卡
    SDPayView_ADDBANKCARD = 0,
    //添加杉德卡
    SDPayView_ADDSANDCARD
};

@protocol SDPayViewDelegate <NSObject>

/**
 返回处理后的默认支付工具

 @param defulePayToolDic 默认支付工具
 */
- (void)payViewReturnDefulePayToolDic:(NSMutableDictionary*)defulePayToolDic;

/**
 返回所选的支付工具

 @param selectPayToolDict 列表所选择的支付工具
 */
- (void)payViewSelectPayToolDic:(NSMutableDictionary*)selectPayToolDict;


/**
 获取支付工具异常

 @param errorInfo 异常信息
 */
- (void)payViewPayToolsError:(NSString*)errorInfo;

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

/**
 点击关闭按钮
 */
- (void)payViewClickCloseBtn;

@end




@interface SDPayView : UIView

@property (nonatomic, weak)id<SDPayViewDelegate>delegate;


/**
 支付工具模式- 默认模式/仅密码键盘模式
 */
@property (nonatomic, assign) SDPayViewStyle style;

/**
 支付工具添加卡类型 - 添加银行卡/杉德卡
 */
@property (nonatomic, assign) SDPayViewAddCardType addCardType;

#pragma mark - 类构造方法

/**
 类方法-构造:杉德支付工具实例

 @return 实例
 */
+ (instancetype)getPayView;


#pragma mark - SDPayViewNomal模式下方法
/**
 设置支付工具数组

 @param payArray 支付工具数组
 */
- (void)setPayTools:(NSArray*)payTools;

/**
 设置支付信息

 @param orderInfo 订单信息
 */
- (void)setPayInfo:(NSArray*)orderInfo;

/**
 支付工具归位:(从支付密码页返回订单页)
 */
- (void)originPayTool;


#pragma mark - 共用方法

/**
 显示支付工具
 */
- (void)showPayTool;


/**
 隐藏支付工具
 */
- (void)hidPayTool;



@end
