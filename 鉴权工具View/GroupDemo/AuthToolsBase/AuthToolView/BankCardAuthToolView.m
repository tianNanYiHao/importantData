//
//  BankCardAuthToolView.m
//  GroupDemo
//
//  Created by tianNanYiHao on 2017/4/8.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "BankCardAuthToolView.h"
#import "NSString+string.h"
#define portraitLineViewColor [UIColor colorWithRed:(237/255.0) green:(237/255.0) blue:(237/255.0) alpha:1.0]

#define landscapeLineViewColor [UIColor colorWithRed:(237/255.0) green:(237/255.0) blue:(237/255.0) alpha:1.0]

#define titleColor [UIColor colorWithRed:(20/255.0) green:(20/255.0) blue:(20/255.0) alpha:1.0]

#define textFiledColor [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:1.0]

#define pwdTextFieldTextColor [UIColor blackColor]

#define ColorHUI [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1.0]

@interface BankCardAuthToolView(){
    
}
@property (nonatomic, assign) CGSize viewSize;
@property (nonatomic, assign) CGFloat leftRightSpace;
@property (nonatomic,assign)  CGFloat txtTextSize;
@property (nonatomic,assign)  CGFloat labelTextSize;
@property (nonatomic,assign)  CGFloat btnTextSize;
@property (nonatomic,assign)  CGFloat titleSize;
@end

@implementation BankCardAuthToolView

@synthesize viewSize;
@synthesize leftRightSpace;
@synthesize txtTextSize;
@synthesize labelTextSize;
@synthesize btnTextSize;
@synthesize titleSize;
@synthesize bankNameContentVerificationLabel;
@synthesize bankCardVerificationTextField;


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
 *@brief 银行卡验证
 *@return CGFloat
 */
- (CGFloat)bankCardVerification
{
    CGFloat space = 10.0;
    CGSize tipLabSize = CGSizeZero;
    CGFloat tipViewH = 0;
    //TipView
    if (_tipShow) {
        UIView *tipView = [[UIView alloc] init];
        tipView.backgroundColor = [UIColor colorWithRed:(242/255.0) green:(242/255.0) blue:(242/255.0) alpha:1.0];
        [self addSubview:tipView];
        NSMutableAttributedString *tipTitleInfo = [[NSMutableAttributedString alloc] initWithString:@"输入银行卡号完成验证"];
        [tipTitleInfo addAttribute:NSForegroundColorAttributeName value:titleColor range:NSMakeRange(0 , 2)];
        [tipTitleInfo addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:(230/255.0) green:(2/255.0) blue:(2/255.0) alpha:1.0] range:NSMakeRange(2, 4)];
        [tipTitleInfo addAttribute:NSForegroundColorAttributeName value:titleColor range:NSMakeRange(6, 4)];
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

    UIView *bankNameVerificationView = [[UIView alloc] init];
    bankNameVerificationView.backgroundColor = [UIColor clearColor];
    [self addSubview:bankNameVerificationView];
    
    UILabel *bankNameVerificationLabel = [[UILabel alloc] init];
    bankNameVerificationLabel.textColor = titleColor;
    bankNameVerificationLabel.font = [UIFont systemFontOfSize:labelTextSize];
    bankNameVerificationLabel.text = @"开户行：";
    [bankNameVerificationView addSubview:bankNameVerificationLabel];
    
    bankNameContentVerificationLabel = [[UILabel alloc] init];
    bankNameContentVerificationLabel.textColor = titleColor;
    bankNameContentVerificationLabel.font = [UIFont systemFontOfSize:txtTextSize];
    bankNameContentVerificationLabel.text = @"请输入开户行：";
    [bankNameVerificationView addSubview:bankNameContentVerificationLabel];
    
    UIView *bankNameLineView = [[UIView alloc] init];
    bankNameLineView.backgroundColor = landscapeLineViewColor;
    [self addSubview:bankNameLineView];
    
    UIView *bankCardVerificationView = [[UIView alloc] init];
    bankCardVerificationView.backgroundColor = [UIColor clearColor];
    [self addSubview:bankCardVerificationView];
    
    UIView *lastLineView = [[UIView alloc] init];
    lastLineView.backgroundColor = landscapeLineViewColor;
    [self addSubview:lastLineView];
    
    bankCardVerificationTextField = [[UITextField alloc] init];
    bankCardVerificationTextField .textColor = textFiledColor;
    bankCardVerificationTextField.font = [UIFont systemFontOfSize:txtTextSize];
    bankCardVerificationTextField.placeholder = @"请输入银行卡号码";
    [bankCardVerificationView addSubview:bankCardVerificationTextField];
    
    
    //设置控件的位置和大小
    CGFloat commWidth = viewSize.width - leftRightSpace * 2;
    CGFloat lastLineViewH = 1;
    UILabel *bankCardVerificationLabel = nil;
    CGSize bankCardVerificationLabelSize;
    
    CGSize bankNameVerificationLabelSize = [bankNameVerificationLabel.text sizeWithNSStringFont:bankNameVerificationLabel.font];
    
    CGFloat bankNameContentVerificationLabelW = commWidth - space - bankNameVerificationLabelSize.width;
    CGSize bankNameContentVerificationLabelSize = [bankCardVerificationTextField sizeThatFits:CGSizeMake(bankNameContentVerificationLabelW, MAXFLOAT)];
    
    CGFloat bankNameVerificationViewW = commWidth;
    CGFloat bankNameVerificationViewH = bankNameContentVerificationLabelSize.height + 2 * leftRightSpace;
    CGFloat bankNameVerificationViewOX = leftRightSpace;
    CGFloat bankNameVerificationViewOY = 0 + tipViewH;
    
    bankNameVerificationView.frame = CGRectMake(bankNameVerificationViewOX, bankNameVerificationViewOY, bankNameVerificationViewW, bankNameVerificationViewH);
    
    CGFloat bankNameVerificationLabelW = bankNameVerificationLabelSize.width;
    CGFloat bankNameVerificationLabelH = bankNameVerificationLabelSize.height;
    CGFloat bankNameVerificationLabelOX = 0;
    CGFloat bankNameVerificationLabelOY = (bankNameVerificationViewH - bankNameVerificationLabelH) / 2;
    
    bankNameVerificationLabel.frame = CGRectMake(bankNameVerificationLabelOX, bankNameVerificationLabelOY, bankNameVerificationLabelW, bankNameVerificationLabelH);
    
    CGFloat bankNameContentVerificationLabelH = bankNameContentVerificationLabelSize.height;
    CGFloat bankNameContentVerificationLabelOX = bankNameVerificationLabelOX + bankNameVerificationLabelW + space;
    CGFloat bankNameContentVerificationLabelOY = leftRightSpace;
    
    bankNameContentVerificationLabel.frame = CGRectMake(bankNameContentVerificationLabelOX, bankNameContentVerificationLabelOY, bankNameContentVerificationLabelW, bankNameContentVerificationLabelH);
    
    CGFloat bankNameLineViewW = viewSize.width - leftRightSpace;
    CGFloat bankNameLineViewH = 1;
    CGFloat bankNameLineViewOX = leftRightSpace;
    CGFloat bankNameLineViewOY = bankNameVerificationViewOY + bankNameVerificationViewH;
    
    bankNameLineView.frame = CGRectMake(bankNameLineViewOX, bankNameLineViewOY, bankNameLineViewW, bankNameLineViewH);
    
    CGFloat bankCardVerificationLabelW = 0;
    CGFloat bankCardVerificationLabelH = 0;
    CGFloat bankCardVerificationLabelOX = 0;
    CGFloat bankCardVerificationLabelOY = 0;
    
    CGFloat bankCardVerificationTextFieldW = 0;
    CGFloat bankCardVerificationTextFieldH = 0;
    CGFloat bankCardVerificationTextFieldOX = 0;
    CGFloat bankCardVerificationTextFieldOY = 0;
    
    if (_viewStyle == BankCardAuthToolViewStyleYes) {
        bankCardVerificationLabel = [[UILabel alloc] init];
        bankCardVerificationLabel.textColor = titleColor;
        bankCardVerificationLabel.font = [UIFont systemFontOfSize:labelTextSize];
        bankCardVerificationLabel.text = @"银行卡号：";
        [bankCardVerificationView addSubview:bankCardVerificationLabel];
        
        //设置控件的位置和大小
        bankCardVerificationLabelSize = [bankCardVerificationLabel.text sizeWithNSStringFont:bankCardVerificationLabel.font];
        
        bankCardVerificationLabelW = bankCardVerificationLabelSize.width;
        bankCardVerificationLabelH = bankCardVerificationLabelSize.height;
        bankCardVerificationLabelOX = 0;
        bankCardVerificationLabelOY = leftRightSpace;
        
        bankCardVerificationLabel.frame = CGRectMake(bankCardVerificationLabelOX, bankCardVerificationLabelOY, bankCardVerificationLabelW, bankCardVerificationLabelH);
        
        bankCardVerificationTextFieldW = commWidth - bankCardVerificationLabelSize.width - space;
        bankCardVerificationTextFieldOX = bankCardVerificationLabelOX + bankCardVerificationLabelW + space;
    } else {
        bankCardVerificationTextFieldW = commWidth;
        bankCardVerificationTextFieldOX = 0;
    }
    
    
    CGSize bankCardVerificationTextFieldSize = [bankCardVerificationTextField sizeThatFits:CGSizeMake(bankCardVerificationTextFieldW, MAXFLOAT)];
    
    
    bankCardVerificationTextFieldH = bankCardVerificationTextFieldSize.height;
    bankCardVerificationTextFieldOY = leftRightSpace;
    
    bankCardVerificationTextField.frame = CGRectMake(bankCardVerificationTextFieldOX, bankCardVerificationTextFieldOY, bankCardVerificationTextFieldW, bankCardVerificationTextFieldH);
    
    CGFloat bankCardVerificationViewW = commWidth;
    CGFloat bankCardVerificationViewH = bankCardVerificationTextFieldH + 2 * leftRightSpace;
    CGFloat bankCardVerificationViewOX = leftRightSpace;
    CGFloat bankCardVerificationViewOY = bankNameLineViewOY + bankNameLineViewH;
    
    bankCardVerificationView.frame = CGRectMake(bankCardVerificationViewOX, bankCardVerificationViewOY, bankCardVerificationViewW, bankCardVerificationViewH);
    
    lastLineView.frame = CGRectMake(0, bankCardVerificationViewOY+bankCardVerificationViewH, viewSize.width, 1);
    
    return bankNameVerificationViewH + bankNameLineViewH + bankCardVerificationViewH + tipViewH + lastLineViewH;
}



@end
