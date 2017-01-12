//
//  NSJSONSerialization+Json.h
//  daojishi
//
//  Created by huazi on 14-7-21.
//  Copyright (c) 2014年 huifu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSJSONSerialization (Json)
+(id)returnObjectWithJsonStr:(NSString *)str;
+(NSString *)returnJsonStrWithObject:(id)object;
@end
