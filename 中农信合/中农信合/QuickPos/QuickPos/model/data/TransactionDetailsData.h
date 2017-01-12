//
//  TransactionDetailsData.h
//  QuickPos
//
//  Created by Leona on 15/4/29.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "BaseData.h"

@interface TransactionDetailsData : BaseData

@property(nonatomic,strong)NSMutableArray *detailArr;

@property(nonatomic,strong)NSString *tradeName;//交易名称
@property(nonatomic,strong)NSString *payerName;//付款方
@property(nonatomic,strong)NSString *payeeName;//收款方
@property(nonatomic,strong)NSString *transactionAmount;//交易金额
@property(nonatomic,strong)NSString *poundage;//手续费
@property(nonatomic,strong)NSString *transactionStatus;//交易状态
@property(nonatomic,strong)NSString *methodOfPayment;//支付方式
@property(nonatomic,strong)NSString *tradingTime;//交易时间
@property(nonatomic,strong)NSString *tradingDate;//交易时间

- (instancetype)initWithData:(NSDictionary*)dict;


@end


//@interface TransactionDetailsItem :NSObject
//@property(nonatomic,strong)NSString *tradeName;//交易名称
//@property(nonatomic,strong)NSString *payerName;//付款方
//@property(nonatomic,strong)NSString *payeeName;//收款方
//@property(nonatomic,strong)NSString *transactionAmount;//交易金额
//@property(nonatomic,strong)NSString *poundage;//手续费
//@property(nonatomic,strong)NSString *transactionStatus;//交易状态
//@property(nonatomic,strong)NSString *methodOfPayment;//支付方式
//@property(nonatomic,strong)NSString *tradingTime;//交易时间
//@property(nonatomic,strong)NSString *tradingDate;//交易时间
//
//- (instancetype)initWithData:(NSDictionary*)dict;
//
//@end
