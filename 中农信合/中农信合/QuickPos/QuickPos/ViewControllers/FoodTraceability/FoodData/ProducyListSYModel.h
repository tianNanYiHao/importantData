//
//  ProducyListSYModel.h
//  QuickPos
//
//  Created by Lff on 16/7/28.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProducyListSYModel : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *thumbnailUrl;
@property (nonatomic,strong) NSString *ID;
@property (nonatomic,strong) NSString *producerName; // 厂商
@property (nonatomic,strong) NSString *standard; //产品规格
@property (nonatomic,strong) NSString *guaranteeDays;
@property (nonatomic,strong) NSString *coDe;
@property (nonatomic,strong) NSMutableArray *infoModelArray;
-(instancetype) initWithArrayM:(NSArray*)array;
//单个产品信息数据获取
-(instancetype) initWihtdictOne:(NSDictionary*)dict;




//溯源信息数据获取
@property (nonatomic,strong) NSString *productNameSY;
@property (nonatomic,strong) NSString *enterpriseNameSY;
@property (nonatomic,strong) NSString *enterpriseAddressSY;
@property (nonatomic,strong) NSString *enterpriseLogoUrlSY;
@property (nonatomic,strong) NSArray *_productInfoArraySY;
@property (nonatomic,strong) NSString *batchSY;
@property (nonatomic,strong) NSString *dateSY;
@property (nonatomic,strong) NSString *companySY;
-(instancetype) initWithSYInfoWithDict:(NSDictionary*)dict;


//溯源信息列表 从生产到进货
@property (nonatomic,strong) NSString *nodeCodeNameSY;
@property (nonatomic,strong) NSString *companyNameSY;  //生产厂商
@property (nonatomic,strong) NSString *companyDateSY; //生产日期
@property (nonatomic,strong) NSString *companyBatchSY;//生产批次
//从生产
-(instancetype) initWithSYProductListByDict:(NSDictionary*)dict;
//到进货
-(instancetype) initWithSYProductListByDictStoke:(NSDictionary*)dict;





//获取产品出货信息
@property (nonatomic,strong) NSString *batchProductOut	;  //批次号
@property (nonatomic,strong) NSString *productionDateProductOut ;  //生产日期
@property (nonatomic,strong) NSString *purchaseDateProductOut ;    //采购日期
@property (nonatomic,strong) NSMutableArray *arrayInfoProductOUT; //
- (instancetype)initForProductOUTInfoWithArray:(NSArray*)array;


@end
