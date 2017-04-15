//
//  IdentityAuthToolView.h
//  GroupDemo
//
//  Created by tianNanYiHao on 2017/4/8.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    IdentityAuthToolViewStyleNo,
    IdentityAuthToolViewStyleYes
}IdentityAuthToolViewStyle;

@interface IdentityAuthToolView : UIView
//身份证验证
@property (nonatomic, strong) UITextField *realNameVerificationTextField;
@property (nonatomic, strong) UITextField *IDCardVerificationTextField;
@property (nonatomic) IdentityAuthToolViewStyle viewStyle;

-(instancetype)init;





/**
 *@brief 真实姓名+身份证 验证
 *@return CGFloat
 */
- (CGFloat)realNameAndIDCardVerification;



@end
