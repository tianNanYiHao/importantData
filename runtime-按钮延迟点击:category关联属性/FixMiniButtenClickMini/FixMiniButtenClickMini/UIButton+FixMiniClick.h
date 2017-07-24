//
//  UIButton+FixMiniClick.h
//  sandbao
//
//  Created by tianNanYiHao on 2017/7/24.
//  Copyright © 2017年 sand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (FixMiniClick)

@property (nonatomic, assign) NSTimeInterval acceptEventInterval; // 重复点击的间隔

@property (nonatomic, assign) NSTimeInterval acceptEventTime;     



@end
