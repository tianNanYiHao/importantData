//
//  IdentityAuthToolView.m
//  GroupDemo
//
//  Created by tianNanYiHao on 2017/4/8.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "IdentityAuthToolView.h"
#import "NSString+string.h"
#define portraitLineViewColor [UIColor colorWithRed:(237/255.0) green:(237/255.0) blue:(237/255.0) alpha:1.0]

#define landscapeLineViewColor [UIColor colorWithRed:(237/255.0) green:(237/255.0) blue:(237/255.0) alpha:1.0]

#define titleColor [UIColor colorWithRed:(20/255.0) green:(20/255.0) blue:(20/255.0) alpha:1.0]

#define textFiledColor [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:1.0]

#define pwdTextFieldTextColor [UIColor blackColor]

#define ColorHUI [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1.0]
@interface IdentityAuthToolView()
{
    
}
@property (nonatomic, assign) CGSize viewSize;
@property (nonatomic, assign) CGFloat leftRightSpace;
@property (nonatomic,assign)  CGFloat txtTextSize;
@property (nonatomic,assign)  CGFloat labelTextSize;
@property (nonatomic,assign)  CGFloat btnTextSize;
@property (nonatomic,assign)  CGFloat titleSize;
@end

@implementation IdentityAuthToolView

@synthesize viewSize;
@synthesize leftRightSpace;
@synthesize txtTextSize;
@synthesize labelTextSize;
@synthesize btnTextSize;
@synthesize titleSize;
@synthesize realNameVerificationTextField;
@synthesize IDCardVerificationTextField;

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
 *@brief 真实姓名+身份证 验证
 *@return CGFloat
 */
- (CGFloat)realNameAndIDCardVerification
{
    CGFloat space = 10.0;
    CGSize tipLabSize = CGSizeZero;
    CGFloat tipViewH = 0;
    //TipView
    if (_tipShow) {
        UIView *tipView = [[UIView alloc] init];
        tipView.backgroundColor = [UIColor colorWithRed:(242/255.0) green:(242/255.0) blue:(242/255.0) alpha:1.0];
        [self addSubview:tipView];
        NSMutableAttributedString *tipTitleInfo = [[NSMutableAttributedString alloc] initWithString:@"输入身份证号完成验证"];
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

    UIView *realNameVerificationView = [[UIView alloc] init];
    realNameVerificationView.backgroundColor = [UIColor clearColor];
    [self addSubview:realNameVerificationView];
    
    realNameVerificationTextField = [[UITextField alloc] init];
    realNameVerificationTextField .textColor = textFiledColor;
    realNameVerificationTextField.font = [UIFont systemFontOfSize:txtTextSize];
    realNameVerificationTextField.placeholder = @"请输入真实姓名";
    [realNameVerificationView addSubview:realNameVerificationTextField];
    
    UIView *realNameLineView = [[UIView alloc] init];
    realNameLineView.backgroundColor = landscapeLineViewColor;
    [self addSubview:realNameLineView];
    
    UIView *IDCardVerificationView = [[UIView alloc] init];
    IDCardVerificationView.backgroundColor = [UIColor clearColor];
    [self addSubview:IDCardVerificationView];
    
    UIView *lastLineView = [[UIView alloc] init];
    lastLineView.backgroundColor = landscapeLineViewColor;
    [self addSubview:lastLineView];
    
    IDCardVerificationTextField = [[UITextField alloc] init];
    IDCardVerificationTextField .textColor = textFiledColor;
    IDCardVerificationTextField.font = [UIFont systemFontOfSize:txtTextSize];
    IDCardVerificationTextField.placeholder = @"请输入身份证号码";
    [IDCardVerificationView addSubview:IDCardVerificationTextField];
    
    
    //设置控件的位置和大小
    CGFloat commWidth = viewSize.width - 2 * leftRightSpace;
    CGFloat lastLineViewH = 1;
    UILabel *realNameVerificationLabel = nil;
    CGSize realNameVerificationLabelSize;
    
    CGFloat realNameVerificationLabelW = 0;
    CGFloat realNameVerificationLabelH = 0;
    CGFloat realNameVerificationLabelOX = 0;
    CGFloat realNameVerificationLabelOY = 0;
    
    CGFloat realNameVerificationTextFieldW = 0;
    CGFloat realNameVerificationTextFieldH = 0;
    CGFloat realNameVerificationTextFieldOX = 0;
    CGFloat realNameVerificationTextFieldOY = 0;
    
    CGFloat realNameLineViewW = viewSize.width - leftRightSpace;
    CGFloat realNameLineViewH = 1;
    
    UILabel *IDCardVerificationLabel = nil;
    CGSize IDCardVerificationLabelSize;
    
    CGFloat IDCardVerificationLabelW = 0;
    CGFloat IDCardVerificationLabelH = 0;
    CGFloat IDCardVerificationLabelOX = 0;
    CGFloat IDCardVerificationLabelOY = 0;
    
    CGFloat IDCardVerificationTextFieldW = 0;
    CGFloat IDCardVerificationTextFieldH = 0;
    CGFloat IDCardVerificationTextFieldOX = 0;
    CGFloat IDCardVerificationTextFieldOY = 0;
    
    if (_viewStyle == IdentityAuthToolViewStyleYes) {
        realNameVerificationLabel = [[UILabel alloc] init];
        realNameVerificationLabel.textColor = titleColor;
        realNameVerificationLabel.font = [UIFont systemFontOfSize:labelTextSize];
        realNameVerificationLabel.text = @"姓名";
        [realNameVerificationView addSubview:realNameVerificationLabel];
        
        //设置控件的位置和大小
        realNameVerificationLabelSize = [realNameVerificationLabel.text sizeWithNSStringFont:realNameVerificationLabel.font];
        
        realNameVerificationLabelW = realNameVerificationLabelSize.width;
        realNameVerificationLabelH = realNameVerificationLabelSize.height;
        realNameVerificationLabelOX = 0;
        realNameVerificationLabelOY = leftRightSpace;
        
        realNameVerificationLabel.frame = CGRectMake(realNameVerificationLabelOX, realNameVerificationLabelOY, realNameVerificationLabelW, realNameVerificationLabelH);
        
        realNameVerificationTextFieldW = commWidth - realNameVerificationLabelSize.width - space;
        realNameVerificationTextFieldOX = realNameVerificationLabelOX + realNameVerificationLabelW + space;
        
        IDCardVerificationLabel = [[UILabel alloc] init];
        IDCardVerificationLabel.textColor = titleColor;
        IDCardVerificationLabel.font = [UIFont systemFontOfSize:labelTextSize];
        IDCardVerificationLabel.text = @"身份证：";
        [IDCardVerificationView addSubview:IDCardVerificationLabel];
        
        
        IDCardVerificationLabelSize = [IDCardVerificationLabel.text sizeWithNSStringFont:IDCardVerificationLabel.font];
        
        IDCardVerificationLabelW = IDCardVerificationLabelSize.width;
        IDCardVerificationLabelH = IDCardVerificationLabelSize.height;
        IDCardVerificationLabelOX = 0;
        IDCardVerificationLabelOY = leftRightSpace;
        
        IDCardVerificationLabel.frame = CGRectMake(IDCardVerificationLabelOX, IDCardVerificationLabelOY, IDCardVerificationLabelW, IDCardVerificationLabelH);
        
        IDCardVerificationTextFieldW = commWidth - IDCardVerificationLabelSize.width - space;
        IDCardVerificationTextFieldOX = IDCardVerificationLabelOX + IDCardVerificationLabelW + space;
    } else {
        realNameVerificationTextFieldW = commWidth;
        realNameVerificationTextFieldOX = 0;
        
        IDCardVerificationTextFieldW = commWidth;
        IDCardVerificationTextFieldOX = 0;
    }
    
    
    CGSize realNameVerificationTextFieldSize = [realNameVerificationTextField sizeThatFits:CGSizeMake(realNameVerificationTextFieldW, MAXFLOAT)];
    
    
    realNameVerificationTextFieldH = realNameVerificationTextFieldSize.height;
    realNameVerificationTextFieldOY = leftRightSpace;
    
    realNameVerificationTextField.frame = CGRectMake(realNameVerificationTextFieldOX, realNameVerificationTextFieldOY, realNameVerificationTextFieldW, realNameVerificationTextFieldH);
    
    CGFloat realNameVerificationViewW = commWidth;
    CGFloat realNameVerificationViewH = realNameVerificationTextFieldH + 2 * leftRightSpace;
    CGFloat realNameVerificationViewOX = leftRightSpace;
    CGFloat realNameVerificationViewOY = 0 + tipViewH;
    
    realNameVerificationView.frame = CGRectMake(realNameVerificationViewOX, realNameVerificationViewOY, realNameVerificationViewW, realNameVerificationViewH);
    
    CGFloat realNameLineViewOX = leftRightSpace;
    CGFloat realNameLineViewOY = realNameVerificationViewH + tipViewH;
    
    realNameLineView.frame = CGRectMake(realNameLineViewOX, realNameLineViewOY, realNameLineViewW, realNameLineViewH);
    
    CGSize IDCardVerificationTextFieldSize = [IDCardVerificationTextField sizeThatFits:CGSizeMake(IDCardVerificationTextFieldW, MAXFLOAT)];
    
    
    IDCardVerificationTextFieldH = IDCardVerificationTextFieldSize.height;
    IDCardVerificationTextFieldOY = leftRightSpace;
    
    IDCardVerificationTextField.frame = CGRectMake(IDCardVerificationTextFieldOX, IDCardVerificationTextFieldOY, IDCardVerificationTextFieldW, IDCardVerificationTextFieldH);
    
    CGFloat IDCardVerificationViewW = commWidth;
    CGFloat IDCardVerificationViewH = IDCardVerificationTextFieldH + 2 * leftRightSpace;
    CGFloat IDCardVerificationViewOX = leftRightSpace;
    CGFloat IDCardVerificationViewOY = realNameLineViewOY + realNameLineViewH;
    
    IDCardVerificationView.frame = CGRectMake(IDCardVerificationViewOX, IDCardVerificationViewOY, IDCardVerificationViewW, IDCardVerificationViewH);
    
    lastLineView.frame = CGRectMake(0, IDCardVerificationViewOY+IDCardVerificationViewH, viewSize.width, 1);
    
    return IDCardVerificationViewH + realNameVerificationViewH + realNameLineViewH + tipViewH + lastLineViewH;
}

@end
