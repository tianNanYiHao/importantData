    //
//  Pos.m
//  PosDemo
//
//  Created by 糊涂 on 14/12/19.
//  Copyright (c) 2014年 yoolink. All rights reserved.
//

#import "Pos.h"
@implementation Pos
@synthesize delegate;
@synthesize mVcom;

- (id)initWithDelegate:(NSObject<PosResponse> *)delegate_{
    NSLog(@"initIRonSDK");
    self = [super init];
    if (self) {
        delegate = delegate_;
    }
    return self;
}

- (void)startWithData:(NSDictionary*)data {
    [Log show:@"start"];
}

- (void)connect {
    [Log show:@"connect"];
}

- (void)stop {
    [Log show:@"stop"];
}

- (void)close {
    [Log show:@"close"];
}

- (BOOL)hasHeadset{
    [Log show:@"检查是否插入耳机"];
    return NO;
}

// int数值转16进制数值 返回16进制表示的字符串,可定义长度,不足补0
- (NSString*) intToHexString:(int)num lenght:(int)lenght{
    NSString *format = [NSString stringWithFormat:@"%%0%iX",lenght];
    return [NSString stringWithFormat:format,num];
}

- (void)posResponseDataWithCardInfoModel:(CardInfoModel*)cardInfo
{
    NSLog(@"卡信息 ----> %@",cardInfo.cardInfo);
}
//
//- (void)onDeviceKind:(int)type{
//
//}

@end
