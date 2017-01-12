//
//  NSJSONSerialization+Json.m
//  daojishi
//
//  Created by huazi on 14-7-21.
//  Copyright (c) 2014年 huifu. All rights reserved.
//

#import "NSJSONSerialization+Json.h"

@implementation NSJSONSerialization (Json)
+(id)returnObjectWithJsonStr:(NSString *)str
{
    NSData *data =[str dataUsingEncoding:NSUTF8StringEncoding];
    id object =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    return object;
}
+(NSString *)returnJsonStrWithObject:(id)object
{
    NSData *jsonObject  =[NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:nil];
    NSString *str1 =[[NSString alloc] initWithData:jsonObject encoding:NSUTF8StringEncoding];
    return str1;
}
@end
