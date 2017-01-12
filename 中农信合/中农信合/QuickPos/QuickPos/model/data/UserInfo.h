//
//  UserInfo.h
//  QuickPos
//
//  Created by 胡丹 on 15/3/20.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseData.h"

@interface UserInfo : BaseData

@property(nonatomic,retain)NSString *attention;//
@property(nonatomic,retain)NSString *authenFlag;//实名认证状态
@property(nonatomic,retain)NSString *businessLicence;//营业执照
@property(nonatomic,retain)NSString *certPid;//证件号码
@property(nonatomic,retain)NSString *customerAddr;//客户地址
@property(nonatomic,retain)NSString *customerId;//客户ID
@property(nonatomic,retain)NSString *customerName;//客户名
@property(nonatomic,retain)NSString *customerType;//客户类型
@property(nonatomic,retain)NSString *email;//邮件地址
@property(nonatomic,retain)NSString *realName;//真实姓名
@property(nonatomic,retain)NSString *remark;//备注
@property(nonatomic,retain)NSString *pic;//头像

@end
