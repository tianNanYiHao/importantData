//
//  BankCardBindViewController.h
//  QuickPos
//
//  Created by 胡丹 on 15/4/8.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderData;
@class QuickBankItem;

@interface BankCardBindViewController : UIViewController

@property (nonatomic,strong)OrderData *orderData;

@property (nonatomic,strong)QuickBankItem *bankCardItem;

@property (nonatomic,strong) NSString *bankCard;//卡号

@property (nonatomic,strong) NSString *customerId;//后台返回

@property (nonatomic,strong) NSString *cardType;//卡类型

@property (nonatomic,strong) NSString *bankName;//银行名称(后台返回)

@property (nonatomic,strong) NSString *orderIds;//订单

@end
