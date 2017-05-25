//
//  PopViewConfig.h
//  popviewtest
//
//  Created by tianNanYiHao on 2017/5/12.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SDPopViewConfig : NSObject

//设置layer
@property (nonatomic, assign) float triAngelHeight; // 小三角的高度
@property (nonatomic, assign) float triAngelWidth; // 小三角的宽度
@property (nonatomic, assign) float containerViewCornerRadius; // 弹出视图背景的圆角半径
@property (nonatomic, assign) float roundMargin; // 调整弹出视图背景四周的空隙

@property (nonatomic, strong) UIColor *layerBackGroundColor; //弹出框背景色


// 设置tableView属性(使用自带tableview模式设置,其他情况可不设置一下属性)
@property (nonatomic, assign) float defaultRowHeight; // row高度
@property (nonatomic, strong) UIColor *tableBackgroundColor;//背景色
@property (nonatomic, strong) UIColor *separatorColor; // 分隔线颜色
@property (nonatomic, strong) UIColor *textColor;  //字体颜色
@property (nonatomic, assign) NSTextAlignment textAlignment; //字体位置
@property (nonatomic, strong) UIFont *font; //字体大小
@property (nonatomic, assign) UITableViewCellSeparatorStyle separatorStyle; //分离样式


@end
