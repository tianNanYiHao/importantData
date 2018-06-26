//
//  SDPayToolOrderView.h
//  SDPayToolViewDemo
//
//  Created by tianNanYiHao on 2017/9/7.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "SDPayToolBaseView.h"

@protocol SDPayToolOrderViewDelegate <NSObject>

/**
 跳转支付工具列表视图
 */
- (void)payToolOrderViewJumpToSDPayToolListView;

/**
 跳转支付密码视图
 */
- (void)payToolOrderViewJumpToSDPayToolPwdView;


/**
 关闭支付视图
 */
- (void)payToolOrderViewJumpToClosePayView;

@end

@interface SDPayToolOrderView : SDPayToolBaseView

@property (nonatomic, weak)id<SDPayToolOrderViewDelegate> delegate;


/**
 选择后获取的某个支付工具
 */
@property (nonatomic, strong) NSDictionary *payToolDic;


/**
 设置支付信息

 @param payListArray 支付工具数组(包含三个部分:1,可用支付工具 2,添加cell 3,不可用支付工具)
 @param payToolOrderDic 支付信息字典
 
 @{
 @"desTitle":@"这里是标题",
 @"money":@"这里是金额",
 @"orderTitle":@"这里是订单信息标题",
 @"orderDes":@"这里是支付功能描述",
 @"payTitle":@"这里是支付方式标题",
 @"payBtnTitle":@"这里是确认按钮标题"
 }
 */
- (void)setPayListArray:(NSArray *)payListArray payToolOrderInfoDic:(NSDictionary*)payToolOrderDic;

@end
