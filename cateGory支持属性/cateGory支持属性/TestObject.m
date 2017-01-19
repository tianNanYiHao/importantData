//
//  TestObject.m
//  cateGory支持属性
//
//  Created by Lff on 17/1/19.
//  Copyright © 2017年 Lff. All rights reserved.
//

#import "TestObject.h"

@implementation _TestObject

-(NSString*)logYouInfo{
    _name = @"Lff";
    _age = @"26";
    NSLog(@"%@ === %@",_name,_age);
    return nil;
    
    
}
@end
