//
//  Log.m
//  PosDemo
//
//  Created by 糊涂 on 14/12/19.
//  Copyright (c) 2014年 yoolink. All rights reserved.
//

#import "Log.h"

@implementation Log


+ (void)show:(NSString *)msg {
    NSString *className = NSStringFromClass([self class]);
    NSLog(@"%@: %@", className, msg);
}

+ (void)Log:(NSString *)msg isShow:(BOOL)show{
    if (show) {
        [Log show:msg];
    }
}

@end
