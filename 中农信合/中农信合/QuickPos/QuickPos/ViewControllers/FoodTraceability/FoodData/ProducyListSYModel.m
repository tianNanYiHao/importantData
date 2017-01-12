//
//  ProducyListSYModel.m
//  QuickPos
//
//  Created by Lff on 16/7/28.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "ProducyListSYModel.h"
@interface ProducyListSYModel(){
    
}
@end

@implementation ProducyListSYModel
- (instancetype)initWithArrayM:(NSArray*)array{
    if (self) {
        if (!self.infoModelArray) {
            self.infoModelArray = [[NSMutableArray alloc]init];
        }
        for (NSDictionary *dict in array) {
            ProducyListSYModel *model = [[ProducyListSYModel alloc]initWithDict:dict];
            [self.infoModelArray addObject:model];
        }
        
    }return self;
    
    
}
-(instancetype)initWithDict:(NSDictionary*)dict{
    
    if (self = [super init]) {
        self.name = [dict objectForKey:@"name"];
        self.ID = [dict objectForKey:@"id"];
        self.thumbnailUrl = [dict objectForKey:@"thumbnailUrl"];
        self.producerName = [dict objectForKey:@"producerName"];
        self.standard = [dict objectForKey:@"standard"];
        self.guaranteeDays = [dict objectForKey:@"guaranteeDays"];
        
    }
    return self;
    
    
}

- (instancetype) initWihtdictOne:(NSDictionary *)dict{
    if (self = [super init]) {
        self.name = [dict objectForKey:@"name"];
        self.ID = [dict objectForKey:@"id"];
        self.thumbnailUrl = [dict objectForKey:@"thumbnailUrl"];
        self.producerName = [dict objectForKey:@"producerName"];
        self.standard = [dict objectForKey:@"standard"];
        self.guaranteeDays = [dict objectForKey:@"guaranteeDays"];
        self.coDe = [dict objectForKey:@"code"];
        
    }return self;
    
}


- (instancetype) initWithSYInfoWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        _productNameSY = [dict objectForKey:@"productName"];
        
        _enterpriseNameSY = [dict objectForKey:@"enterpriseName"];
        
        _enterpriseAddressSY = [dict objectForKey:@"enterpriseAddress"];
        _enterpriseLogoUrlSY = [dict objectForKey:@"enterpriseLogoUrl"];
        __productInfoArraySY = [dict objectForKey:@"nodeList"];

    }return self;
 
}


//溯源信息列表 从生产
-(instancetype)initWithSYProductListByDict:(NSDictionary *)dict{
    if (self = [super init]) {
        _nodeCodeNameSY = [dict objectForKey:@"nodeCodeName"];
//        parameters
        _companyNameSY = [[dict objectForKey:@"parameters"] objectForKey:@"生产厂商"];//生产厂商
        _companyDateSY =  [[dict objectForKey:@"parameters"] objectForKey:@"生产日期"];
        _companyBatchSY = [[dict objectForKey:@"parameters"] objectForKey:@"生产批次"];
    }return  self;

}
//溯源信息列表 到进货
-(instancetype)initWithSYProductListByDictStoke:(NSDictionary*)dict{
    if (self = [super init]) {
        _nodeCodeNameSY = [dict objectForKey:@"nodeCodeName"];

        _companyNameSY = [[dict objectForKey:@"parameters"] objectForKey:@"供货单位名称"];
        _companyDateSY =  [[dict objectForKey:@"parameters"] objectForKey:@"进货日期"];
   
    }return  self;

}



//获取产品出货信息
- (instancetype) initForProductOUTInfoWithArray:(NSArray *)array{
    if (self) {
        if (!self.arrayInfoProductOUT) {
            self.arrayInfoProductOUT = [[NSMutableArray alloc] initWithCapacity:0];
        }
        for (NSDictionary *dict in array) {
            ProducyListSYModel *model = [[ProducyListSYModel alloc] initWithProductDict:dict];
            [_arrayInfoProductOUT addObject:model];
        }
    }
    return self;
}
- (instancetype)initWithProductDict:(NSDictionary*)dict{
    if (self = [super init]) {
        self.batchProductOut = [dict objectForKey:@"batch"];
        self.productionDateProductOut = [dict objectForKey:@"productionDate"];
        self.purchaseDateProductOut = [dict objectForKey:@"purchaseDate"];
    }return self;
    
}

@end
