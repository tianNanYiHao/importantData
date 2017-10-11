//
//  address.m
//  kvcDemo
//
//  Created by tianNanYiHao on 2017/10/9.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "sdaddress.h"

@implementation sdaddress

+ (NSMutableDictionary*)addressDict{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setValue:@"" forKey:@"street"];
    [dict setValue:@"" forKey:@"city"];
    [dict setValue:@"" forKey:@"country"];
    return dict;
}

@end
