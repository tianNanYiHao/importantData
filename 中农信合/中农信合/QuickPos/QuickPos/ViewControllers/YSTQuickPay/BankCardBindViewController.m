//
//  BankCardBindViewController.m
//  QuickPos
//
//  Created by 胡丹 on 15/4/8.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "BankCardBindViewController.h"
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
#import "MyBankListViewController.h"




@interface BankCardBindViewController ()<ResponseData,UITextFieldDelegate>{
    QuickBankItem *item;
    MBProgressHUD *hud;
    OrderData *orderId;
    NSString *orderTime;
    Request *request;
    QuickBankItem *bankItem;
    
    
}
@property (weak, nonatomic) IBOutlet UITextField *cardNum;//卡号
@property (weak, nonatomic) IBOutlet UITextField *name;//姓名
@property (weak, nonatomic) IBOutlet UITextField *icCard;//身份证号
@property (weak, nonatomic) IBOutlet UITextField *phone;//银行预留手机号


@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (nonatomic,strong) NSString *orderId;

@property (nonatomic,strong) NSString *NewBindNo;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightBtn;//右上角点击按钮


@end

@implementation BankCardBindViewController
@synthesize bankCard;
@synthesize bankName;
@synthesize customerId;
@synthesize cardType;

- (void)viewDidLoad {
    [super viewDidLoad];


    self.cardNum.text = self.bankCard;
    NSLog(@"%@",self.cardNum.text);
    self.nextBtn.layer.cornerRadius = 5;
  self.navigationItem.rightBarButtonItem = nil;
    
    
    
    request = [[Request alloc]initWithDelegate:self];

    
    
    NSLog(@"%@  %@  %@",self.orderIds,self.orderData.orderId,self.orderId);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (IBAction)Verified:(id)sender {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"正在实名认证..."];
    [request QuickBankAuthent:self.phone.text
                 ValiDate:@""
             CustomerName:self.name.text
               CustomerId:self.customerId
             LegalCertPid:self.icCard.text
                      Cvn:@""
                orderTime:@""
            LegalCertType:@"01"
                   CardNo:self.cardNum.text
                 CardType:self.cardType
                  OrderId:@""
                 BankName:self.bankName
     ];

    
}

- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    if (type == REQUSET_QUICKBANKAUTHENT) {
    if ([[dict objectForKey:@"respCode"]isEqualToString:@"0000"]) {
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"QuickPay" bundle:nil];
            QuickPayOrderViewController *quickPayOrderVc = [mainStoryboard instantiateViewControllerWithIdentifier:@"QuickPayOrderViewController"];
            quickPayOrderVc.newbindid = [dict objectForKey:@"newBindId"];
            bankItem.newbindid = quickPayOrderVc.newbindid;
            NSLog(@"%@  %@",bankItem.newbindid,quickPayOrderVc.newbindid);
            [quickPayOrderVc setOrderData:self.orderData];
            quickPayOrderVc.bankName = self.bankName;
            quickPayOrderVc.cardNums = self.cardNum.text;
            quickPayOrderVc.customerName = self.name.text;
            quickPayOrderVc.cardType = self.cardType;
            quickPayOrderVc.customerId = self.customerId;
            quickPayOrderVc.bankMobileNo = self.phone.text;
            NSLog(@"%@  %@  %@  %@  %@  %@  %@",quickPayOrderVc.newbindid,quickPayOrderVc.bankName,quickPayOrderVc.cardNums,quickPayOrderVc.newbindid,quickPayOrderVc.customerName,quickPayOrderVc.cardType,quickPayOrderVc.customerId);
            [self.navigationController pushViewController:quickPayOrderVc animated:YES];
        }else
        {	
            PSTAlertController *pst = [PSTAlertController alertWithTitle:@"温馨提示" message:[dict objectForKey:@"respDesc"]];
            [pst addAction:[PSTAlertAction actionWithTitle:@"确认" handler:^(PSTAlertAction * _Nonnull action) {
              [self.navigationController popViewControllerAnimated:YES];
            }]];
            [pst showWithSender:nil controller:self animated:YES completion:NULL];

        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField isFirstResponder]) {
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//    
//    if ([segue.identifier isEqualToString:@"QuickOrderSegue"]){
//        if ([segue.destinationViewController isKindOfClass:[QuickPayOrderViewController class]]) {
//            [(QuickPayOrderViewController*)segue.destinationViewController setOrderData:self.orderData];
//            [(QuickPayOrderViewController*)segue.destinationViewController setBankCardItem:item];
//        }
//    
//    }else if([segue.identifier isEqualToString:@"AddCardDetailSegue"]){
//        if ([segue.destinationViewController isKindOfClass:[AddCardDetailInfoViewController class]]) {
//            [(AddCardDetailInfoViewController*)segue.destinationViewController setOrderData:self.orderData];
//            [(AddCardDetailInfoViewController*)segue.destinationViewController setQuickBankItem:item];
//            
//        }
//        
//    }
//    
//}

- (IBAction)showHelp:(id)sender {
    WebViewController *web = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"WebViewController"];
    [web setUrl:BankListHelp];
    [web setTitle:L(@"help")];
    [self.navigationController pushViewController:web animated:YES];
}

//- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
//    if (self.cardNum.text.length == 0 || self.icCard.text.length == 0 ||self.phone.text.length == 0) {
//        [Common showMsgBox:@"" msg:L(@"PleaseEnterCorrectInformation") parentCtrl:self];
//        return NO;
//    }
//    if (self.phone.text.length != 11 ) {
//        [Common showMsgBox:@"" msg:L(@"InputCorrectNumber") parentCtrl:self];
//        return NO;
//    }
//    
//    if ( self.icCard.text.length != 15 && self.icCard.text.length != 18) {
//        [Common showMsgBox:@"" msg:L(@"InputCorrectID") parentCtrl:self];
//        return NO;
//    }
//    
//    if ( self.name.text.length > 9) {
//        [Common showMsgBox:@"" msg:L(@"PleaseEnterCorrectName") parentCtrl:self];
//        return NO;
//    }
////    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
////    [user setObject:self.cardNum.text forKey:@"cardNumTest"];
////    [user setObject:self.icCard.text forKey:@"icCardTest"];
////    [user setObject:self.name.text forKey:@"nameTest"];
////    [user setObject:self.phone.text forKey:@"phoneTest"];
//    Request *req = [[Request alloc]initWithDelegate:self];
////    [req checkBankCardInfo:self.cardNum.text];
//    [req QuickBankAuthent:self.phone.text
//                 ValiDate:@""
//             CustomerName:self.name.text
//               CustomerId:self.customerId
//             LegalCertPid:self.icCard.text
//                      Cvn:@""
//                orderTime:@""
//            LegalCertType:@"01"
//                   CardNo:self.cardNum.text
//                 CardType:@"01"
//                  OrderId:self.orderIds
//                 BankName:self.bankName
//     ];
//
//    hud = [MBProgressHUD showMessag:L(@"VerifyingCardInformation") toView:self.view];
//    return NO;
//}

@end
