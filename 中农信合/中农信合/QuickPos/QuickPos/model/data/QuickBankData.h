//
//  QuickBankData.h
//  QuickPos
//
//  Created by 胡丹 on 15/4/9.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "BaseData.h"

@interface QuickBankData : BaseData
@property(nonatomic,strong)NSMutableArray *bankCardArr;

@end

@interface QuickBankItem :NSObject
@property(nonatomic,assign)NSUInteger cardType;//银行卡类型 1储蓄 2信用
@property(nonatomic,strong)NSString *bankName;//银行名称
@property(nonatomic,assign)NSUInteger isValid;//是否为有效卡 0 无效 1有效
@property(nonatomic,strong)NSString *bindID;//
@property (nonatomic,strong) NSString *newbindid;//
@property(nonatomic,strong)NSString *cardNo;//卡号
@property(nonatomic,strong)NSString *accountNo;//卡号
@property(nonatomic,assign)BOOL isBind;//是否绑定
@property(nonatomic,strong)NSString *validateCode;//信用卡有效期
@property(nonatomic,strong)NSString *cvv2;//信用卡校验码
@property(nonatomic,strong)NSString *name;//姓名
@property(nonatomic,strong)NSString *icCard;//身份证
@property(nonatomic,strong)NSString *phone;//银行预留手机号
@property(nonatomic,strong)NSString *iconUrl;//银行icon
@property(nonatomic,strong)NSString *bankId;//快捷支付的银联号


//@property(nonatomic,strong) NSString *customID;


- (instancetype)initWithData:(NSDictionary*)dict;

@end