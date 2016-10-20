//
//  LFFStringarr.m
//  LFFStringArray
//
//  Created by Lff on 16/10/14.
//  Copyright © 2016年 Lff. All rights reserved.
//

#import "LFFStringarr.h"
@interface LFFJieFengCompenyInfo ( )
{
    
}
@end
@implementation LFFJieFengCompenyInfo

+(NSArray*)makeStringArrar{

    NSString *path = [[NSBundle mainBundle] pathForResource:@"捷丰商户" ofType:@"txt"];
    
    NSString *string = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];

    NSArray *arr = [string componentsSeparatedByString:@"\n"];
    
    NSLog(@"%ld",arr.count);
    
    return arr;
}
@end








@implementation LFFStringarr
-(LFFJieFengCompenyInfo*)getJieFengCompenyInfoModel{
    
    LFFJieFengCompenyInfo *model = [[LFFJieFengCompenyInfo alloc] init];
      model.arrJFNO = [NSMutableArray arrayWithCapacity:0];
      model.arrJFKey = [NSMutableArray arrayWithCapacity:0];
      model.arrJFName = [NSMutableArray arrayWithCapacity:0];
    
    NSArray *arr = [NSArray array];
    arr = [LFFJieFengCompenyInfo makeStringArrar];
        for (int i = 0; i<arr.count; i++) {
            if ((i+1)%4 == 1) {     //商户号
                if ([arr[i] rangeOfString:@"生产商户号："].location == !NSNotFound ) {
                    NSArray *arrjf =  [arr[i] componentsSeparatedByString:@"："];
                    [model.arrJFNO addObject:arrjf[1]];
                }
            }
            if ((i+1)%4 == 2) {    //商户名
                if ([arr[i] rangeOfString:@"生产商户名称："].location == !NSNotFound ) {
                    NSArray *arrjf =  [arr[i] componentsSeparatedByString:@"："];
                     [model.arrJFName addObject:arrjf[1]];
                }
            }
            if ((i+1)%4 == 3) {   //商户Key
                if ([arr[i] rangeOfString:@"生产商户密钥："].location == !NSNotFound ) {
                    NSArray *arrjf =  [arr[i] componentsSeparatedByString:@"："];
                    [model.arrJFKey addObject:arrjf[1]];
                }
            }
            if ((i+1)%4 == 0) {   //空行
            }
        }
    return model;
}

@end
