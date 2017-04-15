//
//  PassAuthToolView.h
//  GroupDemo
//
//  Created by tianNanYiHao on 2017/4/8.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    PassAuthToolViewStyleNo,
    PassAuthToolViewStyleYes
}PassAuthToolViewStyle;

@interface PassAuthToolView : UIView

//登录密码验证
@property (nonatomic, strong) UITextField *loginPwdVerificationTextField;
@property (nonatomic, strong) UIButton *loginPwdVerificationBtn;
@property (nonatomic) PassAuthToolViewStyle viewstyle;

//tipString
@property (nonatomic, strong) NSString *tipString;
@property (nonatomic, assign) BOOL tipShow;


-(instancetype)init;


/**
 *@brief 登录密码验证
 *@return CGFloat
 */
- (CGFloat)loginPwdVerification;



@end
