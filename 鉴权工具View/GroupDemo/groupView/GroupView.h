//
//  GroupView.h
//  sandbao
//
//  Created by blue sky on 2016/12/26.
//  Copyright © 2016年 sand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef enum {
    GroupViewStyleNo,
    GroupViewStyleYes
}GroupViewStyle;

@protocol GroupViewDelegate <NSObject>

- (void)payPwd:(NSString *)param;

@end

@interface GroupView : UIView

@property (nonatomic, strong) id<GroupViewDelegate> delegate;

@property (nonatomic) GroupViewStyle groupViewStyle;

//手机号验证
@property (nonatomic, strong) UITextField *phoneNumVerificationTextField;

//登录密码验证
@property (nonatomic, strong) UITextField *loginPwdVerificationTextField;
@property (nonatomic, strong) UIButton *loginPwdVerificationBtn;

//短信验证
@property (nonatomic, strong) UITextField *shortMsgVerificationTextField;
@property (nonatomic, strong) UIButton *shortMsgVerificationBtn;

//图片验证
@property (nonatomic, strong) UITextField *pictureVerificationTextField;
@property (nonatomic, strong) UIButton *pictureVerificationBtn;

//身份证验证
@property (nonatomic, strong) UITextField *realNameVerificationTextField;
@property (nonatomic, strong) UITextField *IDCardVerificationTextField;

//银行卡验证
@property (nonatomic, strong) UILabel *bankNameContentVerificationLabel;
@property (nonatomic, strong) UITextField *bankCardVerificationTextField;

//信用卡验证
@property (nonatomic, strong) UITextField *cvnVerificationTextField;
@property (nonatomic, strong) UITextField *expiryVerificationTextField;

//杉德卡验证
@property (nonatomic, strong) UITextField *sandCardVerificationTextField;

//支付密码输入提示
@property (nonatomic, strong) UILabel *inputTitleLabel;

//密保
@property (nonatomic, strong) UILabel *miBaoTitleLabel;
@property (nonatomic, strong) UIButton *miBaobtn;
@property (nonatomic, strong) UILabel *miBaoTQuestionLabel;
@property (nonatomic, strong) UITextField *miBaoAnswerVerificationTextField;


- (instancetype)initWithFrame:(CGRect)frame;

/**
 *@brief 手机号验证
 *@return CGFloat
 */
- (CGFloat)phoneNumVerification;

/**
 *@brief 密保验证
 *@return CGFloat
 */
- (CGFloat)miBaoQuestionVerification;

/**
 *@brief 登录密码验证
 *@return CGFloat
 */
- (CGFloat)loginPwdVerification;

/**
 *@brief 短信验证
 *@return CGFloat
 */
- (CGFloat)shortMsgVerification;

/**
 *@brief 短信+手机号 验证
 *@return CGFloat
 */
- (CGFloat)shortMsgAndPhoneNumVerification;

/**
 *@brief 图片验证
 *@return CGFloat
 */
- (CGFloat)pictureVerification;

/**
 *@brief 身份证验证
 *@return CGFloat
 */
- (CGFloat)IDCardVerification;

/**
 *@brief 真实姓名+身份证 验证
 *@return CGFloat
 */
- (CGFloat)realNameAndIDCardVerification;

/**
 *@brief 银行卡验证
 *@return CGFloat
 */
- (CGFloat)bankCardVerification;

/**
 *@brief 信用卡验证
 *@return CGFloat
 */
- (CGFloat)creditCardVerification;

/**
 *@brief 杉德卡验证
 *@return CGFloat
 */
- (CGFloat)sandCardVerification;

/**
 *@brief 支付密码验证
 *@return CGFloat
 */
- (CGFloat)payPwdVerification;

/**
 *@brief 清空支付密码
 */
- (void)clearPayPwd;

@end
