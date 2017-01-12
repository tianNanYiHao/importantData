//
//  RechargeViewController.h
//  QuickPos
//
//  Created by Leona on 15/9/25.
//  Copyright © 2015年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderData;
@interface RechargeViewController : UIViewController

@property(nonatomic,strong)UIViewController *parentCtrl;

@property (nonatomic,strong)NSMutableArray *CartArr;
@property (nonatomic,strong)NSString *mobileNo;
@property (retain, nonatomic) NSDictionary *item;
@property (nonatomic,strong)NSString *orderRemark;//扫码订单号


@property (weak, nonatomic) IBOutlet UIButton *comfirt;

@property (nonatomic,strong) NSString *titleNmae;//标题
@property (nonatomic,strong) NSString *comfirBtnTitle; //修改的 确认按钮文字

@property (nonatomic,strong)NSString *moneyLabTitle; //修改的 充值金额lab
@property (nonatomic,assign)BOOL isRechargeView; //判断是否充值页面;
@property (nonatomic,strong)NSString *moneyTitle; //接收的金钱数字

@property (nonatomic,strong)OrderData *orderData; //

@property (nonatomic,strong)NSDictionary *productlistDic; //  从MallViewController 拿来的三个字典信息
@property (nonatomic,strong) NSDictionary *oneProductDic; //
@property (nonatomic,strong)NSDictionary *oneProductMoneyDic; //



@end
