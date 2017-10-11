//
//  links.m
//  kvcDemo
//
//  Created by tianNanYiHao on 2017/10/9.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "sdlinks.h"

@implementation sdlinks


+ (NSMutableDictionary*)linksDict{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    
    [dict setValue:@"" forKey:@"name"];
    [dict setValue:@"" forKey:@"url"];
    
    return dict;
}

@end
