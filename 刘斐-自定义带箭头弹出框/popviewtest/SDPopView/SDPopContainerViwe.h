//
//  SDPopContainerViwe.h
//  popviewtest
//
//  Created by tianNanYiHao on 2017/5/24.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDPopViewConfig.h"

@interface SDPopContainerViwe : UIView

//弹出框容器view属性设置
@property (nonatomic, assign) CGFloat  apexOftriangelX; //三角的顶点(x)
@property (nonatomic, strong) CAShapeLayer *popLayer; //弹出view的Layer
@property (nonatomic, strong) UIColor *layerColor;   //Layer 颜色
@property (nonatomic, strong)SDPopViewConfig *config; //配置类属性

/**
 初始化
 
 @param config 配置信息
 @return PopOverVieConfiguration实例
 */
- (instancetype)initWithConfig:(SDPopViewConfig *)config;

@end
