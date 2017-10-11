//
//  address.h
//  kvcDemo
//
//  Created by tianNanYiHao on 2017/10/9.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface sdaddress : NSObject


@property (nonatomic, strong) NSString *street;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *country;

+ (NSMutableDictionary*)addressDict;


@end
