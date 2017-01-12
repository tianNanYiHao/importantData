//
//  BankCardData.m
//  QuickPos
//
//  Created by 胡丹 on 15/3/26.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "BankCardData.h"

@implementation BankCardData


- (instancetype)initWithData:(NSDictionary *)dict
{
    self = [super initWithData:dict];
    if (self) {
        if(!self.bankCardArr){
            self.bankCardArr = [[NSMutableArray alloc]init];
        }
        for (NSDictionary *item in [[dict objectForKey:@"data"] objectForKey:@"resultBean"]){
            BankCardItem *bankCardItem = [[BankCardItem alloc]initWithData:item];
            [self.bankCardArr addObject:bankCardItem];
        }
    }
    return self;
}

@end


@implementation BankCardItem

- (instancetype)initWithData:(NSDictionary*)dict{
    self = [super init];
    if (self) {
        self.accountNo = [dict objectForKey:@"accountNo"];
        self.bankCity = [dict objectForKey:@"bankCity"];
        self.bankCityId = [dict objectForKey:@"bankCityId"];
        self.bankName = [dict objectForKey:@"bankName"];
        self.bankProvince = [dict objectForKey:@"bankProvince"];
        self.bankProviceId = [dict objectForKey:@"bankProviceId"];
        self.branchBankId = [dict objectForKey:@"branchBankId"];
        self.branchBankName = [dict objectForKey:@"branchBankName"];
        self.cardIdx = [dict objectForKey:@"cardIdx"];
        self.flagInfo = [dict objectForKey:@"flagInfo"];
        self.name = [dict objectForKey:@"name"];
        self.remark = [dict objectForKey:@"remark"];
        self.iconUrl = [dict objectForKey:@"iconUrl"];
        self.bankCode = [dict objectForKey:@"bankCode"];
    }
    return self;
}

@end
