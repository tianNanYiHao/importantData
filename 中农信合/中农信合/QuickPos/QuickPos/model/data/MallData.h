//
//  MallData.h
//  QuickPos
//
//  Created by 张倡榕 on 15/3/20.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "BaseData.h"

@interface MallData : BaseData

@property(nonatomic,strong)NSMutableArray *mallArr;

- (instancetype)initWithData:(NSMutableArray *)Arr;

@end
 
@interface MallItem : NSObject

@property (nonatomic,strong)NSString *commodityID;
@property (nonatomic,strong)NSString *iconurl;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *price;
@property (nonatomic,strong)NSString *amount;
@property (nonatomic,strong)NSString *sum;
@property (nonatomic,strong)NSDictionary *dic;

- (instancetype)initWithData:(NSDictionary*)dict;

@end
