//
//  MyBankListViewController.h
//  QuickPos
//
//  Created by 胡丹 on 15/4/8.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderData;

@interface MyBankListViewController : UIViewController
@property(nonatomic,strong)OrderData *orderData;

@property (nonatomic,strong)NSString *name;
@property (nonatomic,assign)NSUInteger destinationType;
@property (nonatomic,strong) NSString *orderStatus;//商城订单状态
@property (nonatomic,strong) NSString *receiverName;//商城收货人姓名
@property (nonatomic,strong) NSString *receiverPhone;//商城收货人手机号
@property (nonatomic,strong) NSString *receiverAddress;//商城收货人地址
//@property (nonatomic,strong)NSString *newbindid;

@end
