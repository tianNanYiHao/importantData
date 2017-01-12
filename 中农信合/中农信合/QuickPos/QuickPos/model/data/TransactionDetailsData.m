//
//  TransactionDetailsData.m
//  QuickPos
//
//  Created by Leona on 15/4/29.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "TransactionDetailsData.h"

@implementation TransactionDetailsData

- (instancetype)initWithData:(NSDictionary *)dict
{
    self = [super initWithData:dict];
    if (self) {
//        if(!self.detailArr){
//            self.detailArr = [[NSMutableArray alloc]init];
//        }
//        
//        TransactionDetailsItem *DetailsItem = [[TransactionDetailsItem alloc]initWithData:[[dict objectForKey:@"data"] objectForKey:@"resultBean"]];
//        [self.detailArr addObject:DetailsItem];
        
        
        self.tradeName = [dict objectForKey:@"transName"];
        self.payerName = [dict objectForKey:@"payUserName"];
        self.payeeName = [dict objectForKey:@"receiptsUserName"];
        self.transactionAmount = [dict objectForKey:@"amount"];
        self.poundage = [dict objectForKey:@"fee"];
        self.transactionStatus = [dict objectForKey:@"status"];
        self.methodOfPayment = [dict objectForKey:@"payType"];
        self.tradingTime = [dict objectForKey:@"localTime"];
        self.tradingDate = [dict objectForKey:@"localDate"];

        
    }
    return self;
}

@end

//@implementation TransactionDetailsItem
//
//- (instancetype)initWithData:(NSDictionary*)dict{
//    self = [super init];
//    if (self) {
//        self.tradeName = [dict objectForKey:@"transName"];
//        self.payerName = [dict objectForKey:@"payUserName"];
//        self.payeeName = [dict objectForKey:@"receiptsUserName"];
//        self.transactionAmount = [dict objectForKey:@"amount"];
//        self.poundage = [dict objectForKey:@"fee"];
//        self.transactionStatus = [dict objectForKey:@"status"];
//        self.methodOfPayment = [dict objectForKey:@"payType"];
//        self.tradingTime = [dict objectForKey:@"localTime"];
//        self.tradingDate = [dict objectForKey:@"localDate"];
//       
//    }
//    return self;
//}
//
// @end