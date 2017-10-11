//
//  userInfo.h
//  kvcDemo
//
//  Created by tianNanYiHao on 2017/10/9.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sdaddress.h"
#import "sdlinks.h"



@interface userInfo : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *page;
@property (nonatomic, strong) NSString *isNonProfit;

@property (nonatomic, strong) sdaddress *address;
@property (nonatomic, strong) sdlinks *links;


+ (NSMutableDictionary*)userInfoDict;




@end
