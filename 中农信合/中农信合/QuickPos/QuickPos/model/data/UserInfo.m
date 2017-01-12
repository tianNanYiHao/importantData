//
//  UserInfo.m
//  QuickPos
//
//  Created by 胡丹 on 15/3/20.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

- (instancetype)initWithData:(NSDictionary*)dict{
    self = [super initWithData:dict];
    if (self) {
        self.attention = [dict objectForKey:@"attention"];
        self.authenFlag = [dict objectForKey:@"authenFlag"];
        self.businessLicence = [dict objectForKey:@"businessLicence"];
        self.certPid = [dict objectForKey:@"certPid"];
        self.customerAddr = [dict objectForKey:@"customerAddr"];
        self.customerId = [dict objectForKey:@"customerId"];
        self.customerType = [dict objectForKey:@"customerType"];
        self.email = [dict objectForKey:@"email"];
        self.realName = [dict objectForKey:@"realName"];
        self.remark = [dict objectForKey:@"remark"];
        self.pic = [dict objectForKey:@"pic"];
    }
    return self;
    
}

@end
