//
//  OriginQueryViewController.m
//  QuickPos
//
//  Created by Jessie on 16/5/10.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "OriginQueryViewController.h"
#import "SDCycleScrollView.h"
#import "DDMenuController.h"
#import "QuickPosTabBarController.h"
#import "FoodDataViewController.h"
#import "FoodInFormationViewController.h"
#import "FoodQueryViewController.h"
#import "Common.h"
#import "LoginViewController.h"
#import "AuthenticationEnterpriseViewController.h"
#import "CertificationGoodsViewController.h"
//#import "ScanCodeViewController.h"
#import "Common.h"
#import "ScanViewController.h"
#import "Request.h"
#import "AuthenticationDeviceViewController.h"


#import "SubLBXScanViewController.h"
#import "LBXScanWrapper.h"
#define ENTERPRISE_URL @"http://shfda.org/data/showdatamobile.do?menu-id=enterprise"
#define PRODUCT_URL @"http://shfda.org/data/showdatamobile.do?menu-id=product"

#import "ManualSearchSYViewController.h"

@interface OriginQueryViewController ()<SDCycleScrollViewDelegate,ResponseData>
{
    Request *_req;
    UIWebView *QRCodeView;
    
}
@property (weak, nonatomic) IBOutlet UIButton *commodityInquireBtn;//溯源查询btn

@property (weak, nonatomic) IBOutlet UIButton *commodityTraceBtn;//追溯数据btn

@property (weak, nonatomic) IBOutlet UIButton *commodityPublicBtn;//信息公开btn

@property (nonatomic,strong) NSString *UrlStr1;//拼接条形码网址所用的
@property (nonatomic,strong) NSString *UrlStr2;//拼接条形码网址所用的
@property (nonatomic,strong) NSString *UrlStr3;//拼接条形码网址所用的
@property (nonatomic,strong) NSString *UrlStr4;//拼接条形码网址所用的

@end

@implementation OriginQueryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"溯源查询";
    
    self.commodityInquireBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.commodityTraceBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.navigationController.navigationBar.tintColor = [Common hexStringToColor:@"#0778f8"];//返回键颜色
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor ];//导航栏颜色
    
    
    self.navigationController.navigationBar.contentMode = UIViewContentModeScaleAspectFit;
    //设置标题颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:  [UIColor blackColor], UITextAttributeTextColor,
                                                                     [UIFont systemFontOfSize:17], UITextAttributeFont,
                                                                     nil]];
    
    [self creatRightBtn];

}

//右上角 rightBtn
- (void)creatRightBtn
{
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightBtn setImage:[UIImage imageNamed:@"serve_more"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    //    [rightBtn release];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)rightBtn:(UIButton *)btn
{
    [(DDMenuController*)[(QuickPosTabBarController*)self.tabBarController parentCtrl] showRightController:YES];
    
}



//商品企业
- (IBAction)CommodityInquire:(UIButton *)sender {
    //登陆判断
    if ([[AppDelegate getUserBaseData].mobileNo length] > 0) {
        //已经登陆
        
        AuthenticationEnterpriseViewController *AuthenticaionVC = [[AuthenticationEnterpriseViewController alloc]init];
        AuthenticaionVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:AuthenticaionVC animated:YES];
    }else{
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *login = [storyBoard instantiateViewControllerWithIdentifier:@"QuickPosNavigationController"];
        [self presentViewController:login animated:YES completion:nil];
    }
}


//溯源商品
- (IBAction)CommodityTrace:(UIButton *)sender {
    //登陆判断
    if ([[AppDelegate getUserBaseData].mobileNo length] > 0) {
        //已经登陆
        CertificationGoodsViewController *certificationVC = [[CertificationGoodsViewController alloc]init];
        certificationVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:certificationVC animated:YES];
        
    }else{
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *login = [storyBoard instantiateViewControllerWithIdentifier:@"QuickPosNavigationController"];
        [self presentViewController:login animated:YES completion:nil];
    }
    
}
//扫一扫
- (IBAction)CommodityPublic:(UIButton *)sender {
    NSLog(@"扫一扫");
    
    if ([self validateCamera]) {
        [self createZFBStyle];
    }else{
        [Common pstaAlertWithTitle:@"提示" message:@"请检查摄像头" defaultTitle:@"" cancleTitle:@"取消" defaultBlock:^(id defaultBlock) {
        } CancleBlock:^(id cancleBlock) {
        } ctr:self];
    }

    
}
#pragma mark - 仿支付宝扫码(style设置)
-(void)createZFBStyle{
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc] init];
    style.centerUpOffset = 60;
    style.xScanRetangleOffset = 30;
    
    if ([UIScreen mainScreen].bounds.size.height <= 480) {
        //如果是3.5inch 显示的扫码缩小
        style.centerUpOffset = 40;
        style.xScanRetangleOffset = 20;
    }
    
    style.alpa_notRecoginitonArea = 0.6;
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Inner;
    style.photoframeLineW = 2.0;
    style.photoframeAngleW = 16;
    style.photoframeAngleH = 16;
    
    
    style.isNeedShowRetangle = NO;
    style.anmiationStyle = LBXScanViewAnimationStyle_NetGrid;
    //使用的支付宝里面网格图片
    UIImage *imgFullNet = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_full_net"];
    style.animationImage = imgFullNet;
    [self openScanVCWithStyle:style];
    
}
#pragma  mark - 跳转扫码
- (void)openScanVCWithStyle:(LBXScanViewStyle*)style
{
    SubLBXScanViewController *vc = [SubLBXScanViewController new];
    vc.style = style;
    vc.isOpenInterestRect = YES;//区域识别效果
    
    vc.isQQSimulator = YES; //qq功能预写了一些功能按钮 (相册/闪光/二维码按钮)
    vc.isVideoZoom = YES; //增加缩放功能
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    [vc actionDoSomeThing:^(LBXScanResult *info) {
        
        NSLog(@"%@",info);
        
        ScanViewController *scanVIew = [[ScanViewController alloc] init];
        [NSCharacterSet decimalDigitCharacterSet];
        
        if ([info.strScanned stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]].length > 0) {//判断info.strScanned不是纯数字
            
            BOOL ret1 = [info.strScanned hasPrefix:@"http://stfic.com"];
            if (ret1) {
                //说明是
                scanVIew.scanCode = info.strScanned;
//                [self.navigationController pushViewController:scanVIew animated:YES];
                
            }else {

            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"二维码格式错误" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [alert show];
                
            }
        }else{//info.strScanned 是纯数字
            NSString *UrlStr1 = @"http://shfda.org/c/p-";
            NSString *UrlStr3 = @".html?";
            NSString *UrlStr4 = @"longitude=121.627536&latitude=31.250526&scanType=barcode&type=EAN_13&address=%E4%B8%8A%E6%B5%B7%E5%B8%82%E9%87%91%E8%B1%AB%E8%B7%AF818%E5%8F%B7&city=%E4%B8%8A%E6%B5%B7%E5%B8%82";
            NSString  *UrlStr2 = info.strScanned;
            
            NSString *stringValue = [NSString stringWithFormat:@"%@%@%@%@",UrlStr1,UrlStr2,UrlStr3,UrlStr4];
            NSLog(@"%@  %@",stringValue,info.strScanned);
            scanVIew.scanCode = stringValue;
            
        }
        
        [self.navigationController pushViewController:scanVIew animated:YES];
        
    }];
}


- (BOOL)validateCamera {
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] &&
    [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}


- (IBAction)NFCInduction:(id)sender {//NFC感应
    
//    AuthenticationDeviceViewController *AuthenticationDeviceVc = [[AuthenticationDeviceViewController alloc]init];
//    
//    [self.navigationController pushViewController:AuthenticationDeviceVc animated:YES];
//    
    
    [Common showMsgBox:nil msg:@"正在建设中..." parentCtrl:self];
}

- (IBAction)ManualInput:(id)sender {//手动输入
    
    ManualSearchSYViewController *v = [[ManualSearchSYViewController alloc] initWithNibName:@"ManualSearchSYViewController" bundle:nil];
    v.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:v animated:YES];
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

@end
