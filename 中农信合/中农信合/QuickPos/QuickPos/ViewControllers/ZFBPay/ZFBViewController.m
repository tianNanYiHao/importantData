//
//  ZFBViewController.m
//  QuickPos
//
//  Created by Lff on 16/8/8.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "ZFBViewController.h"
#import "LBXScanWrapper.h"
#import "LBXAlertAction.h"
#import "XYSwitch.h"
#import "UIImageView+CornerRadius.h"
#import "Request.h"


@interface ZFBViewController ()<ResponseData>
{
//    UIImageView *_imageVIew;
    
    int buttonTag;//提现属性标记
    NSString *cashType;//提现类型
    
    Request *req;
    NSString *payTool;
    NSString *merchorder_No;
    
    
}
@property (weak, nonatomic) IBOutlet UIImageView *ewmImageViw;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic,strong) NSString *urlString;
@property (nonatomic,strong) UIImageView *imageVIew;
@property (weak, nonatomic) IBOutlet UILabel *amtTitleLabel;//显示的金额
@property (nonatomic,strong) NSString *sign;
@property (nonatomic,strong) NSString *signNo;

@end

@implementation ZFBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.title = @"支付宝二维码";
    req = [[Request alloc] initWithDelegate:self];
    payTool = @"01";
    //获取YST二维码
    [self getYSTewm];
    _ewmImageViw.image = [UIImage imageNamed:@"22"];
     [self yiqiande];
}
-(void)getYSTewm
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"二维码获取中..."];
    //银视通获取二维码
    [Common getYSTZFBimage:self.view money:_AmtNO requestDataBlock:^(id requestdate) {
        NSData *data = (NSData*)requestdate;
        NSMutableString *str = [[NSMutableString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", str);
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@", dict);
        NSString *retcode = [dict objectForKey:@"retcode"];
        if ([retcode isEqualToString:@"R9"]) {
            NSString* qrcode = [dict objectForKey:@"qrcode"];
            [Common erweima:qrcode imageView:_ewmImageViw];
            NSString *merchorder_no = [dict objectForKey:@"merchorder_no"];
            [Common alipayOrderStateSelect:merchorder_no key:_infoArr[2] merchantcode:_infoArr[0]];
            merchorder_No = merchorder_no;
            //下单
            dispatch_async(dispatch_get_main_queue(), ^{
                 [self getOrder];
            });
        } else {
            NSString *result = [dict objectForKey:@"result"];
            [MyAlertView myAlertView:result];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } infoArr:_infoArr];
}


-(void)getOrder{
    //下单
        NSString *money = [NSString stringWithFormat:@"%.f",[_AmtNO floatValue]*100];
        [req applyOrderMobileNo:[AppDelegate getUserBaseData].mobileNo
                      MerchanId:_merchantId
                      productId:_productId
                       orderAmt:money
                      orderDesc:_cardNum
                    orderRemark:merchorder_No
                   commodityIDs:@""
                        payTool:payTool
         ];
}
-(void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (type == REQUSET_ORDER) {
        
    }

}

//- (void)titleLabelAndInstructions
//{
//    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 40, 200, 21)];
//    titleLabel.text = @"收款金额(元)";
//    titleLabel.font = [UIFont systemFontOfSize:17 weight:17];
//    titleLabel.textColor = [UIColor lightGrayColor];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    
//    UILabel *amtTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 70, 200, 21)];
//    amtTitleLabel.text = [NSString stringWithFormat:@"%d%@",[self.AmtNO intValue]/100,@"￥"];
//    amtTitleLabel.font = [UIFont systemFontOfSize:17 weight:17];
//    amtTitleLabel.textColor = [UIColor lightGrayColor];
//    amtTitleLabel.textAlignment = NSTextAlignmentCenter;
//    
//    UILabel *instructionsLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(35,370, 250, 21)];
//    instructionsLabel1.text = @"请打开二维码扫123123一扫该二维码,交易状态请在交易记录中查看";
//    instructionsLabel1.textColor = [UIColor lightGrayColor];
//    instructionsLabel1.textAlignment = NSTextAlignmentLeft;
//    
////    UILabel *instructionsLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(35, 391, 250, 21)];
////    instructionsLabel2.text = @"交易状态请在交易记录中查看";
////    instructionsLabel2.textColor = [UIColor lightGrayColor];
////    instructionsLabel2.textAlignment = NSTextAlignmentLeft;
////    [self.view addSubview:instructionsLabel2];
//    [self.view addSubview:instructionsLabel1];
//    [self.view addSubview:amtTitleLabel];
//    [self.view addSubview:titleLabel];
//    
//}


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
-(void)yiqiande{
    
    //    self.amtTitleLabel.text = [NSString stringWithFormat:@"%.2f%@",self.AmtNO.doubleValue/100,@"￥"];
    //    if (_payTway == 3) {
    //        NSString *url1 = @"http://122.144.198.81:8081/easypay/phone/alipay?orderId=";
    //        NSString *url2 = @"&orderAmt=";
    //        NSString *url3 = @"&sign=";
    //        self.signNo = @"bb0adb27090e";
    //        self.sign = [NSString stringWithFormat:@"%@%@%@",self.orderId,self.AmtNO,self.signNo];
    //        NSString *signStr = [Utils md5WithString:self.sign];
    //
    //        self.urlString = [NSString stringWithFormat:@"%@%@%@%@%@%@",url1,self.orderId,url2,self.AmtNO,url3,signStr];
    //
    //
    //        _webView.delegate = self;
    //        _imageVIew = [[UIImageView alloc] initWithFrame:CGRectMake(60, 100, 200, 200)];
    //        [self.view addSubview:_imageVIew];
    //        _imageVIew.image = [LBXScanWrapper createQRWithString:self.urlString size:_imageVIew.bounds.size];
    //        [LBXScanWrapper addImageViewLogo:_imageVIew centerLogoImageView:nil logoSize:CGSizeZero];
    
    //    }
    //    else if (_payTway == 9){
    //        [req postCodeImageWihtorderID:_orderId orderAmT:_AmtNO];
    //        [MBProgressHUD showHUDAddedTo:self.view WithString:@"二维码获取中..."];
    //    }
}

@end
