//
//  SetupViewController.m
//  QuickPos
//
//  Created by 胡丹 on 15/3/13.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "SetupViewController.h"
#import "QuickPosTabBarController.h"
#import "ShareView.h"
#import "VersionView.h"
#import "ContractView.h"
#import "ClearUpView.h"
#import "Request.h"
#import "MBProgressHUD+Add.h"
#import "WebViewController.h"
#import "DDMenuController.h"
#import "Common.h"
#import "InstructionsForUseViewController.h"

#define SETUPCTRLX 50
#define SETUPCTRLY 50


typedef enum : NSUInteger {
    ShareType = 0,//分享
    FAQType,//FAQ
    ClearType,//清理缓存
    TipsType,//意见和反馈
    ContractType,//联系我们
    VersionType,//版本信息
    OperationType,//操作手册
} SetupType;


@interface SetupViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,ResponseData,UMSocialUIDelegate,UMSocialDataDelegate>{
    CGRect originFrame;
    NSString *customerService;
    NSString *shortCompary;
    NSString *website;
    NSString *company;
    NSString *client_version;
    MBProgressHUD *hud;
    
}
@property(strong,nonatomic)NSMutableArray *setupArr;
@property(strong,nonatomic)NSMutableArray *setupImgArr;

@end

@implementation SetupViewController

-(void)viewWillLayoutSubviews{
    if (self.view.frame.origin.x == 0) {
        self.view.frame = originFrame;
    }

}

-(void)viewWillAppear:(BOOL)animated{
    if (self.view.frame.origin.x != 0) {
        originFrame = self.view.frame;
    }else{
        self.view.frame = originFrame;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    // Do any additional setup after loading the view.
    self.setupArr = [NSMutableArray arrayWithObjects:L(@"Share"),L(@"FAQ"),L(@"ClearCache"),L(@"CommentsAndFeedback"),L(@"ContactUs"),L(@"Version"),nil];
//    self.setupImgArr = [NSMutableArray arrayWithObjects:@"share",@"FAQ",@"qingli",@"yijian",@"lianxi",@"yonghu",nil];
    originFrame = self.view.frame;
//    [[[Request alloc] initWithDelegate:self] userAgreement];
//    hud = [MBProgressHUD showMessag:@"正在加载。。" toView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



+ (void)showSetupController:(id)ctrl{
    
    UIViewController *c = (UIViewController*)ctrl;
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SetupViewController *setuser = [main instantiateViewControllerWithIdentifier:@"SetupViewController"];
    
    CATransition *catran = [CATransition animation];
    catran.type = kCATransitionPush;
    catran.subtype = kCATransitionFromRight;
    catran.duration = 0.5f;
    
    [setuser.view.layer addAnimation:catran forKey:Nil];
    setuser.view.frame = CGRectMake(SETUPCTRLX,SETUPCTRLY, setuser.view.frame.size.width, setuser.view.frame.size.height);
    [c addChildViewController:setuser];
    [[c view] addSubview:setuser.view];
    

}

#pragma mark - TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.setupArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
//    cell.imageView.image = [UIImage imageNamed:self.setupImgArr[indexPath.row]];
    cell.textLabel.text = self.setupArr[indexPath.row];
    cell.textLabel.textColor = [UIColor colorWithRed:215/255.0 green:215/255. blue:215/255. alpha:1.0];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

#pragma mark - TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor darkGrayColor];
    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //    cell.alpha = 0.5;
    switch (indexPath.row) {
        case ShareType:{
        [Common showMsgBox:nil msg:@"正在建设中.." parentCtrl:self];
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"gestureRecognizer" object:nil];
        }
            break;
        case FAQType:{
            [Common showMsgBox:nil msg:@"正在建设中.." parentCtrl:self];
        }
            break;
        case ClearType:{
//                        [ClearUpView showVersionView:self];
//                        [Common showMsgBox:@"清理缓存" msg:@"清理缓存将删您的账号信息，您确定要这样做吗？" parentCtrl:self];
            
            
            PSTAlertController *gotoPageController = [PSTAlertController alertWithTitle:@"" message:@"清理缓存将删除您的账号信息，您确定要这样做吗？"];
            [gotoPageController addAction:[PSTAlertAction actionWithTitle:@"确定" handler:^(PSTAlertAction *action) {
                
                dispatch_async(
                               dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                               , ^{
                                   NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                                   [ud removeObjectForKey:@"intro_screen_viewed"];
                                   [ud synchronize];
                                   NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
                                   
                                   NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                                   NSLog(@"files :%d",[files count]);
                                   for (NSString *p in files) {
                                       NSError *error;
                                       NSString *path = [cachPath stringByAppendingPathComponent:p];
                                       if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                                           [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                                       }
                                   }
                                   [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];});
                
                
            }]];
            [gotoPageController addAction:[PSTAlertAction actionWithTitle:@"取消" style:PSTAlertActionStyleCancel handler:^(PSTAlertAction *action) {
                
            
                
            }]];
            [gotoPageController showWithSender:nil controller:self animated:YES completion:NULL];
        }
            break;
        case TipsType:{
            
            [Common showMsgBox:nil msg:@"建设中.." parentCtrl:self];
//            AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//            NSString *url;
//            if ([[[delegate getConfigDic] objectForKey:@"website"]hasPrefix:@"http"]) {
//                url = [NSString stringWithFormat:@"%@",[[delegate getConfigDic] objectForKey:@"website"]];
//            }else{
//                url = [NSString stringWithFormat:@"http://%@",[[delegate getConfigDic] objectForKey:@"website"]];
//            }
//            
//            WebViewController *web = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"WebViewController"];
//            web.url = url;
//            web.navigationItem.title = L(@"CommentsAndFeedback");
//            DDMenuController *menuController = (DDMenuController*)[QuickPosTabBarController getQuickPosTabBarController].parentCtrl;
//            
//            UITabBarController *tb = (UITabBarController*)[menuController rootViewController];
//            UINavigationController *ctr = (UINavigationController*)[tb selectedViewController];
//            [menuController showRootController:YES];
//            UIViewController *ctrl = [ctr visibleViewController];
//            [web setHidesBottomBarWhenPushed:YES];
//            [[ctrl navigationController] pushViewController:web animated:YES];
        }
            
            break;
        case ContractType:{
            [ContractView showVersionView:self];
            //            ContractView *contract = [[ContractView alloc]init];
            //            [self.view addSubview:contract];
            //
            //            [self presentViewController:contract animated:NO completion:^{
            //
            //            }];
            //
            //            if(iOS8){
            //
            //                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"联系我们" message:@"公司网址：http://www.jiefengpay.com 客服电话：400-008-1655" preferredStyle:UIAlertControllerStyleAlert];
            //                UIAlertAction* defaultAction1 = [UIAlertAction actionWithTitle:@"访问官网" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            //                    //访问官网
            //                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.jiefengpay.com"]];
            //                }];
            //                UIAlertAction* defaultAction2 = [UIAlertAction actionWithTitle:@"拨打电话" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            //                    NSString *telUrl = @"telephone:400-008-1655";
            //                    NSURL *url = [[NSURL alloc] initWithString:telUrl];
            //                    [[UIApplication sharedApplication] openURL:url];
            //                }];
            //
            //                UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
            //                }];
            //
            //                [alert addAction:defaultAction1];
            //                [alert addAction:defaultAction2];
            //                [alert addAction:cancelAction];
            //                [self presentViewController:alert animated:YES completion:nil];
            //            
            //            }else{
            //            
            //                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"联系我们" message:@"公司网址：http://www.jiefengpay.com 客服电话:400-008-1655" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"访问官网",@"拨打电话", nil];
            //                alert.tag = ContractType;
            //                [alert show];
            //                
            //            }
            //            
        }
            break;
        case VersionType:{
            [VersionView showVersionView:self];
        }
            break;
        default:
            break;
    }
    
}


-(void)clearCacheSuccess
{
    NSLog(@"清理成功");
    [Common showMsgBox:nil msg:L(@"CleanComplete") parentCtrl:self];
    
}

#pragma mark ------分享--------
//弹出列表方法presentSnsIconSheetView需要设置delegate为self
-(BOOL)isDirectShareInIconActionSheet
{
    return YES;
}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}


#pragma mark ------网络数据返回

- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    [hud hide:YES];
    if (type == REQUEST_USERAGREEMENT && [@"0000" isEqualToString:[dict objectForKey:@"respCode"]]) {
        NSString *device = [[[dict objectForKey:@"data"] objectForKey:@"agreementInfo"] objectForKey:@"posDevice"];
        website = [dict objectForKey:@"website"];
        customerService = [dict objectForKey:@"customerService"];
        shortCompary = [dict objectForKey:@"shortCompary"];
        company = [dict objectForKey:@"company"];
        client_version = [dict objectForKey:@"client_version"];
        [AppDelegate getUserBaseData].device = device;
  
    }


}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == ClearType) {
        if (buttonIndex == 1) {
            //清理缓存
        }
    }else if(alertView.tag == ContractType){
        if (buttonIndex == 1){
            //访问官网
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.jiefengpay.com"]];
        }else if(buttonIndex == 2){
            //拨打电话
            NSString *telUrl = @"telephone:021-31129501";
            NSURL *url = [[NSURL alloc] initWithString:telUrl];
            [[UIApplication sharedApplication] openURL:url];

        }else{
        }
    }
    

}


@end
