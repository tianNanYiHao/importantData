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

/**
 鉴权工具样式
 */
@property (nonatomic) IdentityAuthToolViewStyle viewStyle;


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
 *@brief 真实姓名+身份证 验证
 *@return CGFloat
 */
- (CGFloat)realNameAndIDCardVerification;



@end
