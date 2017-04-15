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
@property (nonatomic) CardCheckCodeAuthToolViewStyle viewStyle;

-(instancetype)init;

/**
 *@brief 杉德卡验证
 *@return CGFloat
 */
- (CGFloat)sandCardVerification;

@end
