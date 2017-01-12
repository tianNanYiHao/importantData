//
//  SDJBankPayViewController.m
//  QuickPos
//
//  Created by feng Jie on 16/7/29.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "SDJBankPayViewController.h"
#import "Request.h"
#import "OrderData.h"
#import "Common.h"
#import "RechargeViewController.h"
#import "QuickPosNavigationController.h"
#import "QuickPosTabBarController.h"
#import "DDMenuController.h"
#import "SetupViewController.h"

@interface SDJBankPayViewController ()<ResponseData,UITextFieldDelegate>

{
    Request *request;
    OrderData *orderId;
    OrderData *orderData;
    int Second;//秒数
    NSTimer *timer;//倒计时
}

@property (weak, nonatomic) IBOutlet UILabel *orderNumLabel;//订单号

@property (weak, nonatomic) IBOutlet UILabel *AmtLabel;//金额

@property (weak, nonatomic) IBOutlet UILabel *bankNameLabel;//开户银行


@property (weak, nonatomic) IBOutlet UILabel *bankCardLabel;//银行卡号


@property (weak, nonatomic) IBOutlet UITextField *smstextField;//短信验证码


@property (weak, nonatomic) IBOutlet UIButton *GetCodeButton;//获取短信验证码btn



@end

@implementation SDJBankPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付订单";
    
    self.orderNumLabel.text = self.orderId;
    self.AmtLabel.text = self.orderAmt;
    self.AmtLabel.text = [NSString stringWithFormat:@"%.2f%@",self.orderAmt.doubleValue / 100.0,@"￥"];
    self.bankNameLabel.text = self.bankName;
    //银行卡号加密
    self.bankCardLabel.text = [Common bankCardNumSecret:self.bankCardNo];
   
    NSLog(@"%@",self.bankCardNo);
    
    request = [[Request alloc]initWithDelegate:self];
}

//获取短信验证码
- (IBAction)GetSMSCode:(id)sender {
    
    Second = 120;
    
    [timer invalidate];
    
    timer = nil;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(repeats) userInfo:nil repeats:YES];
    [request QuickBankCardPaySdjSmsWithorderAmt:self.orderAmt mobileNo:self.mobileNo];

    
}

- (void)repeats
{
    
    if (Second > 0)
    {  --Second;
        
        self.GetCodeButton.enabled = NO;
        [self.GetCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        
        
        [self.GetCodeButton setTitle:[NSString stringWithFormat:L(@"ToResendToSecond"),Second] forState:UIControlStateNormal];
        
    }else
    {
        [self.GetCodeButton setBackgroundImage:[UIImage imageNamed:@"fasongyanzma2.png"] forState:UIControlStateNormal];
        self.GetCodeButton.enabled =YES;
        
        [self.GetCodeButton setTitle:[NSString stringWithFormat:L(@"ToResend")] forState:UIControlStateNormal];
        [self.GetCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        
    }
    
}


//确认支付按钮
- (IBAction)ComfirmPayBtn:(id)sender {
    
    NSLog(@"%@  %@",self.smstextField.text,self.bankCodes);
    
    if (self.smstextField.text.length == 0) {
        [Common showMsgBox:nil msg:@"请输入短信验证码" parentCtrl:self];
    }else if (self.smstextField.text.length > 0 && self.smstextField.text.length < 6){
        [Common showMsgBox:nil msg:@"请输入正确的验证码" parentCtrl:self];
    }
    else
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"正在交易.."];
        [request QuickBankCardComfirmSdjWithorderId:self.orderId
                                           orderAmt:self.orderAmt
                                             cardNo:self.bankCardNo
                                       customerName:self.AccountName
                                       legalCertPid:self.ICCardNo
                                           bankCode:self.bankCodes
                                           mobileNo:self.mobileNo
                                   referrerMobileNo:self.smstextField.text
         ];
        
        
    }
}

- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type
{
    if ([[dict objectForKey:@"respCode"]isEqualToString:@"0000"]) {
        if (type == REQUSET_QUICKBANKCARDPAYSDJSMS) {
            
        }
        else if (type == REQUSET_QUICKBANKCARDCOMFIRMSDJ){
            
            
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            PSTAlertController *gotoPageController = [PSTAlertController alertWithTitle:@"" message:dict[@"respDesc"]];
            [gotoPageController addAction:[PSTAlertAction actionWithTitle:@"确认" handler:^(PSTAlertAction *action) {
                
                QuickPosTabBarController *quick = [storyBoard instantiateViewControllerWithIdentifier:@"QuickPosTabBarController"];
                
                SetupViewController  *setupCtrl = [storyBoard instantiateViewControllerWithIdentifier:@"SetupViewController"];
                DDMenuController *dd = [[DDMenuController alloc]initWithRootViewController:quick];
                dd.rightViewController = setupCtrl;
                quick.parentCtrl = dd;
                [self.navigationController presentViewController:dd animated:YES completion:^{
                    [self.navigationController popViewControllerAnimated:NO];
                    
                }];
                
            }]];
            [gotoPageController showWithSender:nil controller:self animated:YES completion:NULL];
            
        }
        
    }else{
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        PSTAlertController *gotoPageController = [PSTAlertController alertWithTitle:@"" message:dict[@"respDesc"]];
        [gotoPageController addAction:[PSTAlertAction actionWithTitle:@"确认" handler:^(PSTAlertAction *action) {
            
            QuickPosTabBarController *quick = [storyBoard instantiateViewControllerWithIdentifier:@"QuickPosTabBarController"];
            
            SetupViewController  *setupCtrl = [storyBoard instantiateViewControllerWithIdentifier:@"SetupViewController"];
            DDMenuController *dd = [[DDMenuController alloc]initWithRootViewController:quick];
            dd.rightViewController = setupCtrl;
            quick.parentCtrl = dd;
            [self.navigationController presentViewController:dd animated:YES completion:^{
                [self.navigationController popViewControllerAnimated:NO];
                
            }];
            
        }]];
        [gotoPageController showWithSender:nil controller:self animated:YES completion:NULL];
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
