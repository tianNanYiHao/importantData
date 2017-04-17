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

/**
 鉴权工具样式
 */
@property (nonatomic) PassAuthToolViewStyle viewstyle;


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
 *@brief 登录密码验证
 *@return CGFloat
 */
- (CGFloat)loginPwdVerification;



@end
