//
//  XYSwitch.m
//  XiangYo
//
//  Created by Jaunce on 14/12/3.
//  Copyright (c) 2014年 TTG. All rights reserved.
//

#import "XYSwitch.h"
#define kSwitchWidth 28

@interface XYSwitch ()

@property (strong, nonatomic) UIImage *onImage;
@property (strong, nonatomic) UIImage *offImage;

@end

@implementation XYSwitch

- (void)awakeFromNib
{
    [self setUp];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame onImage:(UIImage *)onImage offImage:(UIImage *)offImage
{
    self = [super initWithFrame:frame];
    if (self) {
        self.offImage = offImage;
        self.onImage = onImage;
        [self setUp];
    }
    return self;
}

- (void)setOnImage:(UIImage *)onImage offImage:(UIImage *)offImage
{
    self.offImage = offImage;
    self.onImage = onImage;
    [self setUp];
}

- (void)setUp
{
    [self setOn:NO];
    [self addTarget:self action:@selector(didClickButton) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setOn:(BOOL)on
{
    [self setOn:on animated:NO];
}

- (void)setOn:(BOOL)on animated:(BOOL)animated
{
    _on = on;
    if (on) {
        [self setBackgroundImage:self.onImage forState:UIControlStateNormal];
    } else {
        [self setBackgroundImage:self.offImage forState:UIControlStateNormal];
    }
}

- (void)didClickButton
{
    [self setOn:!self.on];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}



@end








