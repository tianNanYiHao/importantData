//
//  BankCardAuthToolView.h
//  GroupDemo
//
//  Created by tianNanYiHao on 2017/4/8.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    BankCardAuthToolViewStyleNo,
    BankCardAuthToolViewStyleYes
}BankCardAuthToolViewStyle;


@interface BankCardAuthToolView : UIView
//银行卡验证
@property (nonatomic, strong) UILabel *bankNameContentVerificationLabel;
@property (nonatomic, strong) UITextField *bankCardVerificationTextField;

@property (nonatomic) BankCardAuthToolViewStyle viewStyle;


-(instancetype)init;



/**
 *@brief 银行卡验证
 *@return CGFloat
 */
- (CGFloat)bankCardVerification;



@end
