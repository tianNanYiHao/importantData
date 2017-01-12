//
//  CheckCardInfoViewController.m
//  QuickPos
//
//  Created by feng Jie on 16/6/21.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "CheckCardInfoViewController.h"
#import "BankCardBindViewController.h"
#import "CreditCardBindViewController.h"
#import "OrderData.h"
#import "Request.h"
#import "QuickBankData.h"
#import "MBProgressHUD.h"

@interface CheckCardInfoViewController ()<ResponseData>

{
    Request *request;
    QuickBankItem *item;

    
}

@property (weak, nonatomic) IBOutlet UILabel *BankCardLab;//验证银行卡label
@property (weak, nonatomic) IBOutlet UITextField *BankCardNumber;//验证银行卡textfield

@property (weak, nonatomic) IBOutlet UIButton *Comfire;//确认按钮
@property (nonatomic,strong) NSString *cardTypeNo;//卡类型
@property (nonatomic,strong) NSString *customID;
@property (nonatomic,strong) NSString *bankNames;


@end

@implementation CheckCardInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.title = @"验证卡信息";
    
    request = [[Request alloc]initWithDelegate:self];
    
}

//验证卡信息
- (IBAction)CheckCardInfo:(id)sender {
    if (self.BankCardNumber.text.length == 0) {
        [MBProgressHUD showHUDAddedTo:self.view WithString:@"请输入银行卡号."];
    }else{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"正在验证卡信息..."];
    }
    
    [request checkBankCardNo:self.BankCardNumber.text];
    
   }

- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type
{
      if (type == REQUSET_CARDBINQUERY) {
            if([[dict objectForKey:@"respCode"]isEqualToString:@"0000"]){
            self.bankNames = [[dict objectForKey:@"data"]objectForKey:@"bankname"];
            self.cardTypeNo = [[dict objectForKey:@"data"]objectForKey:@"cardtype"];
            self.customID = [[dict objectForKey:@"data"]objectForKey:@"customerId"];
            
            

            if ([self.cardTypeNo isEqualToString:@"0"]) {
                UIStoryboard *mainStroybord = [UIStoryboard storyboardWithName:@"QuickPay" bundle:nil];
                BankCardBindViewController *addBankcardVC = [mainStroybord instantiateViewControllerWithIdentifier:@"BankCardBindViewController"];
                
                addBankcardVC.customerId = self.customID;
                addBankcardVC.bankName = self.bankNames;
                addBankcardVC.cardType = self.cardTypeNo;
                
                NSLog(@"%@  %@  %@",addBankcardVC.customerId,addBankcardVC.bankName,addBankcardVC.cardType);
                
                [addBankcardVC setOrderData:self.orderData];
                addBankcardVC.bankCard = self.BankCardNumber.text;
                addBankcardVC.hidesBottomBarWhenPushed = YES;
                
                [self.navigationController pushViewController:addBankcardVC animated:YES];
                self.BankCardNumber.text = @"";
                
            }else
            {
                UIStoryboard *mainStroybord = [UIStoryboard storyboardWithName:@"QuickPay" bundle:nil];
                CreditCardBindViewController *creditCaedVc = [mainStroybord instantiateViewControllerWithIdentifier:@"CreditCardBindViewController"];
                creditCaedVc.customerId = self.customID;
                creditCaedVc.bankName = self.bankNames;
                creditCaedVc.cardType = self.cardTypeNo;
                
                NSLog(@"%@  %@  %@",creditCaedVc.customerId,creditCaedVc.bankName,creditCaedVc.cardType);
                
                [creditCaedVc setOrderData:self.orderData];
                creditCaedVc.bankCard = self.BankCardNumber.text;
                creditCaedVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:creditCaedVc animated:YES];
                self.BankCardNumber.text = @"";
            }
        }
        else
        {
            [MBProgressHUD showHUDAddedTo:self.view WithString:[dict objectForKey:@"respDesc"]];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
