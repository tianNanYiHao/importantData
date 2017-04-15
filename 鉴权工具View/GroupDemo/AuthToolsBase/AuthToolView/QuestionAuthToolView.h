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
@property (nonatomic) QuestionAuthToolViewStyle viewStyle;


-(instancetype)init;



/**
 *@brief 密保验证
 *@return CGFloat
 */
- (CGFloat)miBaoQuestionVerification;
@end
