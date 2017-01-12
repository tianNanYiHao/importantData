//
//  TransactionDetailsViewController.h
//  QuickPos
//
//  Created by Leona on 15/3/16.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransactionDetailsViewController : UIViewController

@property(nonatomic,strong)NSString *recordID;//记录编号

@property(nonatomic,strong)NSString *time;//交易时间

@property (nonatomic,strong) NSString *transactionStatus;//交易状态

@property (nonatomic,strong) NSString *payStyle;//支付方式



@end
