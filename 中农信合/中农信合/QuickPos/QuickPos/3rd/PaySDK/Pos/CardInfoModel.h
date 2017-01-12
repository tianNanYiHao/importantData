//
//  CardInfoModel.h
//  PosDemo
//
//  Created by 糊涂 on 14/12/19.
//  Copyright (c) 2014年 yoolink. All rights reserved.
//

#import "Pos.h"

@interface CardInfoModel : NSObject
@property (nonatomic, assign)BOOL hasPassword;          //是否需要输入密码
@property (nonatomic, strong)NSString *track;           //磁道数据
@property (nonatomic, strong)NSString *track2Lenght;    //二磁长度
@property (nonatomic, strong)NSString *track3Lenght;    //三磁长度
@property (nonatomic, strong)NSString *deviceNo;        //设备号
@property (nonatomic, strong)NSString *psamNO;          //psam卡号
@property (nonatomic, strong)NSString *random;          //加密随机数
@property (nonatomic, strong)NSString *cardNO;          //卡号
@property (nonatomic, strong)NSString *expiryDate;      //卡有效期
@property (nonatomic, strong)NSString *mac;             //mac+mac随机数
@property (nonatomic, strong)NSString *sequensNo;       //卡序列号
@property (nonatomic, strong)NSString *data55;          //55域数据
@property (nonatomic, strong)NSString *cardType;        //卡类型(只有艾创IC卡设备支持)
@property (nonatomic, strong)NSString *cardInfo;        //拼装完成的数据

@end
