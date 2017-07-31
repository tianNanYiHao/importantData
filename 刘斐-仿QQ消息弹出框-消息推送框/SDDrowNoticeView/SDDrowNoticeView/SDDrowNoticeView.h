//
//  SDDrowNoticeView.h
//  SDDrowNoticeView
//
//  Created by tianNanYiHao on 2017/7/28.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//  仿下拉通知view

#import <UIKit/UIKit.h>

@interface SDDrowNoticeView : UIView


/**
 类方法实例

 @param stringArray 信息数据
 @return 实例
 */
+(instancetype)createDrowNoticeView:(NSArray*)stringArray;


/**
 开启向下弹出动画
 */
- (void)animationDrown;


@end
