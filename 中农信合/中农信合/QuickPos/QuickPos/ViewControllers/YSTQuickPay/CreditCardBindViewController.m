//
//  CreditCardBindViewController.m
//  QuickPos
//
//  Created by feng Jie on 16/6/27.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "CreditCardBindViewController.h"
#import "NumberKeyBoard.h"
#import "Request.h"
#import "QuickBankData.h"
#import "QuickPayOrderViewController.h"
#import "AddCardDetailInfoViewController.h"
#import "Common.h"
#import "PayType.h"
#import "MBProgressHUD+Add.h"
#import "WebViewController.h"
#import "OrderData.h"
#import "CreditQuickPayOrderViewController.h"


@interface CreditCardBindViewController ()<ResponseData,UITextFieldDelegate>{
    QuickBankItem *item;
    MBProgressHUD *hud;
    OrderData *orderId;
    NSString *orderTime;
    Request *request;
    
}
@property (weak, nonatomic) IBOutlet UITextField *cardNum;//卡号
@property (weak, nonatomic) IBOutlet UITextField *name;//姓名
@property (weak, nonatomic) IBOutlet UITextField *icCard;//身份证号
@property (weak, nonatomic) IBOutlet UITextField *phone;//银行预留手机号
@property (weak, nonatomic) IBOutlet UITextField *CardValid;//卡有效期
@property (weak, nonatomic) IBOutlet UITextField *SecurityCode;//卡安全码

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (nonatomic,strong) NSString *orderId;

@property (nonatomic,strong) NSString *NewBindNo;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightBtn;//右上角点击按钮


@end

@implementation CreditCardBindViewController
@synthesize customerId;
@synthesize cardType;
@synthesize bankName;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.cardNum.text = self.bankCard;
    NSLog(@"%@",self.cardNum.text);
    self.nextBtn.layer.cornerRadius = 5;
    self.navigationItem.rightBarButtonItem = nil;
    request = [[Request alloc]initWithDelegate:self];
}

- (IBAction)Verified:(id)sender {
    
    if (_name.text.length == 0 ) {
        [Common showMsgBox:@"" msg:@"请填写正确姓名" parentCtrl:self];
    }else
    if (_icCard.text.length == 0) {
        [Common showMsgBox:@"" msg:@"请填写正确身份信息" parentCtrl:self];
    }else
    if (_CardValid.text.length == 0) {
        [Common showMsgBox:@"" msg:@"请填写正确有效期" parentCtrl:self];
    }else
    if (_SecurityCode.text.length == 0) {
        [Common showMsgBox:@"" msg:@"请填写正确卡安全码" parentCtrl:self];
    }else
    if (_phone.text.length == 0) {
        [Common showMsgBox:@"" msg:@"请填写正确预留手机号" parentCtrl:self];
    }
    else{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"正在实名认证..."];
        [request QuickBankAuthent:self.phone.text
                         ValiDate:self.CardValid.text
                     CustomerName:self.name.text
                       CustomerId:self.customerId
                     LegalCertPid:self.icCard.text
                              Cvn:self.SecurityCode.text
                        orderTime:@""
                    LegalCertType:@"01"
                           CardNo:self.cardNum.text
                         CardType:self.cardType
                          OrderId:self.orderIds
                         BankName:self.bankName
         ];
    }

}

- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
      if (type == REQUSET_QUICKBANKAUTHENT) {
            if ([[dict objectForKey:@"respCode"]isEqualToString:@"0000"]) {
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"QuickPay" bundle:nil];
            CreditQuickPayOrderViewController *creditQuickPayOrderVc = [mainStoryboard instantiateViewControllerWithIdentifier:@"CreditQuickPayOrderViewController"];
//            creditQuickPayOrderVc.newbindid = [dict objectForKey:@"newBindId"];
            self.NewBindNo = [dict objectForKey:@"newBindId"];
            [creditQuickPayOrderVc setOrderData:self.orderData];
            creditQuickPayOrderVc.bankName = self.bankName;
            creditQuickPayOrderVc.cardNums = self.cardNum.text;
            
            creditQuickPayOrderVc.customerName = self.name.text;
            creditQuickPayOrderVc.cardType = self.cardType;
            creditQuickPayOrderVc.customerId = self.customerId;
            creditQuickPayOrderVc.newbindid = self.NewBindNo;
            creditQuickPayOrderVc.cardValids = self.CardValid.text;
            creditQuickPayOrderVc.securityCodes = self.SecurityCode.text;
            creditQuickPayOrderVc.bankMobileNo = self.phone.text;
            NSLog(@"%@  %@  %@  %@",self.NewBindNo,creditQuickPayOrderVc.bankName,creditQuickPayOrderVc.cardNums,creditQuickPayOrderVc.newbindid);
            [self.navigationController pushViewController:creditQuickPayOrderVc animated:YES];
        }
            else
            {
                [MBProgressHUD showHUDAddedTo:self.view WithString:[dict objectForKey:@"respDesc"]];
            }
    }
}
    
    
    
//    if ([[dict objectForKey:@"respCode"]isEqualToString:@"0000"]) {
        //}

#pragma mark - Navigation


//右上角点击按钮
- (IBAction)showHelp:(id)sender {
    WebViewController *web = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"WebViewController"];
    [web setUrl:BankListHelp];
    [web setTitle:L(@"help")];
    [self.navigationController pushViewController:web animated:YES];
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
