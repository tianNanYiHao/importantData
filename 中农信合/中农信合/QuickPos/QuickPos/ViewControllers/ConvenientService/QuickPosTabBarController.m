//
//  QuickPosTabBarController.m
//  QuickPos
//
//  Created by Leona on 15/3/10.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "QuickPosTabBarController.h"
#import "SetupViewController.h"
#import "MBProgressHUD+Add.h"
#import "OrderData.h"
#import "Common.h"
// Constants
#import "StringConstants.h"
#import "OrderReceiptViewController.h"

// Messages
#import "MessageBarManager.h"
#import "LoginViewController.h"

static QuickPosTabBarController *quickTabCtrl;

@interface QuickPosTabBarController ()<UITabBarControllerDelegate,ResponseData,UITabBarDelegate>{
    
    Request *requst;
    NSString *newMsgId;
    NSUserDefaults *userDefaults;
    int counts;
    NSDictionary *dataDic;
    BOOL fristTime;
    UIImage *takImg;
    MBProgressHUD *hud;
}


@end

@implementation QuickPosTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    quickTabCtrl = self;
    self.delegate = self;
    
    
    UIColor *tabItemColor = [Common hexStringToColor:@"47a8ef"];
    
    self.selectedIndex = 0;
    
    fristTime = YES;
    
    if([UIDevice currentDevice].isIOS6){
    
    
    
    
    }else{
        
      self.tabBar.tintColor = tabItemColor;
    
    }
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       tabItemColor, UITextAttributeTextColor,
                                                       nil] forState:UIControlStateSelected];
    
    
    userDefaults = [NSUserDefaults standardUserDefaults];
    
    requst = [[Request alloc]initWithDelegate:self];
    
    //现在不需要登陆后再操作了
//    [self loadRequest];
}

-(void)loadRequest{
    NSString *oldMsgId = [NSString stringWithFormat:@"%@oldMsgId",[AppDelegate getUserBaseData].mobileNo];
    NSString *oldId = [userDefaults objectForKey:oldMsgId];
    if (oldId) {
        [requst msgList:oldId andLastMsgID:@"0" andRequestType:@"02"];
    }
    else
    {
        [requst msgList:@"0" andLastMsgID:@"0" andRequestType:@"02"];
    }
    
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {

    //登陆判断
    if ([[AppDelegate getUserBaseData].mobileNo length] > 0) {
        
        NSInteger index = tabBarController.selectedIndex;
        [self loadRequest];
        
    }else{
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *login = [storyBoard instantiateViewControllerWithIdentifier:@"QuickPosNavigationController"];
        [self presentViewController:login animated:YES completion:nil];
    }

}

-(BOOL)tabBarController:shouldSelectViewController{
    return  YES;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    return  YES;
}


-(void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    [hud hide:YES];
    if ([[dict objectForKey:@"respCode"] isEqualToString:@"0000"]) {
        //消息列表拉去返回
        if (type == REQUSET_MESGLIST) {
            //判断第一次进入此界面。
            if (fristTime == YES) {
                dataDic = [dict objectForKey:@"data"];
                NSArray *msgArr =[NSArray arrayWithArray:[dataDic objectForKey:@"msgList"]];
                newMsgId = [[msgArr firstObject] objectForKey:@"msgID"];
                //判断如果拉去到新消息
                if (msgArr.count != 0) {
                    for (int i = msgArr.count - 1; i >= 0 ; i--) {
                        if ([[msgArr[i] objectForKey:@"hasRemind"] isEqualToString:@"1"]) {
                            UILocalNotification *notification = [[UILocalNotification alloc]init];
                            notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:10.0];
                            notification.soundName=UILocalNotificationDefaultSoundName;
                            notification.alertBody = [msgArr[i] objectForKey:@"msgTitle"];
                            [[UIApplication sharedApplication] scheduleLocalNotification:notification];
                        }
                    }
                    
            
                    NSString *oldMsgId = [NSString stringWithFormat:@"%@oldMsgId",[AppDelegate getUserBaseData].mobileNo];
                    //保存最新消息的Id
                    [userDefaults setObject:newMsgId forKey:oldMsgId];
                }
                fristTime = NO;
            }
        }
        else if (type == REQUEST_USERSIGNATUREUPLOAD) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            OrderReceiptViewController *rv = [[OrderReceiptViewController alloc] init];
            rv.order = self.orderData;
            rv.printInfo = _printInfo;
            rv.signImg = takImg;
            rv.hidesBottomBarWhenPushed = YES;
            [(QuickPosNavigationController*)self.selectedViewController pushViewController:rv animated:YES];
            
        }
        
    }else{
        [MBProgressHUD showHUDAddedTo:self.view WithString:[dict objectForKey:@"respDesc"]];
    }
    /******************************************************************************************/
}


//- (BOOL)application:(UIApplication *)app didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    
//    UILocalNotification *localNotif =
//    
//    [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
//    
//    if (localNotif) {
//        
//        
//    }
//    
//    return YES;
//    
//}

- (void) handsignFinished: (UIImage *) img {
    takImg = img;
    NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(img)];
    
    NSMutableString *handsignString = [NSMutableString stringWithCapacity:([imageData length] * 2)];
    const unsigned char *dataBuffer = (unsigned char *) [imageData bytes];
    for (int i = 0; i < [imageData length]; ++i) {
        [handsignString appendFormat:@"%02X", (unsigned) dataBuffer[i]];
    }
    
    
    NSString *imageHash = [Utils md5WithData:imageData];
    
    NSString *longitude = [NSString stringWithFormat:@"%.2f",[AppDelegate getUserBaseData].lon];
    NSString *latitude = [NSString stringWithFormat:@"%.2f",[AppDelegate getUserBaseData].lat];
    //执行图片上传
    //    Request *req = [[Request alloc]initWithDelegate:self];
    [requst UserSignatureUploadMobile:[AppDelegate getUserBaseData].mobileNo longitude:longitude latitude:latitude merchantId:self.orderData.merchantId orderId:self.orderData.orderId signPicAscii:handsignString picSign:imageHash];
    hud = [MBProgressHUD showMessag:L(@"UploadSignaturePicture") toView:self.view];
    
    
}



+ (QuickPosTabBarController*)getQuickPosTabBarController{
    return quickTabCtrl;
}

- (void)gotoLoginViewCtrl{
    [self.parentCtrl dismissViewControllerAnimated:YES completion:nil];
}

@end
