//
//  ZFBReceivablesViewController.m
//  QuickPos
//
//  Created by feng Jie on 16/8/16.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "ZFBReceivablesViewController.h"
#import "ZFBViewController.h"
#import "LBXScanWrapper.h"
#import "LBXAlertAction.h"
#import "XYSwitch.h"
#import "Request.h"
#import "ZFBViewController.h"
#import "MBProgressHUD+Add.h"
#import "Common.h"

@interface ZFBReceivablesViewController ()<ResponseData>
{
    UIImageView *_imageVIew;
    
    int buttonTag;//提现属性标记
    NSString *cashType;//提现类型
    
    Request *req;
    NSString *payTool;
    
    NSString *merchantId;   //商户商家id
    NSString *productId;
    
}

@property (weak, nonatomic) IBOutlet UITextField *AmtTextField;//金额输入框

@property (weak, nonatomic) IBOutlet XYSwitch *normalButton;//T+1按钮

@property (weak, nonatomic) IBOutlet XYSwitch *fastButton;//T+0按钮

@property (nonatomic,strong) NSString *AmtNum;

@property (nonatomic,strong) NSString *orderId;

@property (unsafe_unretained, nonatomic) IBOutlet UIButton *comfirt;

@end

@implementation ZFBReceivablesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付宝收款";
    [self PromptTip];
    payTool = @"01";
    req = [[Request alloc]initWithDelegate:self];
    self.AmtTextField.layer.masksToBounds = YES;
    self.AmtTextField.layer.cornerRadius = 1;
    self.AmtTextField.layer.borderColor = [[UIColor greenColor] CGColor];
    merchantId = @"0001000007";
    productId = @"0000000003";
     _AmtTextField.keyboardType = UIKeyboardTypeDecimalPad;
    
    
//    [self.normalButton setOnImage:[UIImage imageNamed:@"xuanzeyuandian"] offImage:[UIImage imageNamed:@"yuandian"]];//设置图片
//    [self.fastButton setOnImage:[UIImage imageNamed:@"xuanzeyuandian"] offImage:[UIImage imageNamed:@"yuandian"]];//设置图片
//    buttonTag = 3;
//    self.fastButton.on=YES;//默认快速提款
//    merchantId = @"0001000007";
//    productId = @"0000000000";
//    if(self.fastButton.on){
//        cashType = @"3";
//    }
}

//tip
- (void)PromptTip
{
    UIView *tip = [Common tipWithStr:@"手续费=千分之五+2元" color:[UIColor redColor] rect:CGRectMake(0, CGRectGetMaxY(_comfirt.frame)+270, self.view.frame.size.width, 40)];
    [self.view addSubview:tip];
//    UIView *tip1 = [Common tipWithStr:@"T+1 手续费=收款金额*0.0055" color:[UIColor redColor] rect:CGRectMake(0, CGRectGetMaxY(_comfirt.frame)+300, self.view.frame.size.width, 40)];
//    [self.view addSubview:tip1];

}

//确认按钮
- (IBAction)confirmButton:(id)sender {
  
    
    if (_AmtTextField.text.length == 0) {
        [Common showMsgBox:@"" msg:@"请输入收款金额" parentCtrl:self];
    }else if([_AmtTextField.text integerValue]<5 ){
        [Common showMsgBox:@"" msg:@"收款金额请勿小于5元" parentCtrl:self];
    }else if([_AmtTextField.text length]>100000000){
        [Common showMsgBox:@"" msg:@"输入金额有误" parentCtrl:self];
    }
    else{
        [Common showMsgBox:@"" msg:@"暂不支持此功能" parentCtrl:self];
//        _AmtTextField.text = [NSString stringWithFormat:@"%.2f",[_AmtTextField.text floatValue]];
//        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        ZFBViewController *ZFBVc = [mainStoryboard instantiateViewControllerWithIdentifier:@"ZFBVc"];
//        ZFBVc.AmtNO = _AmtTextField.text;
//        ZFBVc.cardNum = self.ZFBBankCardNum;
//        ZFBVc.merchantId = merchantId;
//        ZFBVc.productId = productId;
//        ZFBVc.infoArr = @[ZFBMERCHANTCODE,ZFBBACKURL,ZFBKEY];
//        [self.navigationController pushViewController:ZFBVc animated:YES];
        
    }
}

////T+0提现按钮
//- (IBAction)fantButton:(id)sender {
//    
//    buttonTag = 3;
//    
//    
//    if(buttonTag == 3){
//        
//        NSLog(@"开启");
//        
//        merchantId = @"0001000007";
//        productId = @"0000000000";
//        
//        self.normalButton.on = NO;
//        
//        cashType = @"3";
//        
//        
//    }else {
//        
//        NSLog(@"关闭");
//    }
//    
//    
//    
//}


////T+1按钮  (威富通通道)
//- (IBAction)normalButton:(id)sender {
//    
//    buttonTag = 9;
//    
//    if(buttonTag == 9){
//        
//        NSLog(@"开启");
//        
//        merchantId = @"0001000007";
//        productId = @"0000000001";
//        
//        self.fastButton.on = NO;
//        cashType = @"2";
////        [Common showMsgBox:nil msg:@"暂未开放" parentCtrl:self];
//        
//    }else {
//        
//        NSLog(@"关闭");
//    }
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

@end
