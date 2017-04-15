//
//  GroupView.m
//  sandbao
//
//  Created by blue sky on 2016/12/26.
//  Copyright © 2016年 sand. All rights reserved.
//

#import "GroupView.h"
#ifndef __IPHONE_5_0
#warning "This project uses features only available in iOS SDK 5.0 and later."
#endif

#ifdef __OBJC__
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>
#endif

#import <UIKit/UIKit.h>
//界面配置
#define controllerTop 64.00


// 判断是否为ipad
#define ipad ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(768, 1024), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断是否为ipad2
#define ipad2 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(768, 1024), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断是否为ipad3
#define ipad3 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1536, 2048), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断是否为ipad4
#define ipad4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1536, 2048), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断是否为air
#define air ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1536, 2048), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断是否为mini
#define mini ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(768, 1024), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断是否为mini2
#define mini2 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1536, 2048), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断是否为mini3
#define mini3 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1536, 2048), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断是否为mini4
#define mini4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1536, 2048), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断是否为pro
#define pro ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(2048, 2732), [[UIScreen mainScreen] currentMode].size) : NO)


// 判断是否为iPhone3g
#define iPhone3g ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] currentMode].size) : NO)
//// 判断是否为iPhone4
//#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
//// 判断是否为iPhone5
//#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
//// 判断是否为iPhone6
//#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) : NO)
//// 判断是否为iPhone6 plus
//#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)


#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))


// 判断是否为iPhone4
#define iPhone4 (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
// 判断是否为iPhone5
#define iPhone5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
// 判断是否为iPhone6
#define iPhone6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
// 判断是否为iPhone6 plus
#define iPhone6plus (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)


//限制身份证键盘输入
#define IDCardVerifi @"0987654321Xx"

//限制输入数字小数点
#define OnlyNumber_pointVerifi @"0987654321."

//限制输入纯数字
#define OnlyNumberVerifi @"0987654321"

//限制输入纯数字纯字母
#define OnlyNum_letterVerifi @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

//限制输入字母数字特殊字符
#define OnlyChineseCharacterVerifi @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789./*-+~!@#$%^&()_+-=,./;'[]{}:<>?`，。、？！‘“：；【】{}·~！……——“”.com.cn.net<>《》%﹪。？！、；#＠～:,!?.*|……·＊－＝﹤︳`∕"


#import "NSString+string.h"

#define portraitLineViewColor [UIColor colorWithRed:(237/255.0) green:(237/255.0) blue:(237/255.0) alpha:1.0]

#define landscapeLineViewColor [UIColor colorWithRed:(237/255.0) green:(237/255.0) blue:(237/255.0) alpha:1.0]

#define titleColor [UIColor colorWithRed:(20/255.0) green:(20/255.0) blue:(20/255.0) alpha:1.0]

#define textFiledColor [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:1.0]

#define pwdTextFieldTextColor [UIColor blackColor]

#define ColorHUI [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1.0]

@interface GroupView()

@property (nonatomic, assign) CGSize viewSize;
@property (nonatomic, assign) CGFloat leftRightSpace;
@property (nonatomic, assign) CGFloat labelTextSize;
@property (nonatomic, assign) CGFloat txtTextSize;
@property (nonatomic, assign) CGFloat btnTextSize;
@property (nonatomic, assign) CGFloat titleLabelTextSize;
@property (nonatomic, assign) CGFloat warnTitleLabelTextSize;
@property (nonatomic, assign) CGFloat inputTitleLabelTextSize;
@property (nonatomic, assign) CGFloat pwdTextFieldTextSize;

@property (strong, nonatomic) UITextField *pwdTextFieldOne, *pwdTextFieldTwo, *pwdTextFieldThree, *pwdTextFieldFour, *pwdTextFieldFive, *pwdTextFieldSix;

@property (strong, nonatomic) UIView *keyBoardView;
@property(nonatomic,strong) NSMutableArray * tempArray;
@property (nonatomic, strong) NSString *payPwd;

@end

@implementation GroupView


@synthesize viewSize;
@synthesize leftRightSpace;
@synthesize labelTextSize;
@synthesize txtTextSize;
@synthesize btnTextSize;
@synthesize titleLabelTextSize;
@synthesize warnTitleLabelTextSize;
@synthesize inputTitleLabelTextSize;
@synthesize pwdTextFieldTextSize;


@synthesize pwdTextFieldOne, pwdTextFieldTwo, pwdTextFieldThree, pwdTextFieldFour, pwdTextFieldFive, pwdTextFieldSix;

@synthesize keyBoardView;
@synthesize tempArray;
@synthesize payPwd;

@synthesize groupViewStyle;

@synthesize phoneNumVerificationTextField;

@synthesize loginPwdVerificationTextField;
@synthesize loginPwdVerificationBtn;

@synthesize shortMsgVerificationTextField;
@synthesize shortMsgVerificationBtn;

@synthesize pictureVerificationTextField;
@synthesize pictureVerificationBtn;

@synthesize realNameVerificationTextField;
@synthesize IDCardVerificationTextField;

@synthesize bankNameContentVerificationLabel;
@synthesize bankCardVerificationTextField;

@synthesize cvnVerificationTextField;
@synthesize expiryVerificationTextField;

@synthesize sandCardVerificationTextField;

@synthesize inputTitleLabel;

@synthesize miBaoTitleLabel;
@synthesize miBaobtn;
@synthesize miBaoTQuestionLabel;
@synthesize miBaoAnswerVerificationTextField;


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self initView:frame];
        viewSize = frame.size;
        leftRightSpace = 15;
        
        if (iPhone4 || iPhone5) {
            labelTextSize = 14-1;
            txtTextSize = 14-1;
            btnTextSize = 16-1;
            titleLabelTextSize = 20-1;
            warnTitleLabelTextSize = 14-1;
            inputTitleLabelTextSize = 14-1;
            pwdTextFieldTextSize = 14-1;
        } else if (iPhone6) {
            labelTextSize = 17-1;
            txtTextSize = 17-1;
            btnTextSize = 18-1;
            titleLabelTextSize = 23-1;
            warnTitleLabelTextSize = 17-1;
            inputTitleLabelTextSize = 17-1;
            pwdTextFieldTextSize = 17-1;
        } else {
            labelTextSize = 20-1;
            txtTextSize = 20-1;
            btnTextSize = 20-1;
            titleLabelTextSize = 26-1;
            warnTitleLabelTextSize = 20-1;
            inputTitleLabelTextSize = 20-1;
            pwdTextFieldTextSize = 20-1;
        }
        
    }
    
    return self;
}

- (void)initView:(CGRect)frame
{
    
}

- (void)loadView:(NSMutableArray *)paramArray
{
    CGFloat commWdith = 0;
    CGFloat commHeight = 0;
    NSUInteger paramArrayCount = [paramArray count];
    for (int i = 0; i < paramArrayCount; i++) {
        NSMutableDictionary *dic = paramArray[i];
        NSString *type = [dic objectForKey:@"type"];
        if ([@"sms" isEqualToString:type]) {
            
            CGFloat phoneHeight = [self phoneNumVerification];
            CGFloat shortMsgHeight = [self shortMsgVerification];
            
            commHeight = phoneHeight + shortMsgHeight;
        } else if ([@"短信验证码" isEqualToString:type]) {
            CGFloat shortMsgHeight = [self pictureVerification];
            
            CGFloat shortMsgOY = commHeight;
            
            commHeight = commHeight + shortMsgHeight;
        }else if ([@"图片验证码" isEqualToString:type]) {
            commHeight = commHeight + 15;
        }else if ([@"银行" isEqualToString:type]) {
            commHeight = commHeight + 15;
        }else if ([@"身份证" isEqualToString:type]) {
            commHeight = commHeight + 15;
        } else {
            commHeight = commHeight + 15;
        }
    }
}

/**
 *@brief 手机号验证
 *@return CGFloat
 */
- (CGFloat)phoneNumVerification
{
    UIView *phoneNumVerificationView = [[UIView alloc] init];
    phoneNumVerificationView.backgroundColor = [UIColor clearColor];
    [self addSubview:phoneNumVerificationView];
    
    phoneNumVerificationTextField = [[UITextField alloc] init];
    phoneNumVerificationTextField .textColor = textFiledColor;
    phoneNumVerificationTextField.font = [UIFont systemFontOfSize:txtTextSize];
    phoneNumVerificationTextField.placeholder = @"请输入11位数字手机号";
    [phoneNumVerificationView addSubview:phoneNumVerificationTextField];
    
    
    //设置控件的位置和大小
    CGFloat space = 10.0;
    CGFloat commWidth = viewSize.width - leftRightSpace * 2;
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
    
    if (groupViewStyle == GroupViewStyleYes) {
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
    } else {
        phoneNumVerificationTextFieldW = commWidth;
        phoneNumVerificationTextFieldOX = 0;
    }
    
    
    CGSize phoneNumVerificationTextFieldSize = [phoneNumVerificationTextField sizeThatFits:CGSizeMake(phoneNumVerificationTextFieldW, MAXFLOAT)];
    
    
    phoneNumVerificationTextFieldH = phoneNumVerificationTextFieldSize.height;
    phoneNumVerificationTextFieldOY = leftRightSpace;
    
    phoneNumVerificationTextField.frame = CGRectMake(phoneNumVerificationTextFieldOX, phoneNumVerificationTextFieldOY, phoneNumVerificationTextFieldW, phoneNumVerificationTextFieldH);
    
    CGFloat phoneNumVerificationViewW = commWidth;
    CGFloat phoneNumVerificationViewH = phoneNumVerificationTextFieldH + 2 * leftRightSpace;
    CGFloat phoneNumVerificationViewOX = leftRightSpace;
    CGFloat phoneNumVerificationViewOY = 0;
    
    phoneNumVerificationView.frame = CGRectMake(phoneNumVerificationViewOX, phoneNumVerificationViewOY, phoneNumVerificationViewW, phoneNumVerificationViewH);
    
    return phoneNumVerificationViewH;
}

/**
 *@brief 密保验证
 *@return CGFloat
 */
- (CGFloat)miBaoQuestionVerification
{
    UIView *miBaoTitleVerificationView = [[UIView alloc] init];
    miBaoTitleVerificationView.backgroundColor = [UIColor colorWithRed:(242/255.0) green:(242/255.0) blue:(242/255.0) alpha:1.0];
    [self addSubview:miBaoTitleVerificationView];
    
    miBaoTitleLabel = [[UILabel alloc] init];
    miBaoTitleLabel.textColor = titleColor;
    miBaoTitleLabel.font = [UIFont systemFontOfSize:labelTextSize];
    miBaoTitleLabel.text = @"密保问题";
    [miBaoTitleVerificationView addSubview:miBaoTitleLabel];
    
    miBaobtn = [[UIButton alloc] init];
    [miBaobtn setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:miBaobtn];
    
    miBaoTQuestionLabel = [[UILabel alloc] init];
    miBaoTQuestionLabel.textColor = textFiledColor;
    miBaoTQuestionLabel.font = [UIFont systemFontOfSize:labelTextSize];
    miBaoTQuestionLabel.text = @"问题";
    [miBaobtn addSubview:miBaoTQuestionLabel];
    
    UIImage *arrowImage = [UIImage imageNamed:@"jt.png"];
    UIImageView *arrowImageView = [[UIImageView alloc] init];
    arrowImageView.image = arrowImage;
    arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
    [miBaobtn addSubview:arrowImageView];
    
    UIView *miBaobtnLineView = [[UIView alloc] init];
    miBaobtnLineView.backgroundColor = landscapeLineViewColor;
    [self addSubview:miBaobtnLineView];
    
    UIView *miBaoAnswerVerificationView = [[UIView alloc] init];
    miBaoAnswerVerificationView.backgroundColor = [UIColor clearColor];
    [self addSubview:miBaoAnswerVerificationView];
    
    miBaoAnswerVerificationTextField = [[UITextField alloc] init];
    miBaoAnswerVerificationTextField .textColor = textFiledColor;
    miBaoAnswerVerificationTextField.font = [UIFont systemFontOfSize:txtTextSize];
    miBaoAnswerVerificationTextField.placeholder = @"请输入答案";
    [miBaoAnswerVerificationView addSubview:miBaoAnswerVerificationTextField];
    
    //设置控件的位置和大小
    CGFloat space = 10.0;
    CGFloat upDownSpace = 10;
    CGFloat commWidth = viewSize.width - leftRightSpace * 2;
    
    CGSize miBaoTitleLabelSize = [miBaoTQuestionLabel sizeThatFits:CGSizeMake(commWidth, MAXFLOAT)];
    
    CGFloat miBaoTitleVerificationViewOX = 0;
    CGFloat miBaoTitleVerificationViewOY = 0;
    CGFloat miBaoTitleVerificationViewW = viewSize.width;
    CGFloat miBaoTitleVerificationViewH = miBaoTitleLabelSize.height + 2 * upDownSpace;
    
    miBaoTitleVerificationView.frame = CGRectMake(miBaoTitleVerificationViewOX, miBaoTitleVerificationViewOY, miBaoTitleVerificationViewW, miBaoTitleVerificationViewH);
    
    
    CGFloat miBaoTitleLabelOX = leftRightSpace;
    CGFloat miBaoTitleLabelOY = upDownSpace;
    CGFloat miBaoTitleLabelW = commWidth;
    CGFloat miBaoTitleLabelH = miBaoTitleLabelSize.height;
    
    miBaoTitleLabel.frame = CGRectMake(miBaoTitleLabelOX, miBaoTitleLabelOY, miBaoTitleLabelW, miBaoTitleLabelH);
    
    
    CGFloat miBaoTQuestionLabelW = commWidth - arrowImage.size.width - space;
    CGSize miBaoTQuestionLabelSize = [miBaoTQuestionLabel sizeThatFits:CGSizeMake(miBaoTQuestionLabelW, MAXFLOAT)];
    
    CGFloat miBaobtnOX = 0;
    CGFloat miBaobtnOY = miBaoTitleVerificationViewOY + miBaoTitleVerificationViewH;
    CGFloat miBaobtnW = viewSize.width;
    CGFloat miBaobtnH = miBaoTQuestionLabelSize.height + 2 * upDownSpace;
    
    miBaobtn.frame = CGRectMake(miBaobtnOX, miBaobtnOY, miBaobtnW, miBaobtnH);
    
    
    
    
    CGFloat miBaoTQuestionLabelOX = leftRightSpace;
    CGFloat miBaoTQuestionLabelOY = upDownSpace;
    CGFloat miBaoTQuestionLabelH = miBaoTQuestionLabelSize.height;
    
    miBaoTQuestionLabel.frame = CGRectMake(miBaoTQuestionLabelOX, miBaoTQuestionLabelOY, miBaoTQuestionLabelW, miBaoTQuestionLabelH);
    
    
    CGFloat arrowImageViewOX = miBaoTQuestionLabelOX + miBaoTQuestionLabelW + space;
    CGFloat arrowImageViewOY = (miBaobtnH - arrowImage.size.height) / 2;
    CGFloat arrowImageViewW = arrowImage.size.width;
    CGFloat arrowImageViewH = arrowImage.size.height;
    
    arrowImageView.frame = CGRectMake(arrowImageViewOX, arrowImageViewOY, arrowImageViewW, arrowImageViewH);
    
    CGFloat miBaobtnLineViewOX = leftRightSpace;
    CGFloat miBaobtnLineViewOY = miBaobtnOY + miBaobtnH;
    CGFloat miBaobtnLineViewW = viewSize.width - leftRightSpace;
    CGFloat miBaobtnLineViewH = 1;
    
    miBaobtnLineView.frame = CGRectMake(miBaobtnLineViewOX, miBaobtnLineViewOY, miBaobtnLineViewW, miBaobtnLineViewH);
    
    
    UILabel *miBaoAnswerVerificationLabel = nil;
    CGSize miBaoAnswerVerificationLabelSize;
    
    CGFloat miBaoAnswerVerificationLabelW = 0;
    CGFloat miBaoAnswerVerificationLabelH = 0;
    CGFloat miBaoAnswerVerificationLabelOX = 0;
    CGFloat miBaoAnswerVerificationLabelOY = 0;
    
    CGFloat miBaoAnswerVerificationTextFieldW = 0;
    CGFloat miBaoAnswerVerificationTextFieldH = 0;
    CGFloat miBaoAnswerVerificationTextFieldOX = 0;
    CGFloat miBaoAnswerVerificationTextFieldOY = 0;
    
    if (groupViewStyle == GroupViewStyleYes) {
        miBaoAnswerVerificationLabel = [[UILabel alloc] init];
        miBaoAnswerVerificationLabel.textColor = titleColor;
        miBaoAnswerVerificationLabel.font = [UIFont systemFontOfSize:labelTextSize];
        miBaoAnswerVerificationLabel.text = @"答案：";
        [miBaoAnswerVerificationView addSubview:miBaoAnswerVerificationLabel];
        
        //设置控件的位置和大小
        miBaoAnswerVerificationLabelSize = [miBaoAnswerVerificationLabel.text sizeWithNSStringFont:miBaoAnswerVerificationLabel.font];
        
        miBaoAnswerVerificationLabelW = miBaoAnswerVerificationLabelSize.width;
        miBaoAnswerVerificationLabelH = miBaoAnswerVerificationLabelSize.height;
        miBaoAnswerVerificationLabelOX = leftRightSpace;
        miBaoAnswerVerificationLabelOY = upDownSpace;
        
        miBaoAnswerVerificationLabel.frame = CGRectMake(miBaoAnswerVerificationLabelOX, miBaoAnswerVerificationLabelOY, miBaoAnswerVerificationLabelW, miBaoAnswerVerificationLabelH);
        
        miBaoAnswerVerificationTextFieldW = commWidth - miBaoAnswerVerificationLabelSize.width - space;
        miBaoAnswerVerificationTextFieldOX = miBaoAnswerVerificationLabelOX + miBaoAnswerVerificationLabelW + space;
    } else {
        miBaoAnswerVerificationTextFieldW = commWidth;
        miBaoAnswerVerificationTextFieldOX = leftRightSpace;
    }
    
    
    CGSize phoneNumVerificationTextFieldSize = [miBaoAnswerVerificationTextField sizeThatFits:CGSizeMake(miBaoAnswerVerificationTextFieldW, MAXFLOAT)];
    
    
    miBaoAnswerVerificationTextFieldH = phoneNumVerificationTextFieldSize.height;
    miBaoAnswerVerificationTextFieldOY = upDownSpace;
    
    miBaoAnswerVerificationTextField.frame = CGRectMake(miBaoAnswerVerificationTextFieldOX, miBaoAnswerVerificationTextFieldOY, miBaoAnswerVerificationTextFieldW, miBaoAnswerVerificationTextFieldH);
    
    CGFloat miBaoAnswerVerificationViewW = viewSize.width;
    CGFloat miBaoAnswerVerificationViewH = miBaoAnswerVerificationTextFieldH + 2 * upDownSpace;
    CGFloat miBaoAnswerVerificationViewOX = 0;
    CGFloat miBaoAnswerVerificationViewOY = miBaobtnLineViewOY + miBaobtnLineViewH;
    
    miBaoAnswerVerificationView.frame = CGRectMake(miBaoAnswerVerificationViewOX, miBaoAnswerVerificationViewOY, miBaoAnswerVerificationViewW, miBaoAnswerVerificationViewH);
    
    return miBaoTitleVerificationViewH + miBaobtnH + miBaobtnLineViewH + miBaoAnswerVerificationViewH;
}

/**
 *@brief 登录密码验证
 *@return CGFloat
 */
- (CGFloat)loginPwdVerification
{
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
    CGFloat space = 10.0;
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
    
    if (groupViewStyle == GroupViewStyleYes) {
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
    CGFloat loginPwdVerificationViewOY = 0;
    
    loginPwdVerificationView.frame = CGRectMake(loginPwdVerificationViewOX, loginPwdVerificationViewOY, loginPwdVerificationViewW, loginPwdVerificationViewH);
    
    return loginPwdVerificationViewH;
}

/**
 *@brief 短信验证
 *@return CGFloat
 */
- (CGFloat)shortMsgVerification
{
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
    CGFloat commWidth = viewSize.width - leftRightSpace * 2;
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
    
    if (groupViewStyle == GroupViewStyleYes) {
        shortMsgVerificationLabel = [[UILabel alloc] init];
        shortMsgVerificationLabel.textColor = titleColor;
        shortMsgVerificationLabel.font = [UIFont systemFontOfSize:labelTextSize];
        shortMsgVerificationLabel.text = @"验证码";
        [shortMsgVerificationView addSubview:shortMsgVerificationLabel];
        
        //设置控件的位置和大小
        shortMsgVerificationLabelSize = [shortMsgVerificationLabel.text sizeWithNSStringFont:shortMsgVerificationLabel.font];
        
        shortMsgVerificationLabelW = shortMsgVerificationLabelSize.width;
        shortMsgVerificationLabelH = shortMsgVerificationLabelSize.height;
        shortMsgVerificationLabelOX = 0;
        shortMsgVerificationLabelOY = leftRightSpace;
        
        shortMsgVerificationLabel.frame = CGRectMake(shortMsgVerificationLabelOX, shortMsgVerificationLabelOY, shortMsgVerificationLabelW, shortMsgVerificationLabelH);
        
        shortMsgVerificationTextFieldW = commWidth - shortMsgVerificationLabelSize.width - space - shortMsgVerificationLineViewW - space - shortMsgVerificationBtnW - space;
        shortMsgVerificationTextFieldOX = shortMsgVerificationLabelOX + shortMsgVerificationLabelW + space;
    } else {
        shortMsgVerificationTextFieldW = commWidth - shortMsgVerificationLineViewW - space - shortMsgVerificationBtnW - space;
        shortMsgVerificationTextFieldOX = 0;
    }
    
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
    CGFloat shortMsgVerificationViewOY = 0;
    
    shortMsgVerificationView.frame = CGRectMake(shortMsgVerificationViewOX, shortMsgVerificationViewOY, shortMsgVerificationViewW, shortMsgVerificationViewH);
    
    return shortMsgVerificationViewH;
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
    
    if (groupViewStyle == GroupViewStyleYes) {
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

/**
 *@brief 图片验证
 *@return CGFloat
 */
- (CGFloat)pictureVerification
{
    UIView *pictureVerificationView = [[UIView alloc] init];
    pictureVerificationView.backgroundColor = [UIColor clearColor];
    [self addSubview:pictureVerificationView];
    
    pictureVerificationTextField = [[UITextField alloc] init];
    pictureVerificationTextField .textColor = textFiledColor;
    pictureVerificationTextField.font = [UIFont systemFontOfSize:txtTextSize];
    pictureVerificationTextField.placeholder = @"请输入图片上内容";
    [pictureVerificationView addSubview:pictureVerificationTextField];
    
    pictureVerificationBtn = [[UIButton alloc] init];
    pictureVerificationBtn.contentMode = UIViewContentModeScaleAspectFit;
    [pictureVerificationView addSubview:pictureVerificationBtn];
    
    //设置控件的位置和大小
    CGFloat space = 10.0;
    CGFloat commWidth = viewSize.width - leftRightSpace * 2;
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
    
    if (groupViewStyle == GroupViewStyleYes) {
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
    CGFloat pictureVerificationViewOY = 0;
    
    pictureVerificationView.frame = CGRectMake(pictureVerificationViewOX, pictureVerificationViewOY, pictureVerificationViewW, pictureVerificationViewH);
    
    return pictureVerificationViewH;
}

/**
 *@brief 身份证验证
 *@return CGFloat
 */
- (CGFloat)IDCardVerification
{
    UIView *IDCardVerificationView = [[UIView alloc] init];
    IDCardVerificationView.backgroundColor = [UIColor clearColor];
    [self addSubview:IDCardVerificationView];
    
    IDCardVerificationTextField = [[UITextField alloc] init];
    IDCardVerificationTextField .textColor = textFiledColor;
    IDCardVerificationTextField.font = [UIFont systemFontOfSize:txtTextSize];
    IDCardVerificationTextField.placeholder = @"请输入身份证号码";
    [IDCardVerificationView addSubview:IDCardVerificationTextField];
    
    
    //设置控件的位置和大小
    CGFloat space = 10.0;
    CGFloat commWidth = viewSize.width - leftRightSpace * 2;
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
    
    if (groupViewStyle == GroupViewStyleYes) {
        IDCardVerificationLabel = [[UILabel alloc] init];
        IDCardVerificationLabel.textColor = titleColor;
        IDCardVerificationLabel.font = [UIFont systemFontOfSize:labelTextSize];
        IDCardVerificationLabel.text = @"身份证：";
        [IDCardVerificationView addSubview:IDCardVerificationLabel];
        
        //设置控件的位置和大小
        IDCardVerificationLabelSize = [IDCardVerificationLabel.text sizeWithNSStringFont:IDCardVerificationLabel.font];
        
        IDCardVerificationLabelW = IDCardVerificationLabelSize.width;
        IDCardVerificationLabelH = IDCardVerificationLabelSize.height;
        IDCardVerificationLabelOX = 0;
        IDCardVerificationLabelOY = leftRightSpace;
        
        IDCardVerificationLabel.frame = CGRectMake(IDCardVerificationLabelOX, IDCardVerificationLabelOY, IDCardVerificationLabelW, IDCardVerificationLabelH);
        
        IDCardVerificationTextFieldW = commWidth - IDCardVerificationLabelSize.width - space;
        IDCardVerificationTextFieldOX = IDCardVerificationLabelOX + IDCardVerificationLabelW + space;
    } else {
        IDCardVerificationTextFieldW = commWidth;
        IDCardVerificationTextFieldOX = 0;
    }
    
    
    CGSize IDCardVerificationTextFieldSize = [IDCardVerificationTextField sizeThatFits:CGSizeMake(IDCardVerificationTextFieldW, MAXFLOAT)];
    
    
    IDCardVerificationTextFieldH = IDCardVerificationTextFieldSize.height;
    IDCardVerificationTextFieldOY = leftRightSpace;
    
    IDCardVerificationTextField.frame = CGRectMake(IDCardVerificationTextFieldOX, IDCardVerificationTextFieldOY, IDCardVerificationTextFieldW, IDCardVerificationTextFieldH);
    
    CGFloat IDCardVerificationViewW = commWidth;
    CGFloat IDCardVerificationViewH = IDCardVerificationTextFieldH + 2 * leftRightSpace;
    CGFloat IDCardVerificationViewOX = leftRightSpace;
    CGFloat IDCardVerificationViewOY = 0;
    
    IDCardVerificationView.frame = CGRectMake(IDCardVerificationViewOX, IDCardVerificationViewOY, IDCardVerificationViewW, IDCardVerificationViewH);
    
    return IDCardVerificationViewH;
}

/**
 *@brief 真实姓名+身份证 验证
 *@return CGFloat
 */
- (CGFloat)realNameAndIDCardVerification
{
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
    
    IDCardVerificationTextField = [[UITextField alloc] init];
    IDCardVerificationTextField .textColor = textFiledColor;
    IDCardVerificationTextField.font = [UIFont systemFontOfSize:txtTextSize];
    IDCardVerificationTextField.placeholder = @"请输入身份证号码";
    [IDCardVerificationView addSubview:IDCardVerificationTextField];
    
    
    //设置控件的位置和大小
    CGFloat space = 10.0;
    CGFloat commWidth = viewSize.width - 2 * leftRightSpace;
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
    
    if (groupViewStyle == GroupViewStyleYes) {
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
    CGFloat realNameVerificationViewOY = 0;
    
    realNameVerificationView.frame = CGRectMake(realNameVerificationViewOX, realNameVerificationViewOY, realNameVerificationViewW, realNameVerificationViewH);
    
    CGFloat realNameLineViewOX = leftRightSpace;
    CGFloat realNameLineViewOY = realNameVerificationViewH;
    
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
    
    return IDCardVerificationViewH + realNameVerificationViewH + realNameLineViewH;
}

/**
 *@brief 银行卡验证
 *@return CGFloat
 */
- (CGFloat)bankCardVerification
{
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
    
    bankCardVerificationTextField = [[UITextField alloc] init];
    bankCardVerificationTextField .textColor = textFiledColor;
    bankCardVerificationTextField.font = [UIFont systemFontOfSize:txtTextSize];
    bankCardVerificationTextField.placeholder = @"请输入银行卡号码";
    [bankCardVerificationView addSubview:bankCardVerificationTextField];
    
    
    //设置控件的位置和大小
    CGFloat space = 10.0;
    CGFloat commWidth = viewSize.width - leftRightSpace * 2;
    UILabel *bankCardVerificationLabel = nil;
    CGSize bankCardVerificationLabelSize;
    
    CGSize bankNameVerificationLabelSize = [bankNameVerificationLabel.text sizeWithNSStringFont:bankNameVerificationLabel.font];
    
    CGFloat bankNameContentVerificationLabelW = commWidth - space - bankNameVerificationLabelSize.width;
    CGSize bankNameContentVerificationLabelSize = [bankCardVerificationTextField sizeThatFits:CGSizeMake(bankNameContentVerificationLabelW, MAXFLOAT)];
    
    CGFloat bankNameVerificationViewW = commWidth;
    CGFloat bankNameVerificationViewH = bankNameContentVerificationLabelSize.height + 2 * leftRightSpace;
    CGFloat bankNameVerificationViewOX = leftRightSpace;
    CGFloat bankNameVerificationViewOY = 0;
    
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
    
    if (groupViewStyle == GroupViewStyleYes) {
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
    
    return bankNameVerificationViewH + bankNameLineViewH + bankCardVerificationViewH;
}

/**
 *@brief 信用卡验证
 *@return CGFloat
 */
- (CGFloat)creditCardVerification
{
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
    
    expiryVerificationTextField = [[UITextField alloc] init];
    expiryVerificationTextField .textColor = textFiledColor;
    expiryVerificationTextField.font = [UIFont systemFontOfSize:txtTextSize];
    expiryVerificationTextField.placeholder = @"信用卡上面的有效期";
    [expiryVerificationView addSubview:expiryVerificationTextField];
    
    
    //设置控件的位置和大小
    CGFloat space = 10.0;
    CGFloat commWidth = viewSize.width - 2 * leftRightSpace;
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
    
    if (groupViewStyle == GroupViewStyleYes) {
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
    CGFloat cvnVerificationViewOY = 0;
    
    cvnVerificationView.frame = CGRectMake(cvnVerificationViewOX, cvnVerificationViewOY, cvnVerificationViewW, cvnVerificationViewH);
    
    CGFloat cvnLineViewOX = leftRightSpace;
    CGFloat cvnLineViewOY = cvnVerificationViewH;
    
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
    
    return expiryVerificationViewH + cvnVerificationViewH + cvnLineViewH;
}

/**
 *@brief 杉德卡验证
 *@return CGFloat
 */
- (CGFloat)sandCardVerification
{
    UIView *sandCardVerificationView = [[UIView alloc] init];
    sandCardVerificationView.backgroundColor = [UIColor clearColor];
    [self addSubview:sandCardVerificationView];
    
    sandCardVerificationTextField = [[UITextField alloc] init];
    sandCardVerificationTextField .textColor = textFiledColor;
    sandCardVerificationTextField.font = [UIFont systemFontOfSize:txtTextSize];
    sandCardVerificationTextField.placeholder = @"请输入杉德卡6位校验码";
    [sandCardVerificationView addSubview:sandCardVerificationTextField];
    
    
    //设置控件的位置和大小
    CGFloat space = 10.0;
    CGFloat commWidth = viewSize.width - leftRightSpace * 2;
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
    
    if (groupViewStyle == GroupViewStyleYes) {
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
    CGFloat sandCardVerificationViewOY = 0;
    
    sandCardVerificationView.frame = CGRectMake(sandCardVerificationViewOX, sandCardVerificationViewOY, sandCardVerificationViewW, sandCardVerificationViewH);
    
    return sandCardVerificationViewH;
}

/**
 *@brief 支付密码验证
 *@return CGFloat
 */
- (CGFloat)payPwdVerification
{
    
    CGFloat pwdTextFieldBorderWidth = 1;
    CGFloat allPwdTextFieldBorderWidth = 1 * 5;
    
    UIView *payPwdVerificationView = [[UIView alloc] init];
    payPwdVerificationView.backgroundColor = [UIColor clearColor];
    [self addSubview:payPwdVerificationView];
    
    //  title
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"设置支付密码";
    titleLabel.textColor = textFiledColor;
    titleLabel.font = [UIFont systemFontOfSize:titleLabelTextSize weight:2];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [payPwdVerificationView addSubview:titleLabel];
    
    //  提醒
    UILabel *warnTitleLabel = [[UILabel alloc] init];
    warnTitleLabel.text = @"支付密码保障交易安全，请勿泄露牢记";
    warnTitleLabel.textColor = [UIColor grayColor];
    warnTitleLabel.font = [UIFont systemFontOfSize:warnTitleLabelTextSize];
    warnTitleLabel.textAlignment = NSTextAlignmentCenter;
    [payPwdVerificationView addSubview:warnTitleLabel];
    
    //  输入提示
    inputTitleLabel = [[UILabel alloc] init];
    inputTitleLabel.text = @"请输入支付密码";
    inputTitleLabel.textColor = textFiledColor;
    inputTitleLabel.font = [UIFont systemFontOfSize:inputTitleLabelTextSize];
    inputTitleLabel.textAlignment = NSTextAlignmentCenter;
    [payPwdVerificationView addSubview:inputTitleLabel];
    
    //输入框区域
    pwdTextFieldOne = [[UITextField alloc] init];
    pwdTextFieldOne.textAlignment= NSTextAlignmentCenter;
    pwdTextFieldOne.textColor= pwdTextFieldTextColor;
    [pwdTextFieldOne setSecureTextEntry:YES];
    pwdTextFieldOne.font= [UIFont systemFontOfSize:pwdTextFieldTextSize];
    pwdTextFieldOne.layer.borderWidth= pwdTextFieldBorderWidth;
    [pwdTextFieldOne setEnabled:NO];
    pwdTextFieldOne.layer.borderColor=[ColorHUI CGColor];
    [payPwdVerificationView addSubview:pwdTextFieldOne];
    
    pwdTextFieldTwo = [[UITextField alloc] init];
    pwdTextFieldTwo.textAlignment= NSTextAlignmentCenter;
    pwdTextFieldTwo.textColor= pwdTextFieldTextColor;
    [pwdTextFieldTwo setSecureTextEntry:YES];
    pwdTextFieldTwo.font= [UIFont systemFontOfSize:pwdTextFieldTextSize];
    pwdTextFieldTwo.layer.borderWidth= pwdTextFieldBorderWidth;
    [pwdTextFieldTwo setEnabled:NO];
    pwdTextFieldTwo.layer.borderColor=[ColorHUI CGColor];
    [payPwdVerificationView addSubview:pwdTextFieldTwo];
    
    
    pwdTextFieldThree = [[UITextField alloc] init];
    pwdTextFieldThree.textAlignment= NSTextAlignmentCenter;
    pwdTextFieldThree.textColor= pwdTextFieldTextColor;
    [pwdTextFieldThree setSecureTextEntry:YES];
    pwdTextFieldThree.font= [UIFont systemFontOfSize:pwdTextFieldTextSize];
    pwdTextFieldThree.layer.borderWidth= pwdTextFieldBorderWidth;
    [pwdTextFieldThree setEnabled:NO];
    pwdTextFieldThree.layer.borderColor=[ColorHUI CGColor];
    [payPwdVerificationView addSubview:pwdTextFieldThree];
    
    pwdTextFieldFour = [[UITextField alloc] init];
    pwdTextFieldFour.textAlignment= NSTextAlignmentCenter;
    pwdTextFieldFour.textColor= pwdTextFieldTextColor;
    [pwdTextFieldFour setSecureTextEntry:YES];
    pwdTextFieldFour.font= [UIFont systemFontOfSize:pwdTextFieldTextSize];
    pwdTextFieldFour.layer.borderWidth= pwdTextFieldBorderWidth;
    [pwdTextFieldFour setEnabled:NO];
    pwdTextFieldFour.layer.borderColor=[ColorHUI CGColor];
    [payPwdVerificationView addSubview:pwdTextFieldFour];
    
    pwdTextFieldFive = [[UITextField alloc] init];
    pwdTextFieldFive.textAlignment= NSTextAlignmentCenter;
    pwdTextFieldFive.textColor= pwdTextFieldTextColor;
    [pwdTextFieldFive setSecureTextEntry:YES];
    pwdTextFieldFive.font= [UIFont systemFontOfSize:pwdTextFieldTextSize];
    pwdTextFieldFive.layer.borderWidth= pwdTextFieldBorderWidth;
    [pwdTextFieldFive setEnabled:NO];
    pwdTextFieldFive.layer.borderColor=[ColorHUI CGColor];
    [payPwdVerificationView addSubview:pwdTextFieldFive];
    
    pwdTextFieldSix = [[UITextField alloc] init];
    pwdTextFieldSix.textAlignment= NSTextAlignmentCenter;
    pwdTextFieldSix.textColor= pwdTextFieldTextColor;
    [pwdTextFieldSix setSecureTextEntry:YES];
    pwdTextFieldSix.font= [UIFont systemFontOfSize:pwdTextFieldTextSize];
    pwdTextFieldSix.layer.borderWidth= pwdTextFieldBorderWidth;
    [pwdTextFieldSix setEnabled:NO];
    pwdTextFieldSix.layer.borderColor=[ColorHUI CGColor];
    [payPwdVerificationView addSubview:pwdTextFieldSix];
    
    //设置控件的位置和大小
    CGFloat commWidth = viewSize.width - 2 * leftRightSpace;
    
    CGFloat payPwdVerificationViewW = viewSize.width;
    CGFloat payPwdVerificationViewH = viewSize.height;
    CGFloat payPwdVerificationViewOX = 0;
    CGFloat payPwdVerificationViewOY = 0;
    
    payPwdVerificationView.frame = CGRectMake(payPwdVerificationViewOX, payPwdVerificationViewOY, payPwdVerificationViewW, payPwdVerificationViewH);
    
    CGSize titleLabelSize = [titleLabel sizeThatFits:CGSizeMake(commWidth, MAXFLOAT)];
    CGFloat titleLabelW = commWidth;
    CGFloat titleLabelH = titleLabelSize.height;
    CGFloat titleLabelOX = leftRightSpace;
    CGFloat titleLabelOY = 30;
    titleLabel.frame = CGRectMake(titleLabelOX, titleLabelOY, titleLabelW, titleLabelH);
    
    CGSize warnTitleLabelSize = [warnTitleLabel sizeThatFits:CGSizeMake(commWidth, MAXFLOAT)];
    CGFloat warnTitleLabelW = commWidth;
    CGFloat warnTitleLabelH = warnTitleLabelSize.height;
    CGFloat warnTitleLabelOX = leftRightSpace;
    CGFloat warnTitleLabelOY = titleLabelH + titleLabelOY + 20;
    warnTitleLabel.frame = CGRectMake(warnTitleLabelOX, warnTitleLabelOY, warnTitleLabelW, warnTitleLabelH);
    
    CGSize inputTitleLabelSize = [inputTitleLabel sizeThatFits:CGSizeMake(commWidth, MAXFLOAT)];
    CGFloat inputTitleLabelW = commWidth;
    CGFloat inputTitleLabelH = inputTitleLabelSize.height;
    CGFloat inputTitleLabelOX = leftRightSpace;
    CGFloat inputTitleLabelOY = warnTitleLabelH + warnTitleLabelOY + 40;
    inputTitleLabel.frame = CGRectMake(inputTitleLabelOX, inputTitleLabelOY, inputTitleLabelW, inputTitleLabelH);
    
    CGSize textFieldSize = [pwdTextFieldOne.text sizeWithNSStringFont:pwdTextFieldOne.font];
    CGFloat commTextFieldWidth = textFieldSize.width + 2 * 20;
    CGFloat commTextFieldHeight = textFieldSize.height + 2 * 15;
    
    CGFloat pwdTextFieldOneW = commTextFieldWidth;
    CGFloat pwdTextFieldOneH = commTextFieldHeight;
    CGFloat pwdTextFieldOneOX = (payPwdVerificationViewW - commTextFieldWidth * 6 + allPwdTextFieldBorderWidth) / 2;
    CGFloat pwdTextFieldOneOY = inputTitleLabelH + inputTitleLabelOY + 10;
    pwdTextFieldOne.frame = CGRectMake(pwdTextFieldOneOX, pwdTextFieldOneOY, pwdTextFieldOneW, pwdTextFieldOneH);
    
    CGFloat pwdTextFieldTwoW = commTextFieldWidth;
    CGFloat pwdTextFieldTwoH = commTextFieldHeight;
    CGFloat pwdTextFieldTwoOX = pwdTextFieldOneOX + pwdTextFieldOneW - pwdTextFieldBorderWidth;
    CGFloat pwdTextFieldTwoOY = inputTitleLabelH + inputTitleLabelOY + 10;
    pwdTextFieldTwo.frame = CGRectMake(pwdTextFieldTwoOX, pwdTextFieldTwoOY, pwdTextFieldTwoW, pwdTextFieldTwoH);
    
    CGFloat pwdTextFieldThreeW = commTextFieldWidth;
    CGFloat pwdTextFieldThreeH = commTextFieldHeight;
    CGFloat pwdTextFieldThreeOX = pwdTextFieldTwoOX + pwdTextFieldTwoW - pwdTextFieldBorderWidth;
    CGFloat pwdTextFieldThreeOY = inputTitleLabelH + inputTitleLabelOY + 10;
    pwdTextFieldThree.frame = CGRectMake(pwdTextFieldThreeOX, pwdTextFieldThreeOY, pwdTextFieldThreeW, pwdTextFieldThreeH);
    
    CGFloat pwdTextFieldFourW = commTextFieldWidth;
    CGFloat pwdTextFieldFourH = commTextFieldHeight;
    CGFloat pwdTextFieldFourOX = pwdTextFieldThreeOX + pwdTextFieldThreeW - pwdTextFieldBorderWidth;
    CGFloat pwdTextFieldFourOY = inputTitleLabelH + inputTitleLabelOY + 10;
    pwdTextFieldFour.frame = CGRectMake(pwdTextFieldFourOX, pwdTextFieldFourOY, pwdTextFieldFourW, pwdTextFieldFourH);
    
    CGFloat pwdTextFieldFiveW = commTextFieldWidth;
    CGFloat pwdTextFieldFiveH = commTextFieldHeight;
    CGFloat pwdTextFieldFiveOX = pwdTextFieldFourOX + pwdTextFieldFourW - pwdTextFieldBorderWidth;
    CGFloat pwdTextFieldFiveOY = inputTitleLabelH + inputTitleLabelOY + 10;
    pwdTextFieldFive.frame = CGRectMake(pwdTextFieldFiveOX, pwdTextFieldFiveOY, pwdTextFieldFiveW, pwdTextFieldFiveH);
    
    CGFloat pwdTextFieldSixW = commTextFieldWidth;
    CGFloat pwdTextFieldSixH = commTextFieldHeight;
    CGFloat pwdTextFieldSixOX = pwdTextFieldFiveOX + pwdTextFieldFiveW - pwdTextFieldBorderWidth;
    CGFloat pwdTextFieldSixOY = inputTitleLabelH + inputTitleLabelOY + 10;
    pwdTextFieldSix.frame = CGRectMake(pwdTextFieldSixOX, pwdTextFieldSixOY, pwdTextFieldSixW, pwdTextFieldSixH);
    
    
    keyBoardView = [[UIView alloc] init];
    keyBoardView.backgroundColor = [UIColor whiteColor];
    [payPwdVerificationView addSubview:keyBoardView];
    
    CGFloat keyBoardViewW = viewSize.width;
    CGFloat keyBoardViewH = 200;
    CGFloat keyBoardViewOX = 0;
    CGFloat keyBoardViewOY = viewSize.height - keyBoardViewH;
    keyBoardView.frame = CGRectMake(keyBoardViewOX, keyBoardViewOY, keyBoardViewW, keyBoardViewH);
    [self addKeyBoardBtn:keyBoardView];
    
    return payPwdVerificationViewH;
}

- (void)addKeyBoardBtn:(UIView *)view
{
    CGFloat btnWidth = view.frame.size.width / 3;
    CGFloat btnHeight = view.frame.size.height / 4;
    
    NSArray * ary =[[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0", nil];
    
    ary = [ary sortedArrayUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2){
        int seed = arc4random_uniform(2);
        
        if (seed) {
            return [str1 compare:str2];
        } else {
            return [str2 compare:str1];
        }
    }];
    NSMutableArray *newArray = [NSMutableArray arrayWithArray:ary];
    [newArray addObject:@"清除"];
    [newArray addObject:@"x"];
    
    tempArray = newArray;
    
    
    for(int i=0;i<tempArray.count;i++)
    {
        NSInteger index = i%3;
        NSInteger page = i/3;
        
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(index * btnWidth, page  * btnHeight, btnWidth, btnHeight);
        btn.tag=i;
        [btn setTitle:[tempArray objectAtIndex:i] forState:normal];
        [btn setTitleColor:textFiledColor forState:normal];
        btn.layer.borderColor=[ColorHUI CGColor];
        btn.layer.borderWidth=0.5;
        
        if(i<=9)
        {
            
            [btn addTarget:self action:@selector(KeyBoradClass:) forControlEvents:UIControlEventTouchUpInside];
        }
        if(i==10)
        {
            [btn addTarget:self action:@selector(KeyBoradClear:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        if(i==11)
        {
            [btn addTarget:self action:@selector(KeyBoradRemove:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        [view addSubview:btn];
    }
}

#pragma 输入密码
-(void)KeyBoradClass:(UIButton *)btn
{
    if (pwdTextFieldOne.text.length<1) {
        
        if (pwdTextFieldOne.text.length==0) {
            pwdTextFieldOne.text=[tempArray objectAtIndex:btn.tag];
        }
        
    }
    else if (pwdTextFieldTwo.text.length<1 && pwdTextFieldOne.text.length==1) {
        
        if (pwdTextFieldTwo.text.length==0) {
            pwdTextFieldTwo.text=[tempArray objectAtIndex:btn.tag];
        }
        
    }
    else if (pwdTextFieldThree.text.length<1 && pwdTextFieldTwo.text.length==1) {
        
        if (pwdTextFieldThree.text.length==0) {
            pwdTextFieldThree.text=[tempArray objectAtIndex:btn.tag];
        }
        
    }
    else if (pwdTextFieldFour.text.length<1 && pwdTextFieldThree.text.length==1) {
        
        if (pwdTextFieldFour.text.length==0) {
            pwdTextFieldFour.text=[tempArray objectAtIndex:btn.tag];
        }
        
    }
    else if (pwdTextFieldFive.text.length<1 && pwdTextFieldFour.text.length==1) {
        
        if (pwdTextFieldFive.text.length==0) {
            pwdTextFieldFive.text=[tempArray objectAtIndex:btn.tag];
        }
        
    }
    
    else if (pwdTextFieldSix.text.length<1 && pwdTextFieldFive.text.length==1) {
        
        if (pwdTextFieldSix.text.length==0) {
            pwdTextFieldSix.text=[tempArray objectAtIndex:btn.tag];
        }
    }
    
#pragma 密码输入己有6位
    
    payPwd = [NSString stringWithFormat:@"%@%@%@%@%@%@",pwdTextFieldOne.text,pwdTextFieldTwo.text,pwdTextFieldThree.text,pwdTextFieldFour.text,pwdTextFieldFive.text,pwdTextFieldSix.text];
    
    if(payPwd.length==6)
    {
        [self.delegate payPwd:payPwd];
    }
}

#pragma 清除
-(void)KeyBoradRemove:(UIButton *)btn
{
    
    if(payPwd.length==0)
    {
        pwdTextFieldOne.text=@"";
        pwdTextFieldTwo.text=@"";
        pwdTextFieldThree.text=@"";
        pwdTextFieldFour.text=@"";
        pwdTextFieldFive.text=@"";
        pwdTextFieldSix.text=@"";
        
        return;
    }
    
    
    NSString *str=[payPwd substringToIndex:payPwd.length-1];
    
    if(str.length==6)
    {
        
    }
    else if (str.length==5)
    {
        pwdTextFieldSix.text=@"";
        
    }
    else if(str.length==4)
    {
        pwdTextFieldFive.text=@"";
        pwdTextFieldSix.text=@"";
        
    }
    else if (str.length==3)
    {
        pwdTextFieldFour.text=@"";
        pwdTextFieldFive.text=@"";
        pwdTextFieldSix.text=@"";
    }
    else if(str.length==2)
    {
        pwdTextFieldThree.text=@"";
        pwdTextFieldFour.text=@"";
        pwdTextFieldFive.text=@"";
        pwdTextFieldSix.text=@"";
        
    }
    else if(str.length==1)
    {
        pwdTextFieldTwo.text=@"";
        pwdTextFieldThree.text=@"";
        pwdTextFieldFour.text=@"";
        pwdTextFieldFive.text=@"";
        pwdTextFieldSix.text=@"";
    }
    else
    {
        pwdTextFieldOne.text=@"";
        pwdTextFieldTwo.text=@"";
        pwdTextFieldThree.text=@"";
        pwdTextFieldFour.text=@"";
        pwdTextFieldFive.text=@"";
        pwdTextFieldSix.text=@"";
        
    }
    
    payPwd = str;
    
    //    NSLog(@"%@",payPwd);
    
}

#pragma 清空
-(void)KeyBoradClear:(UIButton *)btn{
    
    pwdTextFieldOne.text=@"";
    pwdTextFieldTwo.text=@"";
    pwdTextFieldThree.text=@"";
    pwdTextFieldFour.text=@"";
    pwdTextFieldFive.text=@"";
    pwdTextFieldSix.text=@"";
    
}

/**
 *@brief 清空支付密码
 */
- (void)clearPayPwd
{
    
    pwdTextFieldOne.text=@"";
    pwdTextFieldTwo.text=@"";
    pwdTextFieldThree.text=@"";
    pwdTextFieldFour.text=@"";
    pwdTextFieldFive.text=@"";
    pwdTextFieldSix.text=@"";
    
    [keyBoardView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self addKeyBoardBtn:keyBoardView];
}

@end
