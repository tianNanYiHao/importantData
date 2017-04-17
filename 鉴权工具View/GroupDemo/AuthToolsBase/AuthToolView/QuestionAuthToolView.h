//
//  QuestionAuthToolView.h
//  GroupDemo
//
//  Created by tianNanYiHao on 2017/4/8.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    QuestionAuthToolViewStyleNo,
    QuestionAuthToolViewStyleYes
}QuestionAuthToolViewStyle;


@interface QuestionAuthToolView : UIView
//密保
@property (nonatomic, strong) UILabel *miBaoTitleLabel;
@property (nonatomic, strong) UIButton *miBaobtn;
@property (nonatomic, strong) UILabel *miBaoTQuestionLabel;
@property (nonatomic, strong) UITextField *miBaoAnswerVerificationTextField;

/**
 鉴权工具样式
 */
@property (nonatomic) QuestionAuthToolViewStyle viewStyle;

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
 *@brief 密保验证
 *@return CGFloat
 */
- (CGFloat)miBaoQuestionVerification;
@end
