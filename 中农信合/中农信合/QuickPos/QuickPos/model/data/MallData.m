//
//  MallData.m
//  QuickPos
//
//  Created by 张倡榕 on 15/3/20.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "MallData.h"


//@synthesize commodityID;
//@synthesize icon;
//@synthesize title;
//@synthesize price;
//@synthesize amount;

@implementation MallData


//- (void)setBankCardArr:(NSMutableArray *)bankCardArr{
//    self.bankCardArr = bankCardArr;
//}

//- (NSMutableArray*)bankCardArr{
//    if (!self.bankCardArr) {
//        self.bankCardArr = [[NSMutableArray alloc]init];
//    }
//    return self.bankCardArr;
//
//}

- (instancetype)initWithData:(NSMutableArray *)Arr
{
//    self = [super initWithData:dict];
    if (self) {
        if(!self.mallArr){
            self.mallArr = [[NSMutableArray alloc]init];
        }
            for (NSDictionary *item in Arr){
                MallItem *mallItem = [[MallItem alloc]initWithData:item];
                [self.mallArr addObject:mallItem];
            }
    }
    return self;
}
//-(instancetype)addData:(NSDictionary *)dict type:(NSString *)type
//{
//    
//    if ([type isEqualToString:@"1"]) {
//        for (NSDictionary *item in [[dict objectForKey:@"data"] objectForKey:@"list"]){
//            MallItem *mallItem = [[MallItem alloc]initWithData:item];
//            [self.mallArr addObject:mallItem];
//        }
//    }
//    else if([type isEqualToString:@"2"])
//    {
//        for (NSDictionary *item in [[dict objectForKey:@"data"] objectForKey:@"list"]){
//            MallItem *mallItem = [[MallItem alloc]initWithData:item];
//            [self.mallArr insertObject:mallItem atIndex:0];
//        }
//    }
//    
//    return self;
//}

@end


@implementation MallItem

- (instancetype)initWithData:(NSDictionary*)dict{
    self = [super init];
    if (self) {
        self.commodityID = [dict objectForKey:@"productId"];
        self.iconurl = [dict objectForKey:@"image"];
        self.title = [dict objectForKey:@"name"];
        self.price = [dict objectForKey:@"marketPrice"];//marketPrice-原价
        self.amount = [dict objectForKey:@"discount"];//discount-促销价格
        self.sum = @"1";
    }
    return self;
}


@end
