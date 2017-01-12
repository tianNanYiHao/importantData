//
//  UserBaseData.m
//  QuickPos
//
//  Created by 胡丹 on 15/3/23.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "UserBaseData.h"


@implementation UserBaseData

@synthesize mobileNo,token,userName,userType,company,customerService,customerId;
@synthesize download,shortCompary,website, device, email, pic;


+ (instancetype)getInstance{
    if (!userBaseData) {
        userBaseData = [[UserBaseData alloc] init];
    }
    return userBaseData;
}

- (instancetype)initWithData:(NSDictionary *)dict{
    self = [super initWithData:dict];
    if (self) {
        self.mobileNo = [dict objectForKey:@"mobileNo"];
        [[NSUserDefaults standardUserDefaults] setObject:self.mobileNo forKey:@"mobileNo"];
        self.token = [dict objectForKey:@"token"];
        [[NSUserDefaults standardUserDefaults] setObject:self.token forKey:@"token"];
        self.userName = [dict objectForKey:@"userName"];
        self.userType = [dict objectForKey:@"userType"];
        self.customerId = [dict objectForKey:@"customerId"];
        self.pic = [dict objectForKey:@"pic"];
        self.device = [[[dict objectForKey:@"data"] objectForKey:@"agreementInfo"]objectForKey:@"posDevice"];
    }
    return self;
}


@end
