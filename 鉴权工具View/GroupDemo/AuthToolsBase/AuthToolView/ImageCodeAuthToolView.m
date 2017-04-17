//
//  ImageCodeAuthToolView.m
//  GroupDemo
//
//  Created by tianNanYiHao on 2017/4/8.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ImageCodeAuthToolView.h"
#import "NSString+string.h"

#define portraitLineViewColor [UIColor colorWithRed:(237/255.0) green:(237/255.0) blue:(237/255.0) alpha:1.0]

#define landscapeLineViewColor [UIColor colorWithRed:(237/255.0) green:(237/255.0) blue:(237/255.0) alpha:1.0]

#define titleColor [UIColor colorWithRed:(20/255.0) green:(20/255.0) blue:(20/255.0) alpha:1.0]

#define textFiledColor [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:1.0]

#define pwdTextFieldTextColor [UIColor blackColor]

#define ColorHUI [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1.0]

@interface ImageCodeAuthToolView(){
    
}
@property (nonatomic, assign) CGSize viewSize;
@property (nonatomic, assign) CGFloat leftRightSpace;
@property (nonatomic,assign)  CGFloat txtTextSize;
@property (nonatomic,assign)  CGFloat labelTextSize;
@property (nonatomic,assign)  CGFloat btnTextSize;
@property (nonatomic,assign)  CGFloat titleSize;
@end


@implementation ImageCodeAuthToolView

@synthesize viewSize;
@synthesize leftRightSpace;
@synthesize txtTextSize;
@synthesize labelTextSize;
@synthesize btnTextSize;
@synthesize titleSize;
@synthesize pictureVerificationTextField;
@synthesize pictureVerificationBtn;




-(instancetype)init{
    if (self = [super init]) {
        viewSize = [UIScreen mainScreen].bounds.size;
        leftRightSpace = 15;
        txtTextSize = 13;
        titleSize = 12;
        labelTextSize = 13;
        btnTextSize = 15;
    }
    return self;
}



/**
 *@brief 图片验证
 *@return CGFloat
 */
- (CGFloat)pictureVerification
{
    CGFloat space = 10.0;
    CGSize tipLabSize = CGSizeZero;
    CGFloat tipViewH = 0;
    //TipView
    if (_tipShow) {
        UIView *tipView = [[UIView alloc] init];
        tipView.backgroundColor = [UIColor colorWithRed:(242/255.0) green:(242/255.0) blue:(242/255.0) alpha:1.0];
        [self addSubview:tipView];
        NSMutableAttributedString *tipTitleInfo = [[NSMutableAttributedString alloc] initWithString:@"输入图片验证码完成验证"];
        [tipTitleInfo addAttribute:NSForegroundColorAttributeName value:titleColor range:NSMakeRange(0 , 2)];
        [tipTitleInfo addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:(230/255.0) green:(2/255.0) blue:(2/255.0) alpha:1.0] range:NSMakeRange(2, 5)];
        [tipTitleInfo addAttribute:NSForegroundColorAttributeName value:titleColor range:NSMakeRange(7, 4)];
        UILabel *tipLab = [[UILabel alloc] init];
        tipLab.attributedText = tipTitleInfo;
        tipLab.font = [UIFont systemFontOfSize:titleSize];
        [tipView addSubview:tipLab];
        
        CGFloat tipLabWith = viewSize.width;
        tipLabSize = [tipLab sizeThatFits:CGSizeMake(tipLabWith, MAXFLOAT)];
        tipViewH = tipLabSize.height + 2 * space;
        tipView.frame = CGRectMake(0, 0, tipLabWith, tipViewH);
        tipLab.frame = CGRectMake(leftRightSpace, 10, tipLabWith, tipLabSize.height);
    }

    UIView *pictureVerificationView = [[UIView alloc] init];
    pictureVerificationView.backgroundColor = [UIColor clearColor];
    [self addSubview:pictureVerificationView];
    
    UIView *lastLineView = [[UIView alloc] init];
    lastLineView.backgroundColor = landscapeLineViewColor;
    [self addSubview:lastLineView];
    
    pictureVerificationTextField = [[UITextField alloc] init];
    pictureVerificationTextField .textColor = textFiledColor;
    pictureVerificationTextField.font = [UIFont systemFontOfSize:txtTextSize];
    pictureVerificationTextField.placeholder = @"请输入图片上内容";
    [pictureVerificationView addSubview:pictureVerificationTextField];
    
    pictureVerificationBtn = [[UIButton alloc] init];
    pictureVerificationBtn.contentMode = UIViewContentModeScaleAspectFit;
    [pictureVerificationView addSubview:pictureVerificationBtn];
    
    //设置控件的位置和大小
    CGFloat commWidth = viewSize.width - leftRightSpace * 2;
    CGFloat lastLineViewH = 1;
    UILabel *pictureVerificationLabel = nil;
    CGSize pictureVerificationLabelSize;
    
    CGFloat pictureVerificationLabelW = 0;
    CGFloat pictureVerificationLabelH = 0;
    CGFloat pictureVerificationLabelOX = 0;
    CGFloat pictureVerificationLabelOY = 0;
    
    CGFloat pictureVerificationTextFieldW = 0;
    CGFloat pictureVerificationTextFieldH = 0;
    CGFloat pictureVerificationTextFieldOX = 0;
    CGFloat pictureVerificationTextFieldOY = 0;
    
    CGFloat pictureVerificationBtnW = 90 + 2 * 5;
    CGFloat pictureVerificationBtnH = 20 + 2 * 5;
    
    if (_viewStyle == ImageCodeAuthToolViewStyleYes) {
        pictureVerificationLabel = [[UILabel alloc] init];
        pictureVerificationLabel.textColor = titleColor;
        pictureVerificationLabel.font = [UIFont systemFontOfSize:labelTextSize];
        pictureVerificationLabel.text = @"图片验证：";
        [pictureVerificationView addSubview:pictureVerificationLabel];
        
        //设置控件的位置和大小
        pictureVerificationLabelSize = [pictureVerificationLabel.text sizeWithNSStringFont:pictureVerificationLabel.font];
        
        pictureVerificationLabelW = pictureVerificationLabelSize.width;
        pictureVerificationLabelH = pictureVerificationLabelSize.height;
        pictureVerificationLabelOX = 0;
        pictureVerificationLabelOY = leftRightSpace;
        
        pictureVerificationLabel.frame = CGRectMake(pictureVerificationLabelOX, pictureVerificationLabelOY, pictureVerificationLabelW, pictureVerificationLabelH);
        
        pictureVerificationTextFieldW = commWidth - pictureVerificationLabelSize.width - space - pictureVerificationBtnW - space;
        pictureVerificationTextFieldOX = pictureVerificationLabelOX + pictureVerificationLabelW + space;
    } else {
        pictureVerificationTextFieldW = commWidth - pictureVerificationBtnW - space;
        pictureVerificationTextFieldOX = 0;
    }
    
    
    CGSize pictureVerificationTextFieldSize = [pictureVerificationTextField sizeThatFits:CGSizeMake(pictureVerificationTextFieldW, MAXFLOAT)];
    
    pictureVerificationTextFieldH = pictureVerificationTextFieldSize.height;
    CGFloat pictureVerificationViewH = pictureVerificationTextFieldH + 2 * leftRightSpace;
    
    pictureVerificationTextFieldOY = (pictureVerificationViewH - pictureVerificationTextFieldH) / 2;
    
    pictureVerificationTextField.frame = CGRectMake(pictureVerificationTextFieldOX, pictureVerificationTextFieldOY, pictureVerificationTextFieldW, pictureVerificationTextFieldH);
    
    CGFloat pictureVerificationBtnOX = pictureVerificationTextFieldOX + pictureVerificationTextFieldW + space;
    CGFloat pictureVerificationBtnOY = (pictureVerificationViewH - pictureVerificationBtnH) / 2;
    
    pictureVerificationBtn.frame = CGRectMake(pictureVerificationBtnOX, pictureVerificationBtnOY, pictureVerificationBtnW, pictureVerificationBtnH);
    
    CGFloat pictureVerificationViewW = commWidth;
    CGFloat pictureVerificationViewOX = leftRightSpace;
    CGFloat pictureVerificationViewOY = 0 + tipViewH;
    
    pictureVerificationView.frame = CGRectMake(pictureVerificationViewOX, pictureVerificationViewOY, pictureVerificationViewW, pictureVerificationViewH);
    
     lastLineView.frame = CGRectMake(0, pictureVerificationViewOY+pictureVerificationViewH, viewSize.width, 1);
    
    return pictureVerificationViewH + tipViewH + lastLineViewH;
}


@end
