//
//  SdSpsPay.m
//  moniJiuZhangApp
//
//  Created by tianNanYiHao on 2017/8/1.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "SandbaoSpsSDK.h"
#import <UIKit/UIKit.h>

#define SAND_SCHEMES @"com.sand.sandbao"
#define JZ_SCHEMES   @"moniJiuZhangApp"


@implementation SandbaoSpsSDK


+(void)jumpToSandBaoForPay:(NSString*)TNnumber{
    
    //跳转杉德宝
    //    NSString *urlStr = @"com.sand.sandbao://TN:2094032421?moniJiuZhangApp";
    NSString *urlStr = [NSString stringWithFormat:@"%@://TN:%@?%@",SAND_SCHEMES,TNnumber,JZ_SCHEMES];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    UIApplication *application = [UIApplication sharedApplication];
    
    
    if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
        [application openURL:url options:@{} completionHandler:^(BOOL success) {
            if (success) {
                NSLog(@"打开成功");
            }else{
                NSLog(@"打开失败");
            }
        }];
    }else if([application canOpenURL:url]){
        [application openURL:url];
    }
}


//判断是否可以打开久彰app
+(BOOL)canOpenUrl:(NSURL*)url{
    
    if ([url.absoluteString containsString:JZ_SCHEMES]) {
        return YES;
    }
    return NO;
}

//回跳后获取回跳信息,返回block
+(BOOL)jumpBackPayInfo:(NSURL*)url infoBlock:(SdSpsPayBack)block{
    
    //sps启动回调
    if ([url.absoluteString containsString:JZ_SCHEMES]) {
        
        NSString *urlStr = [NSString stringWithFormat:@"%@",url];
        NSArray *arr = [urlStr componentsSeparatedByString:@"://"];
        NSString *newStr = [arr lastObject];
        
        if ([newStr isEqualToString:@"paySussess"]) {
            newStr = @"支付成功";
        }else if ([newStr isEqualToString:@"notPyaSuccess"]){
            newStr = @"支付失败";
        }
        
        block(newStr);
        return YES;
    }
    return nil;

}


@end
