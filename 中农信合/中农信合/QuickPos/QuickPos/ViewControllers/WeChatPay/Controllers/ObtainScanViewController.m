 //
//  ObtainScanViewController.m
//  QuickPos
//
//  Created by feng Jie on 16/7/20.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "ObtainScanViewController.h"
#import "Request.h"
#import "DisplayScanViewController.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+Add.h"
#import "Common.h"

@interface ObtainScanViewController ()<ResponseData>
{
    Request *request;
    NSString *merchantId;
    NSString *productId;
    NSString *payTool;
    NSString *scanStrUrl;
    NSMutableArray *resultBeanArray;
}


@property (weak, nonatomic) IBOutlet UITextField *AmtTextField;//金额textField
@property (nonatomic,strong) NSString *orderId;
@property (nonatomic,strong) NSString *orderID;
@property (nonatomic,strong) NSString *psamid;

@property (unsafe_unretained, nonatomic) IBOutlet UIButton *comfirt;


@end

@implementation ObtainScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"微信收款金额";
    request = [[Request alloc]initWithDelegate:self];
    [request quickPayCodeState];
    payTool = @"01";
    merchantId = @"0001000006";
    productId = @"0000000000";
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *tip = [Common tipWithStr:@"手续费:千分之五" color:[UIColor redColor] rect:CGRectMake(0, CGRectGetMaxY(_comfirt.frame)+300, self.view.frame.size.width, 40)];
    [self.view addSubview:tip];
    
}


//确认按钮
- (IBAction)ObtainScan:(id)sender {
    
   
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"正在生成二维码"];
        NSString *Amtstring = [NSString stringWithFormat:@"%.f",self.AmtTextField.text.doubleValue*100];
        NSLog(@"%@",Amtstring);
        
        [request applyOrderMobileNo:[AppDelegate getUserBaseData].mobileNo
                          MerchanId:merchantId
                          productId:productId
                           orderAmt:Amtstring
                          orderDesc:[AppDelegate getUserBaseData].mobileNo
                        orderRemark:@""
                       commodityIDs:@""
                            payTool:payTool
         ];

    
    
}

- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type
{
    
    if ([dict[@"respCode"]isEqual:@"0000"]) {
        if (type == REQUSET_ORDER) {
            self.orderId = [dict objectForKey:@"orderId"];
            NSLog(@"%@",self.orderId);
            
            NSString *Amtstring = [NSString stringWithFormat:@"%.f",self.AmtTextField.text.doubleValue*100];
            NSLog(@"%@",Amtstring);
            [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"正在生成二维码"];
            [request prepayAllowtotalFee:Amtstring
                                 orderId:self.orderId
                                    Info:@""
                                 acctNo2:self.acctNo2
             ];
            NSLog(@"%@",self.orderId);
        }
        else if (type == REQUSET_PREPAYALLOW) {
            scanStrUrl = [dict objectForKey:@"QRcodeURL"];
            self.orderID = [dict objectForKey:@"orderId"];

            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            DisplayScanViewController *DisplayScanVc = [mainStoryboard instantiateViewControllerWithIdentifier:@"DisplayScanVc"];
            DisplayScanVc.scanImage = scanStrUrl;
            DisplayScanVc.orderId = self.orderID;
            NSLog(@"%@",DisplayScanVc.orderId);
            DisplayScanVc.ScanMoney = self.AmtTextField.text;
            [self.navigationController pushViewController:DisplayScanVc animated:YES];
            [MBProgressHUD hideHUDForView:self.view animated:YES];

        }else if (type == REQUEST_QUICKPAYSTATE){
            
            self.psamid = [[dict objectForKey:@"data"]objectForKey:@"psamid"];
            NSLog(@"%@",self.psamid);
            if (self.psamid.length == 0) {
                self.AmtTextField.userInteractionEnabled = NO;
                [Common showMsgBox:nil msg:@"请先绑定快捷支付认证码" parentCtrl:self];
            }else{
                self.AmtTextField.userInteractionEnabled = YES;
            }
        }
    }else{
//        [MBProgressHUD showHUDAddedTo:self.view WithString:dict[@"respDesc"]];
        [Common showMsgBox:nil msg:dict[@"respDesc"] parentCtrl:self];
    }

    [MBProgressHUD hideHUDForView:self.view animated:YES];
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
