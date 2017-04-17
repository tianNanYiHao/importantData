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

/**
 鉴权工具样式
 */
@property (nonatomic) ImageCodeAuthToolViewStyle viewStyle;
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
 *@brief 图片验证
 *@return CGFloat
 */
- (CGFloat)pictureVerification;



@end
