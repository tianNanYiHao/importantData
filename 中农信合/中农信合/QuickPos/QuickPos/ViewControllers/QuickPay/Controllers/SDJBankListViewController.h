//
//  SDJBankListViewController.h
//  QuickPos
//
//  Created by 胡丹 on 15/4/8.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderData;

@interface SDJBankListViewController : UIViewController
@property(nonatomic,strong)OrderData *orderData;

@property (nonatomic,strong)NSString *name;
@property (nonatomic,assign)NSUInteger destinationType;
@property (nonatomic,strong) NSString *orderId;
@property (nonatomic,strong) NSString *Amt;


//@property (nonatomic,strong)NSString *newbindid;

@end
