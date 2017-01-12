//
//  OrderData.m
//  QuickPos
//
//  Created by 胡丹 on 15/3/20.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "OrderData.h"

@implementation OrderData

- (instancetype)initWithData:(NSDictionary *)dict{
    self = [super initWithData:dict];
    if (self) {
        self.orderId = [dict objectForKey:@"orderId"];
        self.orderAmt = [dict objectForKey:@"orderAmt"];
        self.orderDesc = [dict objectForKey:@"orderDesc"];
        self.realAmt = [dict objectForKey:@"realAmt"];
        
    }
    return self;
}

@end
