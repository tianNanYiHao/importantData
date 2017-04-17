//
//  CardCheckCodeAuthToolView.h
//  GroupDemo
//
//  Created by tianNanYiHao on 2017/4/8.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    CardCheckCodeAuthToolViewStyleNo,
    CardCheckCodeAuthToolViewStyleYes
}CardCheckCodeAuthToolViewStyle;


@interface CardCheckCodeAuthToolView : UIView
//杉德卡验证
@property (nonatomic, strong) UITextField *sandCardVerificationTextField;

/**
 鉴权工具样式
 */
@property (nonatomic) CardCheckCodeAuthToolViewStyle viewStyle;

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
 *@brief 杉德卡验证
 *@return CGFloat
 */
- (CGFloat)sandCardVerification;

@end
