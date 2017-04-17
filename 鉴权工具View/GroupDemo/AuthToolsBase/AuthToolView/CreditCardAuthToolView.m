//
//  CreditCardAuthToolView.m
//  GroupDemo
//
//  Created by tianNanYiHao on 2017/4/8.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "CreditCardAuthToolView.h"
#import "NSString+string.h"
#define portraitLineViewColor [UIColor colorWithRed:(237/255.0) green:(237/255.0) blue:(237/255.0) alpha:1.0]

#define landscapeLineViewColor [UIColor colorWithRed:(237/255.0) green:(237/255.0) blue:(237/255.0) alpha:1.0]

#define titleColor [UIColor colorWithRed:(20/255.0) green:(20/255.0) blue:(20/255.0) alpha:1.0]

#define textFiledColor [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:1.0]

#define pwdTextFieldTextColor [UIColor blackColor]

#define ColorHUI [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1.0]
@interface CreditCardAuthToolView(){
    
    
}
@property (nonatomic, assign) CGSize viewSize;
@property (nonatomic, assign) CGFloat leftRightSpace;
@property (nonatomic,assign)  CGFloat txtTextSize;
@property (nonatomic,assign)  CGFloat labelTextSize;
@property (nonatomic,assign)  CGFloat btnTextSize;
@property (nonatomic,assign)  CGFloat titleSize;
@end

@implementation CreditCardAuthToolView


@synthesize viewSize;
@synthesize leftRightSpace;
@synthesize txtTextSize;
@synthesize labelTextSize;
@synthesize btnTextSize;
@synthesize titleSize;
@synthesize cvnVerificationTextField;
@synthesize expiryVerificationTextField;

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
 *@brief 信用卡验证
 *@return CGFloat
 */
- (CGFloat)creditCardVerification
{
    CGFloat space = 10.0;
    CGSize tipLabSize = CGSizeZero;
    CGFloat tipViewH = 0;
    //TipView
    if (_tipShow) {
        UIView *tipView = [[UIView alloc] init];
        tipView.backgroundColor = [UIColor colorWithRed:(242/255.0) green:(242/255.0) blue:(242/255.0) alpha:1.0];
        [self addSubview:tipView];
        NSMutableAttributedString *tipTitleInfo = [[NSMutableAttributedString alloc] initWithString:@"输入信用卡信息完成验证"];
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

    UIView *cvnVerificationView = [[UIView alloc] init];
    cvnVerificationView.backgroundColor = [UIColor clearColor];
    [self addSubview:cvnVerificationView];
    
    cvnVerificationTextField = [[UITextField alloc] init];
    cvnVerificationTextField .textColor = textFiledColor;
    cvnVerificationTextField.font = [UIFont systemFontOfSize:txtTextSize];
    cvnVerificationTextField.placeholder = @"信用卡背面后三位数字";
    [cvnVerificationView addSubview:cvnVerificationTextField];
    
    UIView *cvnLineView = [[UIView alloc] init];
    cvnLineView.backgroundColor = landscapeLineViewColor;
    [self addSubview:cvnLineView];
    
    UIView *expiryVerificationView = [[UIView alloc] init];
    expiryVerificationView.backgroundColor = [UIColor clearColor];
    [self addSubview:expiryVerificationView];
    
    UIView *lastLineView = [[UIView alloc] init];
    lastLineView.backgroundColor = landscapeLineViewColor;
    [self addSubview:lastLineView];
    
    expiryVerificationTextField = [[UITextField alloc] init];
    expiryVerificationTextField .textColor = textFiledColor;
    expiryVerificationTextField.font = [UIFont systemFontOfSize:txtTextSize];
    expiryVerificationTextField.placeholder = @"信用卡上面的有效期";
    [expiryVerificationView addSubview:expiryVerificationTextField];
    
    
    //设置控件的位置和大小
    CGFloat commWidth = viewSize.width - 2 * leftRightSpace;
    CGFloat lastLineViewH = 1;
    UILabel *cvnVerificationLabel = nil;
    CGSize cvnVerificationLabelSize;
    
    CGFloat cvnVerificationLabelW = 0;
    CGFloat cvnVerificationLabelH = 0;
    CGFloat cvnVerificationLabelOX = 0;
    CGFloat cvnVerificationLabelOY = 0;
    
    CGFloat cvnVerificationTextFieldW = 0;
    CGFloat cvnVerificationTextFieldH = 0;
    CGFloat cvnVerificationTextFieldOX = 0;
    CGFloat cvnVerificationTextFieldOY = 0;
    
    CGFloat cvnLineViewW = viewSize.width - leftRightSpace;
    CGFloat cvnLineViewH = 1;
    
    UILabel *expiryVerificationLabel = nil;
    CGSize expiryVerificationLabelSize;
    
    CGFloat expiryVerificationLabelW = 0;
    CGFloat expiryVerificationLabelH = 0;
    CGFloat expiryVerificationLabelOX = 0;
    CGFloat expiryVerificationLabelOY = 0;
    
    CGFloat expiryVerificationTextFieldW = 0;
    CGFloat expiryVerificationTextFieldH = 0;
    CGFloat expiryVerificationTextFieldOX = 0;
    CGFloat expiryVerificationTextFieldOY = 0;
    
    if (_viewStyle == CreditCardAuthToolViewStyleYes) {
        cvnVerificationLabel = [[UILabel alloc] init];
        cvnVerificationLabel.textColor = titleColor;
        cvnVerificationLabel.font = [UIFont systemFontOfSize:labelTextSize];
        cvnVerificationLabel.text = @"CVN";
        [cvnVerificationView addSubview:cvnVerificationLabel];
        
        //设置控件的位置和大小
        cvnVerificationLabelSize = [cvnVerificationLabel.text sizeWithNSStringFont:cvnVerificationLabel.font];
        
        cvnVerificationLabelW = cvnVerificationLabelSize.width;
        cvnVerificationLabelH = cvnVerificationLabelSize.height;
        cvnVerificationLabelOX = 0;
        cvnVerificationLabelOY = leftRightSpace;
        
        cvnVerificationLabel.frame = CGRectMake(cvnVerificationLabelOX, cvnVerificationLabelOY, cvnVerificationLabelW, cvnVerificationLabelH);
        
        cvnVerificationTextFieldW = commWidth - cvnVerificationLabelSize.width - space;
        cvnVerificationTextFieldOX = cvnVerificationLabelOX + cvnVerificationLabelW + space;
        
        expiryVerificationLabel = [[UILabel alloc] init];
        expiryVerificationLabel.textColor = titleColor;
        expiryVerificationLabel.font = [UIFont systemFontOfSize:labelTextSize];
        expiryVerificationLabel.text = @"有效期";
        [expiryVerificationView addSubview:expiryVerificationLabel];
        
        
        expiryVerificationLabelSize = [expiryVerificationLabel.text sizeWithNSStringFont:expiryVerificationLabel.font];
        
        expiryVerificationLabelW = expiryVerificationLabelSize.width;
        expiryVerificationLabelH = expiryVerificationLabelSize.height;
        expiryVerificationLabelOX = 0;
        expiryVerificationLabelOY = leftRightSpace;
        
        expiryVerificationLabel.frame = CGRectMake(expiryVerificationLabelOX, expiryVerificationLabelOY, expiryVerificationLabelW, expiryVerificationLabelH);
        
        expiryVerificationTextFieldW = commWidth - expiryVerificationLabelSize.width - space;
        expiryVerificationTextFieldOX = expiryVerificationLabelOX + expiryVerificationLabelW + space;
    } else {
        cvnVerificationTextFieldW = commWidth;
        cvnVerificationTextFieldOX = 0;
        
        expiryVerificationTextFieldW = commWidth;
        expiryVerificationTextFieldOX = 0;
    }
    
    
    CGSize cvnVerificationTextFieldSize = [cvnVerificationTextField sizeThatFits:CGSizeMake(cvnVerificationTextFieldW, MAXFLOAT)];
    
    
    cvnVerificationTextFieldH = cvnVerificationTextFieldSize.height;
    cvnVerificationTextFieldOY = leftRightSpace;
    
    cvnVerificationTextField.frame = CGRectMake(cvnVerificationTextFieldOX, cvnVerificationTextFieldOY, cvnVerificationTextFieldW, cvnVerificationTextFieldH);
    
    CGFloat cvnVerificationViewW = commWidth;
    CGFloat cvnVerificationViewH = cvnVerificationTextFieldH + 2 * leftRightSpace;
    CGFloat cvnVerificationViewOX = leftRightSpace;
    CGFloat cvnVerificationViewOY = 0 + tipViewH;
    
    cvnVerificationView.frame = CGRectMake(cvnVerificationViewOX, cvnVerificationViewOY, cvnVerificationViewW, cvnVerificationViewH);
    
    CGFloat cvnLineViewOX = leftRightSpace;
    CGFloat cvnLineViewOY = cvnVerificationViewH + tipViewH;
    
    cvnLineView.frame = CGRectMake(cvnLineViewOX, cvnLineViewOY, cvnLineViewW, cvnLineViewH);
    
    CGSize expiryVerificationTextFieldSize = [expiryVerificationTextField sizeThatFits:CGSizeMake(expiryVerificationTextFieldW, MAXFLOAT)];
    
    
    expiryVerificationTextFieldH = expiryVerificationTextFieldSize.height;
    expiryVerificationTextFieldOY = leftRightSpace;
    
    expiryVerificationTextField.frame = CGRectMake(expiryVerificationTextFieldOX, expiryVerificationTextFieldOY, expiryVerificationTextFieldW, expiryVerificationTextFieldH);
    
    CGFloat expiryVerificationViewW = commWidth;
    CGFloat expiryVerificationViewH = expiryVerificationTextFieldH + 2 * leftRightSpace;
    CGFloat expiryVerificationViewOX = leftRightSpace;
    CGFloat expiryVerificationViewOY = cvnLineViewOY + cvnLineViewH;
    
    expiryVerificationView.frame = CGRectMake(expiryVerificationViewOX, expiryVerificationViewOY, expiryVerificationViewW, expiryVerificationViewH);
    
    lastLineView.frame = CGRectMake(0, expiryVerificationViewOY+expiryVerificationViewH, viewSize.width, 1);
    
    return expiryVerificationViewH + cvnVerificationViewH + cvnLineViewH + tipViewH + lastLineViewH;
}

@end
