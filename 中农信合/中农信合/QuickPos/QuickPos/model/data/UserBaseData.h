//
//  UserBaseData.h
//  QuickPos
//
//  Created by 胡丹 on 15/3/23.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "BaseData.h"

//官网地址	website
//客服电话	customerService
//下载地址	download
//联系电子邮件	email
//公司名	company
//公司简称	shortCompary
//图标地址	appIcon
//商标图地址	logo
@interface UserBaseData : BaseData
@property (nonatomic,strong)NSString *mobileNo;//手机号
@property (nonatomic,strong)NSString *token;
@property (nonatomic,strong)NSString *userName;//用户名
@property (nonatomic,strong)NSString *userType;//用户类型
@property (nonatomic,strong)NSString *customerId;
@property (nonatomic,strong)NSString *website;
@property (nonatomic,strong)NSString *download;
@property (nonatomic,strong)NSString *email;
@property (nonatomic,strong)NSString *customerService;
@property (nonatomic,strong)NSString *company;
@property (nonatomic,strong)NSString *shortCompary;
@property (nonatomic,strong)NSString *device;//下发的设备
@property (nonatomic,assign)float lon;
@property (nonatomic,assign)float lat;
@property (nonatomic,retain)NSString *pic;//头像

+ (instancetype)getInstance;

@end
