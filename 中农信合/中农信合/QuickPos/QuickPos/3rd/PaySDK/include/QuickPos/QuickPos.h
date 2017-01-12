//
//  QuickPos.h
//  QuickPos
//
//  Created by 糊涂 on 15/3/18.
//  Copyright (c) 2015年 hutu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuickPos : NSObject


//用户密码加密及卡密码加密,为用户密码加密时type为NO,为卡密码加密时,type为YES
- (NSString *)enCodeWithData:(NSString*)data enCodeType:(BOOL)type account:(NSString*)account;
// 无卡支付信息加密
- (NSString *)enCodeWithName:(NSString*)name IDCard:(NSString*)IDCard cardNo:(NSString*)cardNo vaild:(NSString*)vaild cvv2:(NSString*)cvv2 phone:(NSString*)phone ;
@end
