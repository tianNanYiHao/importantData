//
//  NavCoverView.m
//  sandbao
//
//  Created by tianNanYiHao on 2017/3/8.
//  Copyright © 2017年 sand. All rights reserved.
//

#import "NavCoverView.h"

@implementation NavCoverView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(NavCoverView*)shareNavCoverView:(CGRect)frame title:(NSString*)title{
    
    NavCoverView *v = [[NavCoverView alloc] init];
    v.frame = frame;
    
    //4.渐变色
    CAGradientLayer *layerRGB = [CAGradientLayer layer];
    layerRGB.frame = v.frame;
    layerRGB.startPoint = CGPointMake(0, 0);
    layerRGB.endPoint = CGPointMake(1, 0);
    layerRGB.colors = @[(__bridge id)[UIColor colorWithRed:0/255.0 green:92/255.0 blue:151/255.0 alpha:1].CGColor,(__bridge id)[UIColor colorWithRed:54/255.0 green:55/255.0 blue:149/255.0 alpha:1].CGColor];
    [v.layer addSublayer:layerRGB];
    
    
    //title
    // 1.标题
    UILabel *labTitle = [[UILabel alloc] init];
    labTitle.frame = CGRectMake(15, 20, v.frame.size.width-2*15, 64-20);
    labTitle.text = title;
    labTitle.font = [UIFont systemFontOfSize:17];
    labTitle.textAlignment = NSTextAlignmentCenter;
    labTitle.textColor = [UIColor whiteColor];
    [v addSubview:labTitle];
    
    //leftBtn
    
    //rightBtn
    
    
    return v;
}


@end
