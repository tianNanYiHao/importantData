//
//  PayType.h
//  QuickPos
//
//  Created by 胡丹 on 15/4/3.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#ifndef QuickPos_PayType_h
#define QuickPos_PayType_h

#endif


typedef enum : NSUInteger {
    CardPayType = 1,//刷卡支付
    AccountPayType,//账户支付
    QuickPayType,//快捷支付
    SDJQuickPayType,//盛迪嘉快捷支付(无卡支付)
} PAYTYPE;


typedef enum : NSUInteger {
    ImmediatelyPayTimeType = 0,//实时还款
    NormalPayTimeType,//普通还款
} PAYTIMETYPE;


typedef enum : NSUInteger {
    DEPOSITCARD = 1,//储蓄卡
    CREDITCARD,//信用卡
} CARDTYPE;


typedef enum : NSUInteger {
    TRANSFER = 1,//转账
    WITHDRAW,//提现
    CREDIT,//信用卡
    WeChat,//微信
    MyRunSub,//分润
} TRANSFERTYPE;