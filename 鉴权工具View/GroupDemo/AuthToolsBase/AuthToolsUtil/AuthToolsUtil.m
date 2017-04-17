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
    }
    return _passAuthToolView;
}

//sms
-(SmsAuthToolView*)smsAtuhTollView{
    if (!_smsAtuhTollView) {
        _smsAtuhTollView = [[SmsAuthToolView alloc] init];
        _smsAtuhTollView.viewStyle = SmsAuthToolViewStyleYes;
    }
    return _smsAtuhTollView;
}

//imageCode
-(ImageCodeAuthToolView*)imageCodeAuthToolView{
    if (!_imageCodeAuthToolView) {
        _imageCodeAuthToolView = [[ImageCodeAuthToolView alloc] init];
        _imageCodeAuthToolView.viewStyle = ImageCodeAuthToolViewStyleYes;
    }
    return _imageCodeAuthToolView;
}

//bankCard
-(BankCardAuthToolView*)bankCardAuthToolView{
    if (!_bankCardAuthToolView) {
        _bankCardAuthToolView = [[BankCardAuthToolView alloc] init];
        _bankCardAuthToolView.viewStyle = BankCardAuthToolViewStyleYes;
    }return _bankCardAuthToolView;
}

//Question
-(QuestionAuthToolView*)questionAuthToolView{
    if (!_questionAuthToolView) {
        _questionAuthToolView = [[QuestionAuthToolView alloc] init];
        _questionAuthToolView.viewStyle = QuestionAuthToolViewStyleYes;
    }return _questionAuthToolView;
}


//Identity
-(IdentityAuthToolView*)identityAuthToolView{
    if (!_identityAuthToolView) {
        _identityAuthToolView = [[IdentityAuthToolView alloc] init];
        _identityAuthToolView.viewStyle = IdentityAuthToolViewStyleYes;
    }return _identityAuthToolView;
}


//cardCheckCode
-(CardCheckCodeAuthToolView*)cardCheckCodeAuthToolView{
    if (!_cardCheckCodeAuthToolView) {
        _cardCheckCodeAuthToolView = [[CardCheckCodeAuthToolView alloc] init];
        _cardCheckCodeAuthToolView.viewStyle = CardCheckCodeAuthToolViewStyleYes;
    }return _cardCheckCodeAuthToolView;
}


//creditCard
-(CreditCardAuthToolView*)creditCardAuthToolView{
    if (!_creditCardAuthToolView) {
        _creditCardAuthToolView = [[CreditCardAuthToolView alloc] init];
        _creditCardAuthToolView.viewStyle = CreditCardAuthToolViewStyleYes;
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
            CGFloat passAuthToolHH = [self.passAuthToolView loginPwdVerification];
            _passAuthToolView.frame = CGRectMake(0, self.currentY,ViewSize.width , passAuthToolHH);
            passAuthToolH =  passAuthToolHH;
            [self addSubview:self.passAuthToolView];
        }
        if ([@"gesture" isEqualToString:type]) {
            CGFloat passAuthToolHH = [self.passAuthToolView loginPwdVerification];
            _passAuthToolView.frame = CGRectMake(0, self.currentY,ViewSize.width , passAuthToolHH);
            passAuthToolH =  passAuthToolHH;
            [self addSubview:self.passAuthToolView];
        }
        if ([@"accpass" isEqualToString:type]) {
            CGFloat passAuthToolHH = [self.passAuthToolView loginPwdVerification];
            _passAuthToolView.frame = CGRectMake(0, self.currentY,ViewSize.width , passAuthToolHH);
            passAuthToolH =  passAuthToolHH;
            [self addSubview:self.passAuthToolView];
        }
        if ([@"sms" isEqualToString:type]) {
            CGFloat smsAuthToolHH =  [self.smsAtuhTollView shortMsgAndPhoneNumVerification];
            _smsAtuhTollView.frame = CGRectMake(0, self.currentY, ViewSize.width, smsAuthToolHH);
            smsAuthToolH = smsAuthToolHH;

            [self addSubview:self.smsAtuhTollView];
        }
        if ([@"img" isEqualToString:type]) {
            CGFloat imageCodeAuthToolHH = [self.imageCodeAuthToolView pictureVerification];
            _imageCodeAuthToolView.frame = CGRectMake(0, self.currentY, ViewSize.width, imageCodeAuthToolHH);
            imageCodeAuthToolH = imageCodeAuthToolHH;
            [self addSubview:self.imageCodeAuthToolView];
        }
        if ([@"bankCard" isEqualToString:type]) {
            CGFloat bankCardAuthToolHH = [self.bankCardAuthToolView bankCardVerification];
            _bankCardAuthToolView.frame = CGRectMake(0, self.currentY, ViewSize.width, bankCardAuthToolHH);
            bankCardAuthToolH = bankCardAuthToolHH;
            [self addSubview:self.bankCardAuthToolView];
        }
        if ([@"question" isEqualToString:type]) {
            CGFloat questionAuthToolHH = [self.questionAuthToolView miBaoQuestionVerification];
            _questionAuthToolView.frame = CGRectMake(0, self.currentY, ViewSize.width,questionAuthToolHH);
            questionAuthToolH = questionAuthToolHH;

            [self addSubview:self.questionAuthToolView];
        }
        if ([@"identity" isEqualToString:type]) {
            CGFloat identityAuthToolHH = [self.identityAuthToolView realNameAndIDCardVerification];
            _identityAuthToolView.frame = CGRectMake(0,  self.currentY, ViewSize.width, identityAuthToolHH);
            identityAuthToolH = identityAuthToolHH;
            [self addSubview:self.identityAuthToolView];
        }
        if ([@"cardCheckCode" isEqualToString:type]) {
            CGFloat cardCheckCodeAuthToolHH = [self.cardCheckCodeAuthToolView sandCardVerification];
            _cardCheckCodeAuthToolView.frame = CGRectMake(0, self.currentY, ViewSize.width, cardCheckCodeAuthToolHH);
            cardCheckCodeAuthToolH = cardCheckCodeAuthToolHH;
            [self addSubview:self.cardCheckCodeAuthToolView];
        }
        if ([@"creditCard" isEqualToString:type]) {
            CGFloat creditCardAuthToolHH = [self.creditCardAuthToolView creditCardVerification];
            _creditCardAuthToolView.frame = CGRectMake(0, self.currentY, ViewSize.width, creditCardAuthToolHH);
            creditCardAuthToolH = creditCardAuthToolHH;
            [self addSubview:self.creditCardAuthToolView];
        }
    
    }
    return passAuthToolH + smsAuthToolH + imageCodeAuthToolH + bankCardAuthToolH + questionAuthToolH + identityAuthToolH + cardCheckCodeAuthToolH + creditCardAuthToolH;
}


@end
