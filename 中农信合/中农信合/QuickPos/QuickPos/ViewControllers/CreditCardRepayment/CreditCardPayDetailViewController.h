//
//  CreditCardPayDetailViewController.h
//  QuickPos
//
//  Created by 胡丹 on 15/3/18.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  BankCardItem;

@interface CreditCardPayDetailViewController : UIViewController
@property (nonatomic,strong)BankCardItem *bankCardItem;

@property (nonatomic,strong)NSString *BeneficiaryAccount;//收款方账号--信用卡号
@property (nonatomic,strong)NSString *BeneficiaryName;//收款人
@property (nonatomic,strong)NSString *BeneficiaryPhoneField;//收款人手机号

@end
