//
//  CreditCardBindViewController.h
//  QuickPos
//
//  Created by feng Jie on 16/6/27.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderData;


@interface CreditCardBindViewController : UIViewController

@property (nonatomic,strong)OrderData *orderData;

@property (nonatomic,strong) NSString *bankCard;//卡号

@property (nonatomic,strong) NSString *customerId;//后台返回

@property (nonatomic,strong) NSString *cardType;//卡类型

@property (nonatomic,strong) NSString *bankName;//银行名称(后台返回)

@property (nonatomic,strong) NSString *orderIds;//订单


@end
