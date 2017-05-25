//
//  layerview.h
//  popviewtest
//
//  Created by tianNanYiHao on 2017/5/12.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDPopview;
#import "SDPopViewConfig.h"


typedef enum {
    SDPopViewStyleLeft = 1,
    SDPopViewStyleCenter,
    SDPopViewStyleRight
    
}SDPopViewStyle;


@protocol SDPopviewDelegate <NSObject>

// 点击菜单的回调
- (void)popOverView:(SDPopview *)pView didClickMenuIndex:(NSInteger)index;

@end

@interface SDPopview : UIView
@property (nonatomic, assign)id<SDPopviewDelegate> delegate;
@property (nonatomic, assign) SDPopViewStyle style;



/**
 自定义容器view
 */
@property (nonatomic, strong) UIView *contentView;

/**
 自定义容器ViewController
 */
@property (nonatomic, strong) UIViewController *contentViewController;




/**
 初始化弹出框(自定义containerView)

 @param config 配置信息可为nil
 @return SDPopview弹出框实例
 */
- (instancetype)popViewWihtconfig:(SDPopViewConfig*)config;




/**
 初始化弹出框(默认container为tableview)

 @param bounds 尺寸
 @param infoes 字典数组集
 @param config 弹出框配置信息
 @return SDPopview弹出框实例
 */
- (instancetype)initWithBounds:(CGRect)bounds titleInfo:(NSArray*)infoes config:(SDPopViewConfig *)config;



/**
 弹框弹出

 @param from 三角指向的view
 @param style 三角样式
 */
- (void)showFrom:(UIView *)from alignStyle:(SDPopViewStyle)style;

@end
