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
@property (nonatomic) CreditCardAuthToolViewStyle viewStyle;

-(instancetype)init;


/**
 *@brief 信用卡验证
 *@return CGFloat
 */
- (CGFloat)creditCardVerification;

@end
