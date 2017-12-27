//
//  SDPayToolListView.h
//  SDPayToolViewDemo
//
//  Created by tianNanYiHao on 2017/9/8.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "SDPayToolBaseView.h"

@protocol SDPayToolListViewDelegate <NSObject>

/**
 从支付工具列表跳转回订单信息视图
 */
- (void)payToolListViewJumpBackToPayToolOrderView;


/**
 返回所选择的支付工具

 @param selectPayToolDict 支付工具字典
 @param index 下标
 */
- (void)payToolListViewReturnPayToolDict:(NSDictionary*)selectPayToolDict index:(NSInteger)index;


/**
 添加支付工具

 @param payType 所添加的支付工具类型
 */
- (void)payToolListViewAddPayToolCardWithpayType:(NSString*)payType;

@end



@interface SDPayToolListView : SDPayToolBaseView
@property (nonatomic, weak) id<SDPayToolListViewDelegate> delegate;


/**
 记录所选支付工具的下标
 */
@property (nonatomic, assign) NSInteger index;

/**
 设置支付信息

 @param payListArray 支付工具数组(包含三个部分:1,可用支付工具 2,添加cell 3,不可用支付工具)
 */
- (void)setPayListArray:(NSArray *)payListArray;


@end
