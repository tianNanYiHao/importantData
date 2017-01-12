//
//  ShareView.m
//  QuickPos
//
//  Created by 胡丹 on 15/3/19.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "ShareView.h"
#define IconWidth SCREEN_WIDTH/3.0


@implementation ShareView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (void)showShareView:(id)ctrl{
    
//    NSString *textToShare = @"请大家登录《iOS云端与网络通讯》服务网站。";
    
    UIImage *imageToShare = [UIImage imageNamed:@"icon"];
    
//    NSURL *urlToShare = [NSURL URLWithString:@"http://www.iosbook3.com"];
    NSString *url = [[AppDelegate getUserBaseData] download];
    NSString *name = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    if (!url) {
        url = @"";
    }
    NSArray *activityItems = @[name , imageToShare, url];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    
    //不出现在活动项目
    
    activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,
                                         
                                        UIActivityTypeMail];
    
    [(UIViewController*)ctrl presentViewController:activityVC animated:TRUE completion:nil];
}

@end
