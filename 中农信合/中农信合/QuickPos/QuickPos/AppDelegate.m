//
//  AppDelegate.m
//  QuickPos
//
//  Created by 张倡榕 on 15/3/11.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "AppDelegate.h"
#import "UserBaseData.h"
#import "PosManager.h"
#import "Request.h"
#import "LocationManager.h"
#import "IQKeyboardManager.h"
#import "MyMessageViewController.h"
#import "Common.h"
#import "QuickPosTabBarController.h"
#import "SetupViewController.h"
#import "DDMenuController.h"
#import <BmobSDK/Bmob.h>
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import <Bugly/Bugly.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//微信SDK头文件
#import "WXApi.h"
//支付宝
#import "APOpenAPI.h"
#import "APOpenAPIObject.h"
#define STOREAPPID @"1141301708"

#define kViewControllerButtonPadding 10
#define kViewControllerButtonHeight 50

@interface AppDelegate ()<ResponseData,UIAlertViewDelegate,UMSocialDataDelegate,UMSocialUIDelegate,JPUSHRegisterDelegate>
{
    //    NSString* versionId;
    NSString* updateUrl;
    NSDictionary *dataDic;
    NSString *later;
}
@property (nonatomic, copy) NSString *versionUrl;
@property (nonatomic, retain)NSDictionary *configDic;

@end
@implementation AppDelegate
@synthesize versionUrl;

- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type {
    if (type == REQUEST_USERAGREEMENT && [@"0000" isEqualToString:[dict objectForKey:@"respCode"]]) {
        
        NSString *device = @"111101";
        
        NSDictionary *agreement = [[dict objectForKey:@"data"] objectForKey:@"agreementInfo"];
        if (agreement && [agreement isKindOfClass:[NSDictionary class]]) {
            device = [agreement objectForKey:@"posDevice"];
            NSDictionary *dic1 = [[dict objectForKey:@"data"] objectForKey:@"agreementInfo"];
            [[AppDelegate getUserBaseData] setWebsite:[dic1 objectForKey:@"website"]];
            [[AppDelegate getUserBaseData] setCustomerService:[dic1 objectForKey:@"customerService"]];
            [[AppDelegate getUserBaseData] setShortCompary:[dic1 objectForKey:@"shortCompary"]];
            [[AppDelegate getUserBaseData] setCompany:[dic1 objectForKey:@"company"]];
            [[AppDelegate getUserBaseData] setEmail:[dic1 objectForKey:@"email"]];
            [[AppDelegate getUserBaseData] setDownload:[dic1 objectForKey:@"download"]];
            self.configDic = [NSDictionary dictionaryWithObjectsAndKeys:[dic1 objectForKey:@"website"],@"website",[dic1 objectForKey:@"customerService"],@"customerService",[dic1 objectForKey:@"shortCompary"],@"shortCompary",[dic1 objectForKey:@"company"],@"company",[dic1 objectForKey:@"client_version"],@"client_version", nil];
            
        }
        //截取蓝牙设备判断一次蓝牙设备。
        NSString *blueToothDev = [device substringWithRange:NSMakeRange(device.length-2, 1)];
        if ([blueToothDev isEqualToString:@"1"]) {
            [[PosManager getInstance] getDevice:@"000010"];
        }
        
        //保存device数据并检测设备是否插入。
        [AppDelegate getUserBaseData].device = device;
        if ([[PosManager getInstance] getPluggedType])
        {
            [[PosManager getInstance] getDevice:device];
        }
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        int def = [[user objectForKey:defDeivecType] intValue];
        if (def <= 0 && def != -99) {
            def = -99;
            [user setObject:[NSNumber numberWithInt:def] forKey:defDeivecType];
            [user synchronize];
        }
        // 这里处理获取的频道信息
        //        [[UserBaseData getInstance] setDevice:device];
        
    }
//    if (type == REQUEST_CLIENTUPDATE && [@"0000" isEqualToString:[dict objectForKey:@"respCode"]]) {
//        
//        if([[dict objectForKey:@"application"] isEqualToString:@"ClientUpdate2.Rsp"]) {
//            return [self handleClientUpdate2:dict];
//        }
//    }
}


#if __IPAD_OS_VERSION_MAX_ALLOWED >= __IPAD_6_0
//- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
//{
//    return UIInterfaceOrientationMaskAll;
//}
#endif

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight );
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

-(void)Jpush:(NSDictionary*)launchOptions{
    //启动JPushSDK
    [JPUSHService setupWithOption:launchOptions appKey:@"fb10b762495e885be4b29433" channel:nil apsForProduction:NO];
    
    //注册通知类型
    //方式一
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    //方式二
//    JPUSHRegisterEntity *entity = [[JPUSHRegisterEntity alloc] init];
//    entity.types = (UIUserNotificationTypeBadge |
//                   UIUserNotificationTypeSound |
//                   UIUserNotificationTypeAlert);
//    entity.categories = nil;
//    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];

}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //一句代码实现检测更新
//    [self hsupdateAppFromAppStore];
    [Bugly startWithAppId:@"900050866"];
    [self Jpush:launchOptions];
    [IQKeyboardManager sharedManager];
    PosManager *pos = [PosManager getInstance];
    [pos posNotification];
    
    //友盟
    //APPkey:57677f6be0f55a8d0a000255
    [UMSocialData setAppKey:@"57677f6be0f55a8d0a000255"];
    
    
    //QQ分享
    //APP ID:1105447450  十六进制:41e3ca1a
    //APP KEY:vTLTaq1I7QYG3OGB
    [UMSocialQQHandler setQQWithAppId:@"1105447450" appKey:@"vTLTaq1I7QYG3OGB" url:@"http://fir.im/bmjfsh"];
    
    //微信
    //AppID：wx61f84348cb1e56e0
    //AppSecret：3c2504ae5dddaa09b8242b604f92dd1e
    [UMSocialWechatHandler setWXAppId:@"wx61f84348cb1e56e0" appSecret:@"3c2504ae5dddaa09b8242b604f92dd1e" url:@"http://fir.im/bmjfsh"];
    
    
    
    
    
    [Bmob registerWithAppKey:@"64631556f023608af2374be183d3a29f"];
    
    
    
    //shareSDK
    [ShareSDK registerApp:@"16d4bfeef4248" activePlatforms:@[
                                                             @(SSDKPlatformTypeWechat),
                                                             @(SSDKPlatformTypeQQ),
                                                             //                            @(SSDKPlatformTypeAliPaySocial)
                                                             ]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class]
                            tencentOAuthClass:[TencentOAuth class]];
                 break;
                 //             case SSDKPlatformTypeAliPaySocial:
                 //                 [ShareSDKConnector connectAliPaySocial:[APOpenAPI class]];
                 //                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeWechat://微信
                 [appInfo SSDKSetupWeChatByAppId:@"wx61f84348cb1e56e0"
                                       appSecret:@"3c2504ae5dddaa09b8242b604f92dd1e"];
                 break;
             case SSDKPlatformTypeQQ://QQ
                 [appInfo SSDKSetupQQByAppId:@"1105447450"
                                      appKey:@"vTLTaq1I7QYG3OGB"
                                    authType:SSDKAuthTypeBoth];
                 break;
                 //             case SSDKPlatformTypeAliPaySocial://支付宝
                 //                 [appInfo SSDKSetupAliPaySocialByAppId:@"2016082501801191"];
                 //                 break;
                 
             default:
                 break;
         }
     }];
    
    
    //    BmobObject *gameScore = [BmobObject objectWithClassName:@"user"];
    //    [gameScore setObject:@"ddddd" forKey:@"content"];
    //    [gameScore saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
    //        //进行操作
    //    }];
    
    //    NSBundle* mainBundle = [NSBundle mainBundle];
    //    versionId = [[mainBundle infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    
    [[[Request alloc] initWithDelegate:self] userAgreement];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];//状态栏白色
    
    if(![UIDevice currentDevice].isIOS6){
        
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];//去除导航返回的文字
        
    }
    
    if(iOS8){
        UIUserNotificationType notificationType = UIUserNotificationTypeBadge | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *notificationSettings = [UIUserNotificationSettings settingsForTypes:notificationType categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
    }else{
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeAlert)];
    }
    return YES;
}



//注册好以后 获取token
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [JPUSHService registerDeviceToken:deviceToken];
}
//当收到远程通知消息时,掉用此方法
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    //这里书写的代码应该可以让程序进入到相关的页面

    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"iOS7及以上系统，收到通知:%@", [self logDic:userInfo]);
    NSString *message = [[userInfo objectForKey:@"aps"]objectForKey:@"alert"];
    [Common showMsgBox:@"提示" msg:message parentCtrl:self.window.rootViewController];
    [[NSUserDefaults standardUserDefaults] setObject:message forKey:@"MsgList"];
}

//注册APNs失败返回
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"APNs注册失败 返回info: %@", error);
}
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}


//
//通知
//-(void)application:(UIApplication *)app didReceiveLocalNotification:(UILocalNotification *)notif {
//
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//
//    MyMessageViewController * myMessageVC = [storyboard instantiateViewControllerWithIdentifier:@"MyMessageViewControllerVC"];
//
//    [(UINavigationController *)self.window.rootViewController pushViewController:myMessageVC animated:YES];
//}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.

    //取消badeg数字
    [application setApplicationIconBadgeNumber: 1];
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
    
}
//禁止横屏==============================================
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskAll;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


+ (UserBaseData*)getUserBaseData{
    if(!userBaseData){
        userBaseData = [UserBaseData getInstance];
    }
    return userBaseData;
}

+(void)setUserBaseData:(UserBaseData*)_userBaseData{
    userBaseData = _userBaseData;
}

-(NSDictionary*)getConfigDic{
    
    return self.configDic;
}

////手动版本更新
//-(void)handleClientUpdate2:(NSDictionary *)respData{
//    NSDictionary *summary = [[respData objectForKey:@"data"] objectForKey:@"summary"];
//    NSString *sVersion = [summary objectForKey:@"version"];
//    NSString *appVersion = [Common getCurrentVersion];
//    int intSV = [[sVersion stringByReplacingOccurrencesOfString:@"." withString:@""] intValue];
//    int intAV = [[appVersion stringByReplacingOccurrencesOfString:@"." withString:@""] intValue];
//    if([sVersion length]!=0 && intSV > intAV) {
//        later = nil;
//        updateUrl = [summary objectForKey:@"updateUrl"];
//        if( [[summary objectForKey:@"must"] isEqualToString:@"y"] ) {
//            later = nil;
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"IsLoginNotification" object:[NSNumber numberWithBool:YES]];
//        }
//        else {
//            later = L(@"Later");
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"IsLoginNotification" object:[NSNumber numberWithBool:NO]];
//        }
//        self.versionUrl = [NSString stringWithString:[summary objectForKey:@"updateUrl"]];
//        
//        NSArray *desc = [respData objectForKey:@"resultBean"];
//        NSMutableArray *s = [NSMutableArray array];
//        
//        [s addObject:L(@"Update")];
//        for (NSDictionary *d in desc) {
//            [s addObject:[d objectForKey:@"updateContent"]];
//        }
//        
//        if(iOS8){
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:L(@"NewVersion") message:[s componentsJoinedByString:@"\n"]  preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:L(@"Confirm") style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
//                //版本更新url
//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:updateUrl]];
//                
//                exit(0);
//                
//            }];
//            if (later != nil) {
//                UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:later style:UIAlertActionStyleCancel handler:nil];
//                [alert addAction:cancelAction];
//            }
//            
//            [alert addAction:defaultAction];
//            [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
//        }else{
//            
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:L(@"NewVersion") message:nil delegate:self cancelButtonTitle:later otherButtonTitles:L(@"Confirm"), nil];
//            //            alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
//            [alert show];
//        }
//    }
//    else {
//        NSLog(@"暂时没有更新!");
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"IsLoginNotification" object:[NSNumber numberWithBool:NO]];
//    }
//}
//
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    
//    
//    if (buttonIndex == 1 || (buttonIndex == 0 && !later)) {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:updateUrl]];
//        exit(0);
//    }
//}


-(void)hsupdateAppFromAppStore{
    //2先获取当前工程项目版本号
    NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion=infoDic[@"CFBundleShortVersionString"];
    AFHTTPSessionManager *manager  = [AFHTTPSessionManager manager];
    manager.requestSerializer =[AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",@"text/javascript",nil];
    NSString *urlStr = [NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@",STOREAPPID];
    [manager POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *array = responseObject[@"results"];
        NSDictionary *dic = array[0];
        NSString *appStoreVersion = dic[@"version"];
        //打印版本号
        NSLog(@"当前版本号:%@\n商店版本号:%@",currentVersion,appStoreVersion);
        //4当前版本号小于商店版本号,就更新
        int intSV = [[currentVersion stringByReplacingOccurrencesOfString:@"." withString:@""] intValue];
        int intAV = [[appStoreVersion stringByReplacingOccurrencesOfString:@"." withString:@""] intValue];
        
        if(intSV < intAV)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"版本有更新" message:[NSString stringWithFormat:@"检测到新版本(%@),是否更新?",appStoreVersion] delegate:self cancelButtonTitle:@"退出App"otherButtonTitles:@"更新",nil];
            [alert show];
            
        }else{
            NSLog(@"版本号好像比商店大噢!检测到不需要更新");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
    }];
}

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //5实现跳转到应用商店进行更新
    if(buttonIndex==1)
    {
        //6此处加入应用在app store的地址，方便用户去更新，一种实现方式如下：
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8", STOREAPPID]];
        [[UIApplication sharedApplication] openURL:url];
    }else{
        exit(0);
    }
}

@end
