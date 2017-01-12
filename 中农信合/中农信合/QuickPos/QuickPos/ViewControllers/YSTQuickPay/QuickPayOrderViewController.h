//
//  QuickPayOrderViewController.h
//  QuickPos
//
//  Created by 胡丹 on 15/4/8.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderData,QuickBankItem;


@interface QuickPayOrderViewController : UIViewController
@property (nonatomic,strong)OrderData *orderData;
@property (nonatomic,strong)QuickBankItem *bankCardItem;

@property (nonatomic,strong) NSString *bankName;
@property (nonatomic,strong) NSString *cardNums;
@property (nonatomic,strong) NSString *newbindid;
@property (nonatomic,strong) NSString *orderID;
@property (nonatomic,strong) NSString *customerId;
@property (nonatomic,strong) NSString *customerName;
@property (nonatomic,strong) NSString *cardType;
@property (nonatomic,strong) NSString *bankMobileNo;
@property (nonatomic,assign) BOOL isJumps;
@property (nonatomic,strong) NSString *ordStatus;//商城订单状态
@property (nonatomic,strong) NSString *receiverName;//商城收货人姓名
@property (nonatomic,strong) NSString *receiverPhone;//商城收货人手机号
@property (nonatomic,strong) NSString *receiverAddress;//商城收货人地址


@end
