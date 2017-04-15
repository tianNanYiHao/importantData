//
//  PassAuthToolView.m
//  GroupDemo
//
//  Created by tianNanYiHao on 2017/4/8.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "PassAuthToolView.h"
#import "NSString+string.h"

#define portraitLineViewColor [UIColor colorWithRed:(237/255.0) green:(237/255.0) blue:(237/255.0) alpha:1.0]

#define landscapeLineViewColor [UIColor colorWithRed:(237/255.0) green:(237/255.0) blue:(237/255.0) alpha:1.0]

#define titleColor [UIColor colorWithRed:(20/255.0) green:(20/255.0) blue:(20/255.0) alpha:1.0]

#define textFiledColor [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:1.0]

#define pwdTextFieldTextColor [UIColor blackColor]

#define ColorHUI [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1.0]


@interface PassAuthToolView(){
    
}
@property (nonatomic, assign) CGSize viewSize;
@property (nonatomic, assign) CGFloat leftRightSpace;
@property (nonatomic,assign)  CGFloat txtTextSize;
@property (nonatomic,assign)  CGFloat labelTextSize;
@property (nonatomic,assign)  CGFloat titleSize;



@end;


@implementation PassAuthToolView



@synthesize viewSize;
@synthesize leftRightSpace;
@synthesize txtTextSize;
@synthesize labelTextSize;
@synthesize titleSize;


@synthesize loginPwdVerificationTextField;
@synthesize loginPwdVerificationBtn;

-(instancetype)init{
    if (self = [super init]) {
        viewSize = [UIScreen mainScreen].bounds.size;
        leftRightSpace = 15;
        txtTextSize = 13;
        titleSize = 12;
        labelTextSize = 13;
    }return self;
    
}



/**
 *@brief 登录密码验证
 *@return CGFloat
 */
- (CGFloat)loginPwdVerification
{
    
    CGFloat space = 10.0;
    CGSize tipLabSize = CGSizeZero;
    CGFloat tipViewH = 0;
    
    //TipView
    if (_tipShow) {
        UIView *tipView = [[UIView alloc] init];
        tipView.backgroundColor = [UIColor colorWithRed:(242/255.0) green:(242/255.0) blue:(242/255.0) alpha:1.0];
        [self addSubview:tipView];
        NSMutableAttributedString *tipTitleInfo = [[NSMutableAttributedString alloc] initWithString:@"输入原登陆密码完成身份验证"];
        [tipTitleInfo addAttribute:NSForegroundColorAttributeName value:titleColor range:NSMakeRange(0 , 2)];
        [tipTitleInfo addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:(230/255.0) green:(2/255.0) blue:(2/255.0) alpha:1.0] range:NSMakeRange(2, 5)];
        [tipTitleInfo addAttribute:NSForegroundColorAttributeName value:titleColor range:NSMakeRange(7, 6)];
        UILabel *tipLab = [[UILabel alloc] init];
        tipLab.attributedText = tipTitleInfo;
        tipLab.font = [UIFont systemFontOfSize:titleSize];
        [tipView addSubview:tipLab];
        
        CGFloat tipLabWith = viewSize.width - 2 * leftRightSpace;
        tipLabSize = [tipLab sizeThatFits:CGSizeMake(tipLabWith, MAXFLOAT)];
        tipViewH = tipLabSize.height + 2 * space;
        tipView.frame = CGRectMake(leftRightSpace, 0, tipLabWith, tipViewH);
        tipLab.frame = CGRectMake(0, 10, tipLabWith, tipLabSize.height);
    }
    
    
    UIView *loginPwdVerificationView = [[UIView alloc] init];
    loginPwdVerificationView.backgroundColor = [UIColor clearColor];
    [self addSubview:loginPwdVerificationView];
    
    loginPwdVerificationTextField = [[UITextField alloc] init];
    loginPwdVerificationTextField .textColor = textFiledColor;
    loginPwdVerificationTextField.font = [UIFont systemFontOfSize:txtTextSize];
    loginPwdVerificationTextField.placeholder = @"请输入8-20位数字和字母组合密码";
    loginPwdVerificationTextField.secureTextEntry = YES;
    [loginPwdVerificationView addSubview:loginPwdVerificationTextField];
    
    UIImage *loginPwdVerificationBtnImage = [UIImage imageNamed:@"list_eyes_off"];
    loginPwdVerificationBtn = [[UIButton alloc] init];
    [loginPwdVerificationBtn setImage:loginPwdVerificationBtnImage forState:UIControlStateNormal];
    loginPwdVerificationBtn.contentMode = UIViewContentModeScaleAspectFit;
    [loginPwdVerificationView addSubview:loginPwdVerificationBtn];
    
    
    //设置控件的位置和大小
    CGFloat commWidth = viewSize.width - leftRightSpace * 2;
    UILabel *loginPwdVerificationLabel = nil;
    CGSize loginPwdVerificationLabelSize;
    
    CGFloat loginPwdVerificationLabelW = 0;
    CGFloat loginPwdVerificationLabelH = 0;
    CGFloat loginPwdVerificationLabelOX = 0;
    CGFloat loginPwdVerificationLabelOY = 0;
    
    CGFloat loginPwdVerificationTextFieldW = 0;
    CGFloat loginPwdVerificationTextFieldH = 0;
    CGFloat loginPwdVerificationTextFieldOX = 0;
    CGFloat loginPwdVerificationTextFieldOY = 0;
    
    CGFloat loginPwdVerificationBtnW = loginPwdVerificationBtnImage.size.width + 0;
    CGFloat loginPwdVerificationBtnH = loginPwdVerificationBtnImage.size.height + 0;
    
    if (_viewstyle == PassAuthToolViewStyleYes) {
        loginPwdVerificationLabel = [[UILabel alloc] init];
        loginPwdVerificationLabel.textColor = titleColor;
        loginPwdVerificationLabel.font = [UIFont systemFontOfSize:labelTextSize];
        loginPwdVerificationLabel.text = @"密码";
        [loginPwdVerificationView addSubview:loginPwdVerificationLabel];
        
        //设置控件的位置和大小
        loginPwdVerificationLabelSize = [loginPwdVerificationLabel.text sizeWithNSStringFont:loginPwdVerificationLabel.font];
        
        loginPwdVerificationLabelW = loginPwdVerificationLabelSize.width;
        loginPwdVerificationLabelH = loginPwdVerificationLabelSize.height;
        loginPwdVerificationLabelOX = 0;
        loginPwdVerificationLabelOY = leftRightSpace;
        
        loginPwdVerificationLabel.frame = CGRectMake(loginPwdVerificationLabelOX, loginPwdVerificationLabelOY, loginPwdVerificationLabelW, loginPwdVerificationLabelH);
        
        loginPwdVerificationTextFieldW = commWidth - loginPwdVerificationLabelSize.width - space - loginPwdVerificationBtnW - space;
        loginPwdVerificationTextFieldOX = loginPwdVerificationLabelOX + loginPwdVerificationLabelW + space;
    } else {
        loginPwdVerificationTextFieldW = commWidth - loginPwdVerificationBtnW - space;
        loginPwdVerificationTextFieldOX = 0;
    }
    
    
    CGSize loginPwdVerificationTextFieldSize = [loginPwdVerificationTextField sizeThatFits:CGSizeMake(loginPwdVerificationTextFieldW, MAXFLOAT)];
    
    
    loginPwdVerificationTextFieldH = loginPwdVerificationTextFieldSize.height;
    loginPwdVerificationTextFieldOY = leftRightSpace;
    
    loginPwdVerificationTextField.frame = CGRectMake(loginPwdVerificationTextFieldOX, loginPwdVerificationTextFieldOY, loginPwdVerificationTextFieldW, loginPwdVerificationTextFieldH);
    
    CGFloat loginPwdVerificationBtnOX = loginPwdVerificationTextFieldOX + loginPwdVerificationTextFieldW + space;
    CGFloat loginPwdVerificationBtnOY = loginPwdVerificationTextFieldOY;
    
    loginPwdVerificationBtn.frame = CGRectMake(loginPwdVerificationBtnOX, loginPwdVerificationBtnOY, loginPwdVerificationBtnW, loginPwdVerificationBtnH);
    
    CGFloat loginPwdVerificationViewW = commWidth;
    CGFloat loginPwdVerificationViewH = loginPwdVerificationTextFieldH + 2 * leftRightSpace;
    CGFloat loginPwdVerificationViewOX = leftRightSpace;
    CGFloat loginPwdVerificationViewOY = 0 + tipViewH;
    
    loginPwdVerificationView.frame = CGRectMake(loginPwdVerificationViewOX, loginPwdVerificationViewOY, loginPwdVerificationViewW, loginPwdVerificationViewH);
    
    return loginPwdVerificationViewH + tipViewH;
}

@end
