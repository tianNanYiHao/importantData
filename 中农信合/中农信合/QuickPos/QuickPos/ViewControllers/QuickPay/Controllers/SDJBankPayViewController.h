//
//  SDJBankPayViewController.h
//  QuickPos
//
//  Created by feng Jie on 16/7/29.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OrderData;

@interface SDJBankPayViewController : UIViewController
@property(nonatomic,strong)OrderData *orderData;


@property (nonatomic,strong) NSString *orderId;

@property (nonatomic,strong) NSString *orderAmt;

@property (nonatomic,strong) NSString *bankCardNo;//银行卡号

@property (nonatomic,strong) NSString *AccountName;//开户人

@property (nonatomic,strong) NSString *ICCardNo;//身份证号

@property (nonatomic,strong) NSString *mobileNo;//银行卡绑定手机号

@property (nonatomic,strong) NSString *bankCodes;//联行号

@property (nonatomic,strong) NSString *bankName;//银行名字

@property (nonatomic,strong) NSString *phoneNo;

@end
