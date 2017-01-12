//
//  ROllLabel.m
//  RollLabel
//
//  Created by zhouxl on 12-11-2.
//  Copyright (c) 2012年 zhouxl. All rights reserved.
//


#import "ROllLabel.h"

@implementation ROllLabel

- (id)initWithFrame:(CGRect)frame Withsize:(CGSize)size
{
    self = [super initWithFrame:frame];
    if (self) {
        self.showsVerticalScrollIndicator   = NO;
        self.showsHorizontalScrollIndicator = NO;//水平滚动条
//        self.bounces = NO;
        self.contentSize = size;//滚动大小
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
+ (void)rollLabelTitle:(NSString *)title color:(UIColor *)color backgroundColor:(UIColor *)backgroundColor font:(UIFont *)font superView:(UIView *)superView fram:(CGRect)rect
{
    //文字大小，设置label的大小和uiscroll的大小
    CGSize size = [title  sizeWithFont:font constrainedToSize:kConstrainedSize lineBreakMode:NSLineBreakByWordWrapping];
    CGRect frame = CGRectMake(0, 0,superView.frame.size.width, superView.frame.size.height);
    ROllLabel *roll = [[ROllLabel alloc]initWithFrame:rect Withsize:size];
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = title;
    label.font = font;
    label.textColor = color;
    label.backgroundColor = backgroundColor;
    label.textAlignment = NSTextAlignmentCenter;
    [roll addSubview:label];
    [superView addSubview:roll];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
