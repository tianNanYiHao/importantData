//
//  QuestionAuthToolView.m
//  GroupDemo
//
//  Created by tianNanYiHao on 2017/4/8.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "QuestionAuthToolView.h"
#import "NSString+string.h"
#define portraitLineViewColor [UIColor colorWithRed:(237/255.0) green:(237/255.0) blue:(237/255.0) alpha:1.0]

#define landscapeLineViewColor [UIColor colorWithRed:(237/255.0) green:(237/255.0) blue:(237/255.0) alpha:1.0]

#define titleColor [UIColor colorWithRed:(20/255.0) green:(20/255.0) blue:(20/255.0) alpha:1.0]

#define textFiledColor [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:1.0]

#define pwdTextFieldTextColor [UIColor blackColor]

#define ColorHUI [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1.0]

@interface QuestionAuthToolView()
{
    
}
@property (nonatomic, assign) CGSize viewSize;
@property (nonatomic, assign) CGFloat leftRightSpace;
@property (nonatomic,assign)  CGFloat txtTextSize;
@property (nonatomic,assign)  CGFloat labelTextSize;
@property (nonatomic,assign)  CGFloat btnTextSize;
@end

@implementation QuestionAuthToolView

@synthesize viewSize;
@synthesize leftRightSpace;
@synthesize txtTextSize;
@synthesize labelTextSize;
@synthesize btnTextSize;
@synthesize miBaoTitleLabel;
@synthesize miBaobtn;
@synthesize miBaoTQuestionLabel;
@synthesize miBaoAnswerVerificationTextField;



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
    
    if (_viewStyle == QuestionAuthToolViewStyleYes) {
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


@end
