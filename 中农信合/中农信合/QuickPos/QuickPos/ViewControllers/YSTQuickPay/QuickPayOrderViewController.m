//
//  QuickPayOrderViewController.m
//  QuickPos
//
//  Created by 胡丹 on 15/4/8.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "QuickPayOrderViewController.h"
#import "OrderData.h"
#import "QuickBankData.h"
#import "Request.h"
#import "PayType.h"
#import "Common.h"
#import "MBProgressHUD+Add.h"
#import "QuickPosTabBarController.h"

@interface QuickPayOrderViewController ()<ResponseData,UIAlertViewDelegate>{
    NSString *productId;
    NSString *merchantId;
    MBProgressHUD *hud;
    Request *request;
    
    int Second;//秒数
    NSTimer *timer;//倒计时

}



@property (weak, nonatomic) IBOutlet UILabel *orderId;//订单编号

@property (weak, nonatomic) IBOutlet UILabel *transAccount;//交易账户

@property (weak, nonatomic) IBOutlet UILabel *transAmt;//交易金额

@property (weak, nonatomic) IBOutlet UILabel *transBank;//支付银行

@property (weak, nonatomic) IBOutlet UILabel *bankNo;//银行卡号

@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;//获取验证码按钮

@property (weak, nonatomic) IBOutlet UITextField *SMSVerification;//短信验证

@property (weak, nonatomic) IBOutlet UITextField *PaymentPassword;//支付密码

@property (weak, nonatomic) IBOutlet UILabel *VerificationCode;//验证码label

@property (weak, nonatomic) IBOutlet UIView *SMSView;//验证码view
@property (weak, nonatomic) IBOutlet UIButton *comfirt;//确认按钮

@property (nonatomic,strong) NSString *orderAmts;

@property (nonatomic,strong) NSString *dynameic;

@property (nonatomic,assign) BOOL CheckDynamicCode;

@property (nonatomic,assign) BOOL QuickBankCardConfirm;

@property (nonatomic,strong) NSString *transStatus;

@end

@implementation QuickPayOrderViewController
@synthesize orderID;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"储蓄卡确认支付";
    self.orderId.text = self.orderData.orderId;//订单编号
    self.transAccount.text = [AppDelegate getUserBaseData].mobileNo;//交易账户
    self.orderAmts = self.orderData.orderAmt;//交易金额
    self.transAmt.text = [NSString stringWithFormat:@"￥%.2f",[_orderAmts integerValue]/100.0];//金额转化
    self.transBank.text = self.bankName;//支付银行
    self.bankNo.text = self.cardNums;//银行卡号
    NSLog(@"%@  %@  %@  %@  %@  %@",self.orderId.text,self.transAccount.text,self.transAmt.text,self.transBank.text,self.bankNo.text,self.newbindid);
    request = [[Request alloc]initWithDelegate:self];
    
    if (self.isJumps) {
        self.SMSView.hidden = YES;
        [self.comfirt setTitle:@"确认支付" forState:UIControlStateNormal];
    }else
    {
        self.SMSView.hidden = NO;
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
}

//- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
//    Request *req = [[Request alloc]initWithDelegate:self];
//    NSString *payInfo;
//    [req applyForQuickPay:payInfo orderID:self.orderData.orderId];
//    return YES;
//}

//获取验证码
- (IBAction)GetVerificationCode:(id)sender {
   
    [MBProgressHUD showHUDAddedTo:self.view WithString:@"短信发送成功"];
    
    Second = 60;
    
    [timer invalidate];
    
    timer = nil;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(repeats) userInfo:nil repeats:YES];
    
//    [request SendDynamicCode:self.newbindid];
    [request SendDynamicCode:self.newbindid mobileNo:self.bankMobileNo];
    NSLog(@"%@",self.newbindid);
    
}


- (void)repeats
{
    
    if (Second > 0)
    {  --Second;
        
        self.getCodeButton.enabled = NO;
        [self.getCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        
        
        [self.getCodeButton setTitle:[NSString stringWithFormat:L(@"ToResendToSecond"),Second] forState:UIControlStateNormal];
        
    }else
    {
        [self.getCodeButton setBackgroundImage:[UIImage imageNamed:@"fasongyanzma2.png"] forState:UIControlStateNormal];
        self.getCodeButton.enabled =YES;
        
        [self.getCodeButton setTitle:[NSString stringWithFormat:L(@"ToResend")] forState:UIControlStateNormal];
        [self.getCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        
        
    }
    
}


//选择是否验证码
- (IBAction)ConfirmingTheVerificationCode:(id)sender {
    if (_isJumps) {
        PSTAlertController *psta  = [PSTAlertController alertWithTitle:nil message:L(@"PleaseEnterTradingPassword")];
        [psta addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = L(@"TradePassword");
            textField.secureTextEntry = YES;
            textField.keyboardType = UIKeyboardTypeNumberPad;
        }];
        [psta addAction:[PSTAlertAction actionWithTitle:L(@"Confirm") handler:^(PSTAlertAction * _Nonnull action) {
            if (action.alertController.textField.text.length == 0) {
                [Common showMsgBox:nil msg:L(@"PasswordCannotBeEmpty") parentCtrl:self];
            }else{//快捷支付
                [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"正在交易,请稍后"];
                [request QuickBankCardConfirmCardNo:self.cardNums
                                           mobileNo:self.bankMobileNo
                                           password:action.alertController.textField.text
                                          newbindid:self.newbindid
                                          transDate:@""
                                          transTime:@""
                                          orderTime:@""
                                         customerId:self.customerId
                                       customerName:self.customerName
                                           cardType:self.cardType
                                           bankName:self.bankName
                                           orderAmt:self.orderData.orderAmt
                                            orderId:self.orderData.orderId
                                             PinBlk:action.alertController.textField.text
                 ];
            }
        }]];
        [psta addAction:[PSTAlertAction actionWithTitle:L(@"cancel")  handler:^(PSTAlertAction * _Nonnull action) {
        }]];
        [psta showWithSender:nil controller:self animated:YES completion:NULL];
    }
    else{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"验证短信并支付"];
        self.CheckDynamicCode = YES;
        [request CheckDynamicCode:self.newbindid mobileNo:self.bankMobileNo dynameic:self.SMSVerification.text];
        NSLog(@"%@",self.newbindid);
    }
}


- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (type == REQUSET_SENDDYNAMICCODE) {
        if ([[dict objectForKey:@"respCode"]isEqualToString:@"0000"]) {
            self.dynameic = [dict objectForKey:@"dynameic"];
            NSLog(@"%@",self.dynameic);
        }
    }
    else if (type == REQUSET_CHECKDYNAMICCODE){
        if ([[[dict objectForKey:@"data"]objectForKey:@"errorcode"]isEqualToString:@"0000"]) {
            PSTAlertController *psta  = [PSTAlertController alertWithTitle:nil message:L(@"PleaseEnterTradingPassword")];
            [psta addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.placeholder = L(@"TradePassword");
                textField.secureTextEntry = YES;
                textField.keyboardType = UIKeyboardTypeNumberPad;
            }];
            [psta addAction:[PSTAlertAction actionWithTitle:L(@"Confirm") handler:^(PSTAlertAction * _Nonnull action) {
                if (action.alertController.textField.text.length == 0) {
                    [Common showMsgBox:nil msg:L(@"PasswordCannotBeEmpty") parentCtrl:self];
                }else{//快捷支付
                    [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"正在交易,请稍后"];
                    [request QuickBankCardConfirmCardNo:self.cardNums
                                               mobileNo:self.bankMobileNo
                                               password:action.alertController.textField.text
                                              newbindid:self.newbindid
                                              transDate:@""
                                              transTime:@""
                                              orderTime:@""
                                             customerId:self.customerId
                                           customerName:self.customerName
                                               cardType:self.cardType
                                               bankName:self.bankName
                                               orderAmt:self.orderData.orderAmt
                                                orderId:self.orderData.orderId
                                                 PinBlk:action.alertController.textField.text
                     ];
                }
            }]];
            [psta addAction:[PSTAlertAction actionWithTitle:L(@"cancel")  handler:^(PSTAlertAction * _Nonnull action) {
            }]];
            [psta showWithSender:nil controller:self animated:YES completion:NULL];
        }else{
            [Common showMsgBox:nil msg:@"短信验证码校验失败." parentCtrl:self];
            [self performSelector:@selector(gobackRootCtrl) withObject:nil afterDelay:2.0];
        }
    }
    else if (type == REQUSET_QUICKBANKCARDCONFIRM){
        if ([[dict objectForKey:@"respCode"] isEqualToString:@"0000"]) {
            self.transStatus = @"00";
            NSLog(@"%@",self.transStatus);
            [request getMallorderId:self.orderData.orderId
                          ordStatus:self.ordStatus
                        transStatus:self.transStatus
                       receiverName:self.receiverName
                      receiverPhone:self.receiverPhone
                    receiverAddress:self.receiverAddress
                             cardNo:self.cardNums
                             txnAmt:self.orderData.orderAmt
             ];
            [Common showMsgBox:nil msg:dict[@"respDesc"] parentCtrl:self];
            [self performSelector:@selector(gobackRootCtrl) withObject:nil afterDelay:2.0];
        }else
        {
            self.transStatus = @"03";
            NSLog(@"%@",self.transStatus);
            [request getMallorderId:self.orderData.orderId
                          ordStatus:self.ordStatus
                        transStatus:self.transStatus
                       receiverName:self.receiverName
                      receiverPhone:self.receiverPhone
                    receiverAddress:self.receiverAddress
                             cardNo:self.cardNums
                             txnAmt:self.orderData.orderAmt
             ];
            [Common showMsgBox:nil msg:dict[@"respDesc"] parentCtrl:self];
            [self performSelector:@selector(gobackRootCtrl) withObject:nil afterDelay:2.0];
        }
    }
}




- (void)gobackRootCtrl{
    [self.navigationController popToRootViewControllerAnimated:NO];
    
}


//    [hud hide:YES];
//    NSString *code = [dict objectForKey:@"respCode"];
//    if ([code isEqualToString:@"0000"]) {
//        if(type == REQUEST_QUICKBANKCARDAPPLY){
//            //无卡支付申请返回
//            if([[dict objectForKey:@"smsConfirm"] intValue] == 1){
//                Request *req = [[Request alloc]initWithDelegate:self];
//                [req getQuickPayCode:self.orderData.orderId];
//                [self getCodeView];
//            }else{
//                 hud = [MBProgressHUD showMessag:L(@"IsThePaymentConfirmation") toView:[[QuickPosTabBarController getQuickPosTabBarController]view]];
//                if(iOS8){
//                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"是否确认支付？" preferredStyle:UIAlertControllerStyleAlert];
////                                        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//                        Request *req = [[Request alloc]initWithDelegate:self];
//                
//                        [req enSureQuickPay:@"" orderID:self.orderData.orderId];
//
//                    }];
//                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//                    }];
//                    [alert addAction:defaultAction];
//                    [alert addAction:cancelAction];
//                    [self presentViewController:alert animated:YES completion:nil];
//                    
//                }else{
//                    
//                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"是否确认支付？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
//                    alert.tag = 1;
//                    [alert show];
//                    
//                }

//                            }
//        
//        }
//        else if(type == REQUEST_QUICKBANKCARDCONFIRM){
//            //无卡支付确认返回
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"ClearShoppingCartNotification" object:[NSString stringWithFormat:@"%d",YES]];
//            [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"TheSuccessOfPayment")];
//            [self performSelector:@selector(goBack) withObject:nil afterDelay:2.0];
//        }
//    }else{
//        [MBProgressHUD showHUDAddedTo:self.view WithString:[dict objectForKey:@"respDesc"]];
////        [Common showMsgBox:nil msg:[dict objectForKey:@"respDesc"] parentCtrl:self];
//        if (type == REQUEST_QUICKBANKCARDAPPLY || type == REQUEST_QUICKBANKCARDCONFIRM) {
//            [self performSelector:@selector(goBack) withObject:nil afterDelay:2.0];
//        }
//        
//    }

//}

- (void)goBack{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

////短信确认
//- (void)getCodeView{
//    if(iOS8){
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
//        
//        [alert setTitle:L(@"SecurityVerification")];
//        [alert setMessage:L(@"ForYourTransactionSecurityPleaseEnterTheVerificationCode")];
//        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//            textField.placeholder = L(@"MessageAuthenticationCode");
////            textField.secureTextEntry = YES;
//            
//        }];
//        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:L(@"Confirm") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//            NSString *pwd = [(UITextField*)[alert.textFields objectAtIndex:0] text];
//            if (pwd.length == 0) {
//                [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"VerificationCodeCannotBeEmpty")];
//                [self presentViewController:alert animated:YES completion:nil];
//            }else{
//                hud = [MBProgressHUD showMessag:L(@"IsThePaymentConfirmation") toView:[[QuickPosTabBarController getQuickPosTabBarController]view]];
//                Request *req = [[Request alloc]initWithDelegate:self];
//                [req enSureQuickPay:[(UITextField*)[alert.textFields objectAtIndex:0] text] orderID:self.orderData.orderId];
//            }
//        }];
//        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:L(@"cancel") style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//            [self.navigationController popToRootViewControllerAnimated:YES];
//        }];
//        [alert addAction:defaultAction];
//        [alert addAction:cancelAction];
//        [self presentViewController:alert animated:YES completion:nil];
//    }else{
//        
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:nil delegate:self cancelButtonTitle:L(@"cancel") otherButtonTitles:L(@"Confirm"), nil];
//        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
//        [alert setTitle:L(@"SecurityVerification")];
//        [alert setMessage:L(@"ForYourTransactionSecurityPleaseEnterTheVerificationCode")];
//        [[alert textFieldAtIndex:0] setPlaceholder:L(@"MessageAuthenticationCode")];
//        alert.tag = 2;
//        [alert show];
//    }
//}
//
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (alertView.tag == 2) {
//        if (buttonIndex == 1) {
//            NSString *pwd = [(UITextField*)[alertView textFieldAtIndex:0] text];
//            if (pwd.length == 0) {
//                [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"VerificationCodeCannotBeEmpty")];
//                [alertView show];
//            }else{
//                hud = [MBProgressHUD showMessag:L(@"IsThePaymentConfirmation") toView:[[QuickPosTabBarController getQuickPosTabBarController]view]];
//                Request *req = [[Request alloc]initWithDelegate:self];
//                [req enSureQuickPay:[(UITextField*)[alertView textFieldAtIndex:0] text] orderID:self.orderData.orderId];
//            }
//        }else{
//            [self.navigationController popToRootViewControllerAnimated:YES];
//        }
//    }else{
//        if (buttonIndex == 1){
//            hud = [MBProgressHUD showMessag:L(@"IsThePaymentConfirmation") toView:[[QuickPosTabBarController getQuickPosTabBarController]view]];
//            Request *req = [[Request alloc]initWithDelegate:self];
//            [req enSureQuickPay:@"" orderID:self.orderData.orderId];
//        }else{
//            [self.navigationController popToRootViewControllerAnimated:YES];
//        }
//    }
//}
//
////我要付款
//- (IBAction)quickPay:(UIButton *)sender {
//    hud = [MBProgressHUD showMessag:L(@"IsSubmitRequest") toView:[[QuickPosTabBarController getQuickPosTabBarController]view]];
//    Request *req = [[Request alloc]initWithDelegate:self];
//    if (self.bankCardItem.isBind) {
//        [req applyForQuickPay:@"" IDCard:@"" cardNo:@"" vaild:@"" cvv2:@"" phone:@"" orderID:self.orderData.orderId bindID:self.bankCardItem.bindID orderAmt:self.orderData.orderAmt productId:self.orderData.productId merchantId:self.orderData.merchantId];
//    }else{
//        if (self.bankCardItem.cardType == DEPOSITCARD) {
//            [req applyForQuickPay:self.bankCardItem.name IDCard:self.bankCardItem.icCard cardNo:self.bankCardItem.cardNo vaild:@"" cvv2:@"" phone:self.bankCardItem.phone orderID:self.orderData.orderId bindID:@"" orderAmt:self.orderData.orderAmt productId:self.orderData.productId merchantId:self.orderData.merchantId];
//        }else{
//            [req applyForQuickPay:self.bankCardItem.name IDCard:self.bankCardItem.icCard cardNo:self.bankCardItem.cardNo vaild:self.bankCardItem.validateCode cvv2:self.bankCardItem.cvv2  phone:self.bankCardItem.phone orderID:self.orderData.orderId  bindID:@"" orderAmt:self.orderData.orderAmt productId:self.orderData.productId merchantId:self.orderData.merchantId];
//        }
//        
//    }

//}
@end
