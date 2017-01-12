//
//  SweepViewController.m
//  QuickPos
//
//  Created by caiyi on 16/1/6.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "SweepViewController.h"
#import "SubLBXScanViewController.h"
#import "LBXScanWrapper.h"
#import "Request.h"
#import "RechargeViewController.h"


@interface SweepViewController ()<ResponseData>
{
    UITableView *_tableView;
    
    Request *request;
    
    NSMutableArray *ordMarkArr;
    
    
}


@property (nonatomic,strong) NSString *QRCodeAmt;


@end

@implementation SweepViewController
@synthesize item;




- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫码支付";
    self.view.backgroundColor = [UIColor whiteColor];
    
    request = [[Request alloc]initWithDelegate:self];
    _QRCodeAmt = [[NSString alloc]init];

}


- (IBAction)sweepPay:(id)sender {
    
    
    NSLog(@"扫一扫");
    
    if ([self validateCamera]) {
        [self createZFBStyle];
    }else{
        [Common pstaAlertWithTitle:@"提示" message:@"请检查摄像头" defaultTitle:@"" cancleTitle:@"取消" defaultBlock:^(id defaultBlock) {
        } CancleBlock:^(id cancleBlock) {
        } ctr:self];
    }

    [request queryScanMoneyWithOrderNo:_orderNo];
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RechargeViewController *rechargeVc = [mainStoryboard instantiateViewControllerWithIdentifier:@"RechargeViewVC"];
    rechargeVc.hidesBottomBarWhenPushed = YES;
    
    rechargeVc.titleNmae = @"扫码支付";
    rechargeVc.moneyTitle = @"输入充值金额";
    rechargeVc.comfirBtnTitle = @"确认充值";
    rechargeVc.orderRemark = _orderNo;//扫码订单号
    rechargeVc.moneyTitle = _QRCodeAmt;
    NSLog(@"%@  %@",rechargeVc.moneyTitle,_QRCodeAmt);
    [self.navigationController pushViewController:rechargeVc animated:YES];

    
}

- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type
{
     NSLog(@"%@",dict);
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (type == REQUSET_QUERYSCANMONEY) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        
        NSDictionary *dataDict = [dict objectForKey:@"data"];
        if([[[dataDict objectForKey:@"REP_HEAD"]objectForKey:@"TRAN_CODE" ] isEqualToString:@"000000"]){
           
            
            
        _QRCodeAmt = [NSString stringWithFormat:@"%li",[[[dataDict objectForKey:@"REP_BODY"]objectForKey:@"ordAmt"] longValue]/100];
            
        NSLog(@"%@",[dataDict objectForKey:@"REP_BODY"]);
            
        NSLog(@"%@",_QRCodeAmt);
            
        }
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
    [self.navigationController pushViewController:vc animated:YES];
}
- (BOOL)validateCamera {
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] &&
    [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
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
