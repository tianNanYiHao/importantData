//
//  CreditCardAuthToolView.h
//  GroupDemo
//
//  Created by tianNanYiHao on 2017/4/8.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    CreditCardAuthToolViewStyleNo,
    CreditCardAuthToolViewStyleYes
}CreditCardAuthToolViewStyle;
@interface CreditCardAuthToolView : UIView


//信用卡验证
@property (nonatomic, strong) UITextField *cvnVerificationTextField;
@property (nonatomic, strong) UITextField *expiryVerificationTextField;

/**
 鉴权工具样式
 */
@property (nonatomic) CreditCardAuthToolViewStyle viewStyle;

/**
 鉴权提示文字
 */
@property (nonatomic, strong) NSString *tipString;

/**
 鉴权是否显示
 */
@property (nonatomic, assign) BOOL tipShow;


/**
 初始化
 */
-(instancetype)init;


/**
 *@brief 信用卡验证
 *@return CGFloat
 */
- (CGFloat)creditCardVerification;

@end
