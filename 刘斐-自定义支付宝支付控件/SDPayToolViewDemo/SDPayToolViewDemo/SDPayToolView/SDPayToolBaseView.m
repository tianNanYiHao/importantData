//
//  SDPayToolBaseView.m
//  SDPayToolViewDemo
//
//  Created by tianNanYiHao on 2017/9/8.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "SDPayToolBaseView.h"
#import "SDPayConfig.h"
@interface SDPayToolBaseView()
{
    
}
@end

@implementation SDPayToolBaseView

@synthesize rightBtn;
@synthesize leftBtn;
@synthesize midTitleLab;
@synthesize lineView;





- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        [self createPayToolBaseUI];
    }
    return self;
}

- (void)createPayToolBaseUI{
    
    //headTitleView
    UIView *headTitleView = [[UIView alloc] init];
    [self addSubview:headTitleView];
    
    //左边按钮
    leftBtn = [[UIButton alloc] init];
    [leftBtn setImage:[UIImage imageNamed:@"payClosed"] forState:UIControlStateNormal];
    [headTitleView addSubview:leftBtn];

    //中间title
    midTitleLab = [[UILabel alloc] init];
    midTitleLab.text = @"父控件标题";
    midTitleLab.font = [UIFont systemFontOfSize:titleFont];
    midTitleLab.textColor = textBlackColor;
    midTitleLab.textAlignment = NSTextAlignmentCenter;
    midTitleLab.numberOfLines = 0.f;
    [headTitleView addSubview:midTitleLab];
    
    
    //右边按钮
    rightBtn = [[UIButton alloc] init];
    [rightBtn setImage:[UIImage imageNamed:@"payHelp"] forState:UIControlStateNormal];
    [headTitleView addSubview:rightBtn];
    
    //线
    lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [headTitleView addSubview:lineView];
    
    //设置frame
    CGFloat imgW = ImgSizeW(@"payClosed");
    CGFloat btnW = imgW*2;
    CGFloat midTitleLabW = ScreenW - 2*btnW;
    CGSize sizeAttributes = [midTitleLab.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:titleFont]}];
    CGFloat midTitleLabH = sizeAttributes.height;
    CGFloat headTitleViewH = midTitleLabH + 2*SIDE_LEFT_RIGHT;
    
    headTitleView.frame = CGRectMake(0, 0, ScreenW, headTitleViewH);
    leftBtn.frame = CGRectMake(0, 0, btnW, headTitleViewH);
    midTitleLab.frame = CGRectMake(btnW, SIDE_LEFT_RIGHT, midTitleLabW, midTitleLabH);
    rightBtn.frame = CGRectMake(btnW+midTitleLabW,0,btnW,headTitleViewH);
    lineView.frame = CGRectMake(0, headTitleViewH-LineBorder, ScreenW, LineBorder);
    

}







@end
