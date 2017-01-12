//
//  AddCardDetailInfoViewController.h
//  QuickPos
//
//  Created by 胡丹 on 15/4/8.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderData;
@class QuickBankItem;

@interface AddCardDetailInfoViewController : UIViewController

@property (nonatomic,strong)OrderData *orderData;
@property (nonatomic,strong)QuickBankItem *quickBankItem; //快速银行的(Model)

@end
