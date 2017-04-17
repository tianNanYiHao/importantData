//
//  AuthToolsUtil.h
//  GroupDemo
//
//  Created by tianNanYiHao on 2017/4/9.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassAuthToolView.h"
#import "SmsAuthToolView.h"
#import "ImageCodeAuthToolView.h"
#import "BankCardAuthToolView.h"
#import "QuestionAuthToolView.h"
#import "IdentityAuthToolView.h"
#import "CardCheckCodeAuthToolView.h"
#import "CreditCardAuthToolView.h"



@interface AuthToolsUtil : UIView


/**
 密码鉴权(登陆/手势/卡密共用)
 */
@property (nonatomic,strong) PassAuthToolView *passAuthToolView;

/**
 短信鉴权
 */
@property (nonatomic,strong) SmsAuthToolView *smsAtuhTollView;

/**
 图片鉴权
 */
@property (nonatomic,strong) ImageCodeAuthToolView *imageCodeAuthToolView;

/**
 银行卡
 */
@property (nonatomic,strong) BankCardAuthToolView *bankCardAuthToolView;

/**
 密保鉴权
 */
@property (nonatomic,strong) QuestionAuthToolView *questionAuthToolView;

/**
 身份证鉴权
 */
@property (nonatomic,strong) IdentityAuthToolView *identityAuthToolView;

/**
 卡校验码鉴权
 */
@property (nonatomic,strong) CardCheckCodeAuthToolView *cardCheckCodeAuthToolView;

/**
 信用卡鉴权
 */
@property (nonatomic,strong) CreditCardAuthToolView *creditCardAuthToolView;



/**
 初始化
 */
-(instancetype)init;



/**
 鉴权轮询

 @param authToolsArray 鉴权工具集组
 @return 鉴权工具view
 */
-(CGFloat)addAuthToolsInfo:(NSArray*)authToolsArray;




@end
