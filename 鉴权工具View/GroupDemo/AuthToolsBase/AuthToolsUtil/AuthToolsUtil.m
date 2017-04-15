//
//  AuthToolsUtil.m
//  GroupDemo
//
//  Created by tianNanYiHao on 2017/4/9.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "AuthToolsUtil.h"
#import "PassAuthToolView.h"
#import "SmsAuthToolView.h"
#import "ImageCodeAuthToolView.h"
#import "BankCardAuthToolView.h"
#import "QuestionAuthToolView.h"
#import "IdentityAuthToolView.h"
#import "CardCheckCodeAuthToolView.h"
#import "CreditCardAuthToolView.h"



#define ViewSize [UIScreen mainScreen].bounds.size
@interface AuthToolsUtil(){
    
    //鉴权工具高度
    CGFloat passAuthToolH;
    CGFloat smsAuthToolH;
    CGFloat imageCodeAuthToolH;
    CGFloat bankCardAuthToolH;
    CGFloat questionAuthToolH;
    CGFloat identityAuthToolH;
    CGFloat cardCheckCodeAuthToolH;
    CGFloat creditCardAuthToolH;
    
    
    
}
@property (nonatomic,assign) CGFloat currentY;

@property (nonatomic,strong) PassAuthToolView *passAuthToolView;
@property (nonatomic,strong) SmsAuthToolView *smsAtuhTollView;
@property (nonatomic,strong) ImageCodeAuthToolView *imageCodeAuthToolView;
@property (nonatomic,strong) BankCardAuthToolView *bankCardAuthToolView;
@property (nonatomic,strong) QuestionAuthToolView *questionAuthToolView;
@property (nonatomic,strong) IdentityAuthToolView *identityAuthToolView;
@property (nonatomic,strong) CardCheckCodeAuthToolView *cardCheckCodeAuthToolView;
@property (nonatomic,strong) CreditCardAuthToolView *creditCardAuthToolView;






@end

@implementation AuthToolsUtil


#pragma mark - lazyAdd

//动态Y
-(CGFloat)currentY{
    _currentY = passAuthToolH + smsAuthToolH + imageCodeAuthToolH + bankCardAuthToolH + questionAuthToolH + identityAuthToolH + cardCheckCodeAuthToolH + creditCardAuthToolH;
    return _currentY;
}


//pass
-(PassAuthToolView*)passAuthToolView{
    if (!_passAuthToolView) {
        _passAuthToolView = [[PassAuthToolView alloc] init];
        _passAuthToolView.viewstyle = PassAuthToolViewStyleYes;
        CGFloat passAuthToolHH = [_passAuthToolView loginPwdVerification];
        _passAuthToolView.frame = CGRectMake(0, self.currentY,ViewSize.width , passAuthToolHH);
        passAuthToolH =  passAuthToolHH;
    }
    return _passAuthToolView;
}

//sms
-(SmsAuthToolView*)smsAtuhTollView{
    if (!_smsAtuhTollView) {
        _smsAtuhTollView = [[SmsAuthToolView alloc] init];
        _smsAtuhTollView.viewStyle = SmsAuthToolViewStyleYes;
        CGFloat smsAuthToolHH =  [_smsAtuhTollView shortMsgAndPhoneNumVerification];
        _smsAtuhTollView.frame = CGRectMake(0, self.currentY, ViewSize.width, smsAuthToolHH);
        smsAuthToolH = smsAuthToolHH;
    }return _smsAtuhTollView;
}

//imageCode
-(ImageCodeAuthToolView*)imageCodeAuthToolView{
    if (!_imageCodeAuthToolView) {
        _imageCodeAuthToolView = [[ImageCodeAuthToolView alloc] init];
        _imageCodeAuthToolView.viewStyle = ImageCodeAuthToolViewStyleYes;
        CGFloat imageCodeAuthToolHH = [_imageCodeAuthToolView pictureVerification];
        _imageCodeAuthToolView.frame = CGRectMake(0, self.currentY, ViewSize.width, imageCodeAuthToolHH);
        imageCodeAuthToolH = imageCodeAuthToolHH;
    }
    return _imageCodeAuthToolView;
}

//bankCard
-(BankCardAuthToolView*)bankCardAuthToolView{
    if (!_bankCardAuthToolView) {
        _bankCardAuthToolView = [[BankCardAuthToolView alloc] init];
        _bankCardAuthToolView.viewStyle = BankCardAuthToolViewStyleYes;
        CGFloat bankCardAuthToolHH = [_bankCardAuthToolView bankCardVerification];
        _bankCardAuthToolView.frame = CGRectMake(0, self.currentY, ViewSize.width, bankCardAuthToolHH);
        bankCardAuthToolH = bankCardAuthToolHH;
    }return _bankCardAuthToolView;
}

//Question
-(QuestionAuthToolView*)questionAuthToolView{
    if (!_questionAuthToolView) {
        _questionAuthToolView = [[QuestionAuthToolView alloc] init];
        _questionAuthToolView.viewStyle = QuestionAuthToolViewStyleYes;
        CGFloat questionAuthToolHH = [_questionAuthToolView miBaoQuestionVerification];
        _questionAuthToolView.frame = CGRectMake(0, self.currentY, ViewSize.width,questionAuthToolHH);
        questionAuthToolH = questionAuthToolHH;
    }return _questionAuthToolView;
}


//Identity
-(IdentityAuthToolView*)identityAuthToolView{
    if (!_identityAuthToolView) {
        _identityAuthToolView = [[IdentityAuthToolView alloc] init];
        _identityAuthToolView.viewStyle = IdentityAuthToolViewStyleYes;
        CGFloat identityAuthToolHH = [_identityAuthToolView realNameAndIDCardVerification];
        _identityAuthToolView.frame = CGRectMake(0,  self.currentY, ViewSize.width, identityAuthToolHH);
        identityAuthToolH = identityAuthToolHH;
    }return _identityAuthToolView;
}


//cardCheckCode
-(CardCheckCodeAuthToolView*)cardCheckCodeAuthToolView{
    if (!_creditCardAuthToolView) {
        _cardCheckCodeAuthToolView = [[CardCheckCodeAuthToolView alloc] init];
        _cardCheckCodeAuthToolView.viewStyle = CardCheckCodeAuthToolViewStyleYes;
        CGFloat cardCheckCodeAuthToolHH = [_cardCheckCodeAuthToolView sandCardVerification];
        _cardCheckCodeAuthToolView.frame = CGRectMake(0, self.currentY, ViewSize.width, cardCheckCodeAuthToolHH);
        cardCheckCodeAuthToolH = cardCheckCodeAuthToolHH;
    }return _cardCheckCodeAuthToolView;
}


//creditCard
-(CreditCardAuthToolView*)creditCardAuthToolView{
    if (!_creditCardAuthToolView) {
        _creditCardAuthToolView = [[CreditCardAuthToolView alloc] init];
        _creditCardAuthToolView.viewStyle = CreditCardAuthToolViewStyleYes;
        CGFloat creditCardAuthToolHH = [_creditCardAuthToolView creditCardVerification];
        _creditCardAuthToolView.frame = CGRectMake(0, self.currentY, ViewSize.width, creditCardAuthToolHH);
        creditCardAuthToolH = creditCardAuthToolHH;
    }return _creditCardAuthToolView;
}



//初始化
-(instancetype)init{
    if (self = [super init]) {
    }return self;
}

#pragma mark 添加鉴权-轮询
//轮询添加鉴权工具
-(CGFloat)addAuthToolsInfo:(NSArray*)authToolsArray{
    
    
    NSInteger authToolsArrayCount = [authToolsArray count];
    for (int i = 0; i < authToolsArrayCount; i++) {
//        NSMutableDictionary *dic = authToolsArray[i];
//        NSString *type = [dic objectForKey:@"type"];
        NSString *type = authToolsArray[i];
        
        if ([@"loginpass" isEqualToString:type]) {
            [self addSubview:self.passAuthToolView];
        }
        if ([@"gesture" isEqualToString:type]) {
            [self addSubview:self.passAuthToolView];
        }
        if ([@"accpass" isEqualToString:type]) {
            [self addSubview:self.passAuthToolView];
        }
        if ([@"sms" isEqualToString:type]) {
            [self addSubview:self.smsAtuhTollView];
        }
        if ([@"img" isEqualToString:type]) {
            [self addSubview:self.imageCodeAuthToolView];
        }
        if ([@"bankCard" isEqualToString:type]) {
            [self addSubview:self.bankCardAuthToolView];
        }
        if ([@"question" isEqualToString:type]) {
            [self addSubview:self.questionAuthToolView];
        }
        if ([@"identity" isEqualToString:type]) {
            [self addSubview:self.identityAuthToolView];
        }
        if ([@"cardCheckCode" isEqualToString:type]) {
            [self addSubview:self.cardCheckCodeAuthToolView];
        }
        if ([@"creditCard" isEqualToString:type]) {
            [self addSubview:self.creditCardAuthToolView];
        }
    
    }
    return passAuthToolH + smsAuthToolH + imageCodeAuthToolH + bankCardAuthToolH + questionAuthToolH + identityAuthToolH + cardCheckCodeAuthToolH + creditCardAuthToolH;
}


@end
