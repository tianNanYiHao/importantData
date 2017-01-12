//
//  BindingSDJBankCardViewController.h
//  QuickPos
//
//  Created by feng Jie on 16/7/29.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OrderData;

@interface BindingSDJBankCardViewController : UIViewController

@property(nonatomic,strong)OrderData *orderData;

@property (nonatomic,strong) NSString *orderId;
@property (nonatomic,strong) NSString *orderAmt;


@end
