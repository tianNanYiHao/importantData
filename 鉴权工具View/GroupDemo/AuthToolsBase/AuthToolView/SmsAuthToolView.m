//
//  SmsAuthToolView.m
//  GroupDemo
//
//  Created by tianNanYiHao on 2017/4/8.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "SmsAuthToolView.h"
#import "NSString+string.h"

#define portraitLineViewColor [UIColor colorWithRed:(237/255.0) green:(237/255.0) blue:(237/255.0) alpha:1.0]

#define landscapeLineViewColor [UIColor colorWithRed:(237/255.0) green:(237/255.0) blue:(237/255.0) alpha:1.0]

#define titleColor [UIColor colorWithRed:(20/255.0) green:(20/255.0) blue:(20/255.0) alpha:1.0]

#define textFiledColor [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:1.0]

#define pwdTextFieldTextColor [UIColor blackColor]

#define ColorHUI [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1.0]

@interface SmsAuthToolView()
{
    
}
@property (nonatomic, assign) CGSize viewSize;
@property (nonatomic, assign) CGFloat leftRightSpace;
@property (nonatomic,assign)  CGFloat txtTextSize;
@property (nonatomic,assign)  CGFloat labelTextSize;
@property (nonatomic,assign)  CGFloat btnTextSize;
@end


@implementation SmsAuthToolView

@synthesize viewSize;
@synthesize leftRightSpace;
@synthesize txtTextSize;
@synthesize labelTextSize;
@synthesize btnTextSize;
@synthesize phoneNumVerificationTextField;
@synthesize shortMsgVerificationTextField;
@synthesize shortMsgVerificationBtn;

-(instancetype)init{
    if (self = [super init]) {
        viewSize = [UIScreen mainScreen].bounds.size;
        leftRightSpace = 15;
        txtTextSize = 13;
        labelTextSize = 13;
        btnTextSize = 15;
    }return self;
}
/**
 *@brief 短信+手机号 验证
 *@return CGFloat
 */
- (CGFloat)shortMsgAndPhoneNumVerification
{
    UIView *phoneNumVerificationView = [[UIView alloc] init];
    phoneNumVerificationView.backgroundColor = [UIColor clearColor];
    [self addSubview:phoneNumVerificationView];
    
    phoneNumVerificationTextField = [[UITextField alloc] init];
    phoneNumVerificationTextField .textColor = textFiledColor;
    phoneNumVerificationTextField.font = [UIFont systemFontOfSize:txtTextSize];
    phoneNumVerificationTextField.placeholder = @"请输入11位数字手机号";
    [phoneNumVerificationView addSubview:phoneNumVerificationTextField];
    
    UIView *phoneNumLineView = [[UIView alloc] init];
    phoneNumLineView.backgroundColor = landscapeLineViewColor;
    [self addSubview:phoneNumLineView];
    
    UIView *shortMsgVerificationView = [[UIView alloc] init];
    shortMsgVerificationView.backgroundColor = [UIColor clearColor];
    [self addSubview:shortMsgVerificationView];
    
    shortMsgVerificationTextField = [[UITextField alloc] init];
    shortMsgVerificationTextField .textColor = textFiledColor;
    shortMsgVerificationTextField.font = [UIFont systemFontOfSize:txtTextSize];
    shortMsgVerificationTextField.placeholder = @"请输入6数字验证码";
    [shortMsgVerificationView addSubview:shortMsgVerificationTextField];
    
    UIView *shortMsgVerificationLineView = [[UIView alloc] init];
    shortMsgVerificationLineView.backgroundColor = [UIColor grayColor];
    [shortMsgVerificationView addSubview:shortMsgVerificationLineView];
    
    shortMsgVerificationBtn = [[UIButton alloc] init];
    shortMsgVerificationBtn.tag = 1;
    [shortMsgVerificationBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    shortMsgVerificationBtn.titleLabel.font = [UIFont systemFontOfSize:btnTextSize];
    [shortMsgVerificationBtn.layer setMasksToBounds:YES];
    shortMsgVerificationBtn.layer.cornerRadius = 5.0;
    [shortMsgVerificationView addSubview:shortMsgVerificationBtn];
    
    
    //设置控件的位置和大小
    CGFloat space = 10.0;
    CGFloat commWidth = viewSize.width - 2 * leftRightSpace;
    UILabel *phoneNumVerificationLabel = nil;
    CGSize phoneNumVerificationLabelSize;
    
    CGFloat phoneNumVerificationLabelW = 0;
    CGFloat phoneNumVerificationLabelH = 0;
    CGFloat phoneNumVerificationLabelOX = 0;
    CGFloat phoneNumVerificationLabelOY = 0;
    
    CGFloat phoneNumVerificationTextFieldW = 0;
    CGFloat phoneNumVerificationTextFieldH = 0;
    CGFloat phoneNumVerificationTextFieldOX = 0;
    CGFloat phoneNumVerificationTextFieldOY = 0;
    
    CGFloat phoneNumLineViewW = viewSize.width - leftRightSpace;
    CGFloat phoneNumLineViewH = 1;
    
    UILabel *shortMsgVerificationLabel = nil;
    CGSize shortMsgVerificationLabelSize;
    
    CGFloat shortMsgVerificationLabelW = 0;
    CGFloat shortMsgVerificationLabelH = 0;
    CGFloat shortMsgVerificationLabelOX = 0;
    CGFloat shortMsgVerificationLabelOY = 0;
    
    CGFloat shortMsgVerificationTextFieldW = 0;
    CGFloat shortMsgVerificationTextFieldH = 0;
    CGFloat shortMsgVerificationTextFieldOX = 0;
    CGFloat shortMsgVerificationTextFieldOY = 0;
    
    CGSize shortMsgVerificationBtnSize = [shortMsgVerificationBtn.titleLabel.text sizeWithNSStringFont:shortMsgVerificationBtn.titleLabel.font];
    CGFloat shortMsgVerificationBtnW = shortMsgVerificationBtnSize.width + 5 * 2;
    CGFloat shortMsgVerificationBtnH = shortMsgVerificationBtnSize.height + 5 * 2;
    
    CGFloat shortMsgVerificationLineViewW = 1;
    CGFloat shortMsgVerificationLineViewH = shortMsgVerificationBtnH;
    
    if (_viewStyle ==   SmsAuthToolViewStyleYes) {
        phoneNumVerificationLabel = [[UILabel alloc] init];
        phoneNumVerificationLabel.textColor = titleColor;
        phoneNumVerificationLabel.font = [UIFont systemFontOfSize:labelTextSize];
        phoneNumVerificationLabel.text = @"+86";
        [phoneNumVerificationView addSubview:phoneNumVerificationLabel];
        
        //设置控件的位置和大小
        phoneNumVerificationLabelSize = [phoneNumVerificationLabel.text sizeWithNSStringFont:phoneNumVerificationLabel.font];
        
        phoneNumVerificationLabelW = phoneNumVerificationLabelSize.width;
        phoneNumVerificationLabelH = phoneNumVerificationLabelSize.height;
        phoneNumVerificationLabelOX = 0;
        phoneNumVerificationLabelOY = leftRightSpace;
        
        phoneNumVerificationLabel.frame = CGRectMake(phoneNumVerificationLabelOX, phoneNumVerificationLabelOY, phoneNumVerificationLabelW, phoneNumVerificationLabelH);
        
        phoneNumVerificationTextFieldW = commWidth - phoneNumVerificationLabelSize.width - space;
        phoneNumVerificationTextFieldOX = phoneNumVerificationLabelOX + phoneNumVerificationLabelW + space;
        
        shortMsgVerificationLabel = [[UILabel alloc] init];
        shortMsgVerificationLabel.textColor = titleColor;
        shortMsgVerificationLabel.font = [UIFont systemFontOfSize:labelTextSize];
        shortMsgVerificationLabel.text = @"验证码";
        [shortMsgVerificationView addSubview:shortMsgVerificationLabel];
        
        
        shortMsgVerificationLabelSize = [shortMsgVerificationLabel.text sizeWithNSStringFont:shortMsgVerificationLabel.font];
        
        shortMsgVerificationLabelW = shortMsgVerificationLabelSize.width;
        shortMsgVerificationLabelH = shortMsgVerificationLabelSize.height;
        shortMsgVerificationLabelOX = 0;
        shortMsgVerificationLabelOY = leftRightSpace;
        
        shortMsgVerificationLabel.frame = CGRectMake(shortMsgVerificationLabelOX, shortMsgVerificationLabelOY, shortMsgVerificationLabelW, shortMsgVerificationLabelH);
        
        shortMsgVerificationTextFieldW = commWidth - shortMsgVerificationLabelSize.width - space - shortMsgVerificationLineViewW - space - shortMsgVerificationBtnW - space;
        shortMsgVerificationTextFieldOX = shortMsgVerificationLabelOX + shortMsgVerificationLabelW + space;
    } else {
        phoneNumVerificationTextFieldW = commWidth;
        phoneNumVerificationTextFieldOX = 0;
        
        shortMsgVerificationTextFieldW = commWidth - shortMsgVerificationLineViewW - space - shortMsgVerificationBtnW - space;
        shortMsgVerificationTextFieldOX = 0;
    }
    
    
    CGSize phoneNumVerificationTextFieldSize = [phoneNumVerificationTextField sizeThatFits:CGSizeMake(phoneNumVerificationTextFieldW, MAXFLOAT)];
    
    phoneNumVerificationTextFieldH = phoneNumVerificationTextFieldSize.height;
    CGFloat phoneNumVerificationViewH = phoneNumVerificationTextFieldH + 2 * leftRightSpace;
    
    phoneNumVerificationTextFieldOY = (phoneNumVerificationViewH - phoneNumVerificationTextFieldH) / 2;
    
    phoneNumVerificationTextField.frame = CGRectMake(phoneNumVerificationTextFieldOX, phoneNumVerificationTextFieldOY, phoneNumVerificationTextFieldW, phoneNumVerificationTextFieldH);
    
    CGFloat phoneNumVerificationViewW = commWidth;
    CGFloat phoneNumVerificationViewOX = leftRightSpace;
    CGFloat phoneNumVerificationViewOY = 0;
    
    phoneNumVerificationView.frame = CGRectMake(phoneNumVerificationViewOX, phoneNumVerificationViewOY, phoneNumVerificationViewW, phoneNumVerificationViewH);
    
    CGFloat phoneNumLineViewOX = leftRightSpace;
    CGFloat phoneNumLineViewOY = phoneNumVerificationViewH;
    
    phoneNumLineView.frame = CGRectMake(phoneNumLineViewOX, phoneNumLineViewOY, phoneNumLineViewW, phoneNumLineViewH);
    
    CGSize shortMsgVerificationTextFieldSize = [shortMsgVerificationTextField sizeThatFits:CGSizeMake(shortMsgVerificationTextFieldW, MAXFLOAT)];
    
    shortMsgVerificationTextFieldH = shortMsgVerificationTextFieldSize.height;
    CGFloat shortMsgVerificationViewH = shortMsgVerificationTextFieldH + 2 * leftRightSpace;
    
    shortMsgVerificationTextFieldOY = (shortMsgVerificationViewH - shortMsgVerificationTextFieldH) / 2;
    
    shortMsgVerificationTextField.frame = CGRectMake(shortMsgVerificationTextFieldOX, shortMsgVerificationTextFieldOY, shortMsgVerificationTextFieldW, shortMsgVerificationTextFieldH);
    
    CGFloat shortMsgVerificationLineViewOX = shortMsgVerificationTextFieldOX + shortMsgVerificationTextFieldW + space;
    CGFloat shortMsgVerificationLineViewOY = (shortMsgVerificationViewH - shortMsgVerificationLineViewH) / 2;
    
    shortMsgVerificationLineView.frame = CGRectMake(shortMsgVerificationLineViewOX, shortMsgVerificationLineViewOY, shortMsgVerificationLineViewW,shortMsgVerificationLineViewH);
    
    CGFloat shortMsgVerificationBtnOX = shortMsgVerificationLineViewOX + shortMsgVerificationLineViewW + space;
    CGFloat shortMsgVerificationBtnOY = (shortMsgVerificationViewH - shortMsgVerificationBtnH) / 2;
    
    shortMsgVerificationBtn.frame = CGRectMake(shortMsgVerificationBtnOX, shortMsgVerificationBtnOY, shortMsgVerificationBtnW, shortMsgVerificationBtnH);
    
    CGFloat shortMsgVerificationViewW = commWidth;
    CGFloat shortMsgVerificationViewOX = leftRightSpace;
    CGFloat shortMsgVerificationViewOY = phoneNumLineViewOY + phoneNumLineViewH;
    
    shortMsgVerificationView.frame = CGRectMake(shortMsgVerificationViewOX, shortMsgVerificationViewOY, shortMsgVerificationViewW, shortMsgVerificationViewH);
    
    return shortMsgVerificationViewH + phoneNumVerificationViewH + phoneNumLineViewH;
}

@end
