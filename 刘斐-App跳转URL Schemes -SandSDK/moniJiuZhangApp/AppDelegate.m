//
//  AppDelegate.m
//  moniJiuZhangApp
//
//  Created by tianNanYiHao on 2017/7/10.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "SandbaoSpsSDK.h"
@interface AppDelegate ()<UIAlertViewDelegate>
{
    UIView *viw;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    
    return YES;
}

#pragma mark 9.0之前
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    if ([SandbaoSpsSDK canOpenUrl:url]) {
        return  [SandbaoSpsSDK jumpBackPayInfo:url infoBlock:^(NSString *urlStr) {
            NSLog(@"%@",urlStr);
            [viw removeFromSuperview];
            UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"提示" message: urlStr delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [view show];
        }];
    }
    
    return nil;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation{
    
    if ([SandbaoSpsSDK canOpenUrl:url]) {
        return  [SandbaoSpsSDK jumpBackPayInfo:url infoBlock:^(NSString *urlStr) {
            NSLog(@"%@",urlStr);
            [viw removeFromSuperview];
            UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"提示" message: urlStr delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [view show];
        }];
    }
    
    return nil;
}

//接受微博或微信等各类App的起调
#pragma mark 9.0之后
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    
    
    if ([SandbaoSpsSDK canOpenUrl:url]) {
        return  [SandbaoSpsSDK jumpBackPayInfo:url infoBlock:^(NSString *urlStr) {
            NSLog(@"%@",urlStr);
            [viw removeFromSuperview];
            UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"提示" message: urlStr delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [view show];
        }];
    }
    
    return nil;
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    
    viw = [[UIView alloc] initWithFrame:_window.bounds];
    viw.layer.contents = (__bridge id)[UIImage imageNamed:@"LaunchImage"].CGImage;
    [_window addSubview:viw];

}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
