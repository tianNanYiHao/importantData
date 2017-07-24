//
//  UIButton+CS_FixMultiClick.h
//  FixMiniButtenClickMini
//
//  Created by tianNanYiHao on 2017/7/24.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CS_FixMultiClick)

@property (nonatomic, assign) NSTimeInterval cs_acceptEventInterval; // 重复点击的间隔

@property (nonatomic, assign) NSTimeInterval cs_acceptEventTime;

@end
