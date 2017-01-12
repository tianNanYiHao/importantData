//
//  BaseData.m
//  QuickPos
//
//  Created by 胡丹 on 15/3/20.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "BaseData.h"

@implementation BaseData

- (instancetype)initWithData:(NSDictionary*)dict{
    self = [super init];
    if (self) {
        self.respCode = [dict objectForKey:@"respCode"];
        self.respDesc = [dict objectForKey:@"respDesc"];
    }
    return self;
}

@end
