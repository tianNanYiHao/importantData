//
//  CardCheckCodeAuthToolView.m
//  GroupDemo
//
//  Created by tianNanYiHao on 2017/4/8.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "CardCheckCodeAuthToolView.h"
#import "NSString+string.h"
#define portraitLineViewColor [UIColor colorWithRed:(237/255.0) green:(237/255.0) blue:(237/255.0) alpha:1.0]

#define landscapeLineViewColor [UIColor colorWithRed:(237/255.0) green:(237/255.0) blue:(237/255.0) alpha:1.0]

#define titleColor [UIColor colorWithRed:(20/255.0) green:(20/255.0) blue:(20/255.0) alpha:1.0]

#define textFiledColor [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:1.0]

#define pwdTextFieldTextColor [UIColor blackColor]

#define ColorHUI [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1.0]
@interface CardCheckCodeAuthToolView()
{
    
}
@property (nonatomic, assign) CGSize viewSize;
@property (nonatomic, assign) CGFloat leftRightSpace;
@property (nonatomic,assign)  CGFloat txtTextSize;
@property (nonatomic,assign)  CGFloat labelTextSize;
@property (nonatomic,assign)  CGFloat btnTextSize;
@property (nonatomic,assign)  CGFloat titleSize;
@end

@implementation CardCheckCodeAuthToolView
@synthesize viewSize;
@synthesize leftRightSpace;
@synthesize txtTextSize;
@synthesize labelTextSize;
@synthesize btnTextSize;
@synthesize titleSize;
@synthesize sandCardVerificationTextField;


-(instancetype)init{
    if (self = [super init]) {
        viewSize = [UIScreen mainScreen].bounds.size;
        leftRightSpace = 15;
        txtTextSize = 13;
        titleSize = 12;
        labelTextSize = 13;
        btnTextSize = 15;
    }return self;
    
}




/**
 *@brief 杉德卡验证
 *@return CGFloat
 */
- (CGFloat)sandCardVerification
{
    CGFloat space = 10.0;
    CGSize tipLabSize = CGSizeZero;
    CGFloat tipViewH = 0;
    //TipView
    if (_tipShow) {
        UIView *tipView = [[UIView alloc] init];
        tipView.backgroundColor = [UIColor colorWithRed:(242/255.0) green:(242/255.0) blue:(242/255.0) alpha:1.0];
        [self addSubview:tipView];
        NSMutableAttributedString *tipTitleInfo = [[NSMutableAttributedString alloc] initWithString:@"输入杉德卡校验码完成验证"];
        [tipTitleInfo addAttribute:NSForegroundColorAttributeName value:titleColor range:NSMakeRange(0 , 2)];
        [tipTitleInfo addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:(230/255.0) green:(2/255.0) blue:(2/255.0) alpha:1.0] range:NSMakeRange(2, 6)];
        [tipTitleInfo addAttribute:NSForegroundColorAttributeName value:titleColor range:NSMakeRange(8, 4)];
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

    UIView *sandCardVerificationView = [[UIView alloc] init];
    sandCardVerificationView.backgroundColor = [UIColor clearColor];
    [self addSubview:sandCardVerificationView];
    
    UIView *lastLineView = [[UIView alloc] init];
    lastLineView.backgroundColor = landscapeLineViewColor;
    [self addSubview:lastLineView];
    
    sandCardVerificationTextField = [[UITextField alloc] init];
    sandCardVerificationTextField .textColor = textFiledColor;
    sandCardVerificationTextField.font = [UIFont systemFontOfSize:txtTextSize];
    sandCardVerificationTextField.placeholder = @"请输入杉德卡6位校验码";
    [sandCardVerificationView addSubview:sandCardVerificationTextField];
    
    
    //设置控件的位置和大小
    CGFloat commWidth = viewSize.width - leftRightSpace * 2;
    CGFloat lastLineViewH = 1;
    UILabel *sandCardVerificationLabel = nil;
    CGSize sandCardVerificationLabelSize;
    
    CGFloat sandCardVerificationLabelW = 0;
    CGFloat sandCardVerificationLabelH = 0;
    CGFloat sandCardVerificationLabelOX = 0;
    CGFloat sandCardVerificationLabelOY = 0;
    
    CGFloat sandCardVerificationTextFieldW = 0;
    CGFloat sandCardVerificationTextFieldH = 0;
    CGFloat sandCardVerificationTextFieldOX = 0;
    CGFloat sandCardVerificationTextFieldOY = 0;
    
    if (_viewStyle == CardCheckCodeAuthToolViewStyleYes) {
        sandCardVerificationLabel = [[UILabel alloc] init];
        sandCardVerificationLabel.textColor = titleColor;
        sandCardVerificationLabel.font = [UIFont systemFontOfSize:labelTextSize];
        sandCardVerificationLabel.text = @"校验码";
        [sandCardVerificationView addSubview:sandCardVerificationLabel];
        
        //设置控件的位置和大小
        sandCardVerificationLabelSize = [sandCardVerificationLabel.text sizeWithNSStringFont:sandCardVerificationLabel.font];
        
        sandCardVerificationLabelW = sandCardVerificationLabelSize.width;
        sandCardVerificationLabelH = sandCardVerificationLabelSize.height;
        sandCardVerificationLabelOX = 0;
        sandCardVerificationLabelOY = leftRightSpace;
        
        sandCardVerificationLabel.frame = CGRectMake(sandCardVerificationLabelOX, sandCardVerificationLabelOY, sandCardVerificationLabelW, sandCardVerificationLabelH);
        
        sandCardVerificationTextFieldW = commWidth - sandCardVerificationLabelSize.width - space;
        sandCardVerificationTextFieldOX = sandCardVerificationLabelOX + sandCardVerificationLabelW + space;
    } else {
        sandCardVerificationTextFieldW = commWidth;
        sandCardVerificationTextFieldOX = 0;
    }
    
    
    CGSize sandCardVerificationTextFieldSize = [sandCardVerificationTextField sizeThatFits:CGSizeMake(sandCardVerificationTextFieldW, MAXFLOAT)];
    
    
    sandCardVerificationTextFieldH = sandCardVerificationTextFieldSize.height;
    sandCardVerificationTextFieldOY = leftRightSpace;
    
    sandCardVerificationTextField.frame = CGRectMake(sandCardVerificationTextFieldOX, sandCardVerificationTextFieldOY, sandCardVerificationTextFieldW, sandCardVerificationTextFieldH);
    
    CGFloat sandCardVerificationViewW = commWidth;
    CGFloat sandCardVerificationViewH = sandCardVerificationTextFieldH + 2 * leftRightSpace;
    CGFloat sandCardVerificationViewOX = leftRightSpace;
    CGFloat sandCardVerificationViewOY = 0 + tipViewH;
    
    sandCardVerificationView.frame = CGRectMake(sandCardVerificationViewOX, sandCardVerificationViewOY, sandCardVerificationViewW, sandCardVerificationViewH);
    
    lastLineView.frame = CGRectMake(0, sandCardVerificationViewOY+sandCardVerificationViewH, viewSize.width, 1);
    
    return sandCardVerificationViewH + tipViewH + lastLineViewH;
}

@end
