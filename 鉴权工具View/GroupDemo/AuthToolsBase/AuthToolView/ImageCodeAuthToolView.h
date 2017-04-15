//
//  ImageCodeAuthToolView.h
//  GroupDemo
//
//  Created by tianNanYiHao on 2017/4/8.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ImageCodeAuthToolViewStyleNo,
    ImageCodeAuthToolViewStyleYes
}ImageCodeAuthToolViewStyle;

@interface ImageCodeAuthToolView : UIView


//图片验证
@property (nonatomic, strong) UITextField *pictureVerificationTextField;
@property (nonatomic, strong) UIButton *pictureVerificationBtn;

@property (nonatomic) ImageCodeAuthToolViewStyle viewStyle;

-(instancetype)init;



/**
 *@brief 图片验证
 *@return CGFloat
 */
- (CGFloat)pictureVerification;



@end
