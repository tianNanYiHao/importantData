//
//  AppDelegate.m
//  MQTTSDKLearn
//
//  Created by Vie on 2017/3/3.
//  Copyright © 2017年 Vie. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "MQTTClientManager.h"

#define AFTER_8_0   [[[UIDevice currentDevice] systemVersion] floatValue]>=8.0

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ViewController *view=[[ViewController alloc] init];
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:view];
    self.window.rootViewController=nav;
    [self.window makeKeyAndVisible];
    
    [self registerRemoteNotification];
   
    return YES;
}

//注册推送通知
-(void)registerRemoteNotification{
    // iOS8 下需要使用新的 API
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType myTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }else {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound];
    }
}
// 在 iOS8 系统中，还需要添加这个方法。通过新的 API 注册推送服务
-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    [application registerForRemoteNotifications];
}

//注册推送服务成功获取deviceToken
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    //官方文档上建议开发者在每次启动应用时应该都向APNS获取device token并上传给服务器。
    //处理空格和<>
    NSString *deviceTokenString=[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""] stringByReplacingOccurrencesOfString: @">" withString: @""]stringByReplacingOccurrencesOfString: @" " withString: @""];
    NSLog(@"deviceToken：%@",deviceTokenString);
    
    //token给服务器
    [[MQTTClientManager shareInstance] pushDeviceToken:deviceTokenString block:^(BOOL flag) {
        if (flag) {
            NSLog(@"----token传送成功----");
        }else{
            //这里token传送失败或者有变更都需要重新提交
            NSLog(@"----token传送失败----");
        }
    }];
    
}
//注册推送服务失败
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"注册推送通知失败：%@",[error.userInfo valueForKey:@"NSLocalizedDescription"]);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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
