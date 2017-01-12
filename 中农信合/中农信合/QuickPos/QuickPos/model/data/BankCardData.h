//
//  BankCardData.h
//  QuickPos
//
//  Created by 胡丹 on 15/3/26.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "BaseData.h"

@interface BankCardData : BaseData

@property(nonatomic,strong)NSMutableArray *bankCardArr;


@end


@interface BankCardItem :NSObject
@property(nonatomic,strong)NSString *accountNo;//银行卡账号
@property(nonatomic,strong)NSString *bankCity;//开户行所在城市
@property(nonatomic,strong)NSString *bankCityId;//开户行所在城市ID
@property(nonatomic,strong)NSString *bankName;//银行名称
@property(nonatomic,strong)NSString *bankProvince;//开户行所在省
@property(nonatomic,strong)NSString *bankProviceId;//开户行所在省ID
@property(nonatomic,strong)NSString *branchBankId;//开户行支行ID
@property(nonatomic,strong)NSString *branchBankName;//开户行支行名
@property(nonatomic,strong)NSString *cardIdx;//查询索引ID
@property(nonatomic,strong)NSString *flagInfo;
@property(nonatomic,strong)NSString *name;//用户名
@property(nonatomic,strong)NSString *remark;//备注
@property(nonatomic,strong)NSString *iconUrl;//银行图片
@property(nonatomic,strong)NSString *payMode;//还款类型 返回信用卡支持的还款 方式 01-即时到帐 02- 非即时到帐
@property (nonatomic,strong) NSString *bankCode;//联行号

- (instancetype)initWithData:(NSDictionary*)dict;

@end