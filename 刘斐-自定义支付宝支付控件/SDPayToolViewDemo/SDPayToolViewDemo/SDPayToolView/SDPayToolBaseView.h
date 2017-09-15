//
//  SDPayToolBaseView.h
//  SDPayToolViewDemo
//
//  Created by tianNanYiHao on 2017/9/8.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDPayToolBaseView : UIView

/**
 左边按钮
 */
@property (nonatomic, strong) UIButton *leftBtn;

/**
 右边按钮
 */
@property (nonatomic, strong) UIButton *rightBtn;

/**
 中间文字
 */
@property (nonatomic, strong) UILabel  *midTitleLab;


/**
 底部线
 */
@property (nonatomic, strong) UIView *lineView;


/**
 初始化

 @param frame frame
 @return 实例对象
 */
- (instancetype)initWithFrame:(CGRect)frame;

@end
