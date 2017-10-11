//
//  links.h
//  kvcDemo
//
//  Created by tianNanYiHao on 2017/10/9.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface sdlinks : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *url;

+ (NSMutableDictionary*)linksDict;


@end
