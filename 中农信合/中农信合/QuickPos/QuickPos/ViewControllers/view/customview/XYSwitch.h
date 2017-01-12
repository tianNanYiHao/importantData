//
//  XYSwitch.h
//  XiangYo
//
//  Created by Jaunce on 14/12/3.
//  Copyright (c) 2014年 TTG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYSwitch : UIButton

@property(nonatomic,assign) BOOL on;

- (void)setOn:(BOOL)on animated:(BOOL)animated;

- (id)initWithFrame:(CGRect)frame onImage:(UIImage *)onImage offImage:(UIImage *)offImage;

- (void)setOnImage:(UIImage *)onImage offImage:(UIImage *)offImage;

@end

