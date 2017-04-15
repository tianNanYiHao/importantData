//
//  SmsAuthToolView.h
//  GroupDemo
//
//  Created by tianNanYiHao on 2017/4/8.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    SmsAuthToolViewStyleNo,
    SmsAuthToolViewStyleYes
}SmsAuthToolViewStyle;

@interface SmsAuthToolView : UIView

//手机号验证
@property (nonatomic, strong) UITextField *phoneNumVerificationTextField;
//短信验证
@property (nonatomic, strong) UITextField *shortMsgVerificationTextField;
@property (nonatomic, strong) UIButton *shortMsgVerificationBtn;
@property (nonatomic) SmsAuthToolViewStyle viewStyle;



-(instancetype)init;

/**
 *@brief 短信+手机号 验证
 *@return CGFloat
 */
- (CGFloat)shortMsgAndPhoneNumVerification;


@end
