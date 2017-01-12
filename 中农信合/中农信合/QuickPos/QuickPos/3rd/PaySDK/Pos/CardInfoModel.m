//
//  CardInfoModel.m
//  PosDemo
//
//  Created by 糊涂 on 14/12/19.
//  Copyright (c) 2014年 yoolink. All rights reserved.
//

#import "CardInfoModel.h"

@implementation CardInfoModel
@synthesize hasPassword;     //是否需要输入密码
@synthesize track;           //磁道数据
@synthesize track2Lenght;    //二磁长度
@synthesize track3Lenght;    //三磁长度
@synthesize deviceNo;        //设备号
@synthesize psamNO;          //psam卡号
@synthesize random;          //加密随机数
@synthesize cardNO;          //卡号
@synthesize expiryDate;      //卡有效期
@synthesize mac;             //mac+mac随机数
@synthesize sequensNo;       //卡序列号
@synthesize data55;          //55域数据
@synthesize cardType;        //卡类型(只有艾创IC卡设备支持)
@synthesize cardInfo;        //拼装完成的数据
@end



