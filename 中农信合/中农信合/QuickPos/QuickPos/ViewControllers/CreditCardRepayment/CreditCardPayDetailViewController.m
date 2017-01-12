//
//  CreditCardPayDetailViewController.m
//  QuickPos
//
//  Created by 胡丹 on 15/3/18.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "CreditCardPayDetailViewController.h"
#import "NumberKeyBoard.h"
#import "OrderData.h"
#import "Request.h"
#import "OrderViewController.h"
#import "Common.h"
#import "BankCardData.h"
#import "PayType.h"
#import "ChooseView.h"
#import "DateUtil.h"
#import "MBProgressHUD+Add.h"
#import "WebViewController.h"
#import "MallViewController.h"



@interface CreditCardPayDetailViewController ()<ResponseData,ChooseViewDelegate>{
    NSUInteger payType;
    NSUInteger payTimeType;//普通、实时
    OrderData *orderData;
    NSArray *numArr;
    NSString *productId;
    NSString *merchantId;
    MBProgressHUD *hud;
    NSString *payTool;
}

@property (weak, nonatomic) IBOutlet UIButton *chooseTypeBtn;
@property (weak, nonatomic) IBOutlet UITextField *sumTextField;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *choosePayTypeBtns;
@property (weak, nonatomic) IBOutlet UIButton *creditPayBtn;
@property (weak, nonatomic) IBOutlet UISegmentedControl *payTypeSeg;
@property (weak, nonatomic) IBOutlet UIView *_subview;
@property (nonatomic, strong)UIBarButtonItem *help;

@end

@implementation CreditCardPayDetailViewController
@synthesize BeneficiaryAccount;


- (void)viewDidLoad {
    [super viewDidLoad];
//自定义键盘
//    NumberKeyBoard *keyBoard = [[NumberKeyBoard alloc]init];
//    [keyBoard setTextView:self.sumTextField];
//
    
    numArr = @[@"实时还款",@"普通还款"];
    payType = CardPayType;
    payTool = @"01";
    payTimeType = NormalPayTimeType;
    NSLog(@"%@",self.choosePayTypeBtns);
    if (self.bankCardItem.payMode) {
        if ([self.bankCardItem.payMode isEqualToString:@"01"]) {
            [self.chooseTypeBtn setTitle:@"实时还款" forState:UIControlStateNormal];
        }else{
            [self.chooseTypeBtn setTitle:@"普通还款" forState:UIControlStateNormal];
            
        }
    }else{
        [self.chooseTypeBtn setTitle:@"实时还款" forState:UIControlStateNormal];
    }
    
}

- (void)helpClick{
    WebViewController *web = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    [web setTitle:L(@"help")];
    [web setUrl:CreditCardHelp];
    [self.navigationController pushViewController:web animated:YES];
}

- (void)chooseView:(ChooseView *)chooseView chooseAtIndex:(NSUInteger)chooseIndex{
    payType = chooseIndex;
    UIView *v = chooseView.superview;
    for (UIView *c in v.subviews) {
        if ([c isKindOfClass:[ChooseView class]]) {
            if (c.tag != chooseIndex) {
                for (UIView *sv in c.subviews) {
                    if ([sv isKindOfClass:[UIButton class]]) {
                        [(UIButton*)sv setSelected:NO];
                    }
                    
                }
            }
        }
    }
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - pickerView

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    //拾取视图的列数
    return 1;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    payTimeType = row;
    if (row == 0) {
        return @"实时还款";
    }else if (row == 1) {
        return @"普通还款";
    }
    return @"实时还款";
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 2;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    [self.chooseTypeBtn setTitle:[NSString stringWithFormat:@"%@",numArr[row]] forState:UIControlStateNormal];
    payTimeType = row;
}


//选择支付方式
//- (IBAction)actionPayType:(UIButton *)sender {
//    NSLog(@"%@",sender.description);
//    for (UIButton* btn in self.choosePayTypeBtns) {
//        if (btn == sender) {
//            btn.enabled = NO;
//            btn.backgroundColor = [UIColor grayColor];
//            payType = [self.choosePayTypeBtns indexOfObject:btn];
//        }else{
//            btn.enabled = YES;
//            btn.backgroundColor = [UIColor redColor];
//        }
//    }
//    NSLog(@"payType ==== %d",payType);
//
//}

- (IBAction)choosePayType:(UISegmentedControl *)sender {
    payType = sender.selectedSegmentIndex;
}

//我要还款
- (IBAction)actionPay:(UIButton *)sender {
    //申请交易订单
    NSString *orderAmt = [Common orderAmtFormat:self.sumTextField.text];
    Request *req = [[Request alloc]initWithDelegate:self];

        productId = @"0000000001" ;
        merchantId = @"0001000005";

    
    [req applyOrderMobileNo:[AppDelegate getUserBaseData].mobileNo
                      MerchanId:merchantId
                      productId:productId
                       orderAmt:orderAmt
                      orderDesc:[self.BeneficiaryAccount stringByReplacingOccurrencesOfString:@" " withString:@""]
                    orderRemark:@""
                   commodityIDs:@""
                        payTool:payTool];
    NSLog(@"%@",self.BeneficiaryAccount);
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:L(@"OrderHasBeenSubmitted-PleaseLater")];
    

    
}


- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    [hud hide:YES];
    if ([[dict objectForKey:@"respCode"]isEqualToString:@"0000"]) {
        
        
        if (type == REQUSET_ORDER) {
            UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            OrderViewController *shopVc = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderViewController"];
            orderData = [[OrderData alloc]initWithData:dict];
            
            shopVc.ReceivablesName = self.BeneficiaryName;
            shopVc.ReceivablesPhoneNo = self.BeneficiaryPhoneField;
            shopVc.ReceivablesCardNo = [self.BeneficiaryAccount stringByReplacingOccurrencesOfString:@" " withString:@""];
            NSLog(@"%@",shopVc.ReceivablesCardNo);
            
            orderData = [[OrderData alloc]initWithData:dict];
            orderData.orderAccount = self.BeneficiaryAccount;
            orderData.orderPayType = payType;
            orderData.merchantId = merchantId;
            orderData.productId = productId;
            orderData.isCardToCardPay = YES;
            shopVc.orderData = orderData;
            
            NSLog(@"%@ %@ %ld %@ %@ %@",orderData,orderData.orderAccount,orderData.orderPayType,orderData.merchantId,orderData.productId,shopVc.orderData);
            for (UIViewController *v in self.navigationController.viewControllers) {
                if ([v isKindOfClass:[MallViewController class]]) {
                    shopVc.delegate = v;
                }
            }
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.navigationController pushViewController:shopVc animated:YES];
            //            [self.navigationController presentViewController:shopVc animated:YES completion:nil];
            //                }
        }else{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showHUDAddedTo:self.view WithString:[dict objectForKey:@"respDesc"]];
        }
    }
    
}

- (void)goBack{
    [self.navigationController popToRootViewControllerAnimated:YES];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//     Get the new view controller using [segue destinationViewController].
//     Pass the selected object to the new view controller.
    if ([segue.destinationViewController isKindOfClass:[OrderViewController class]]) {
        [(OrderViewController*)segue.destinationViewController setOrderData:orderData];
        
    }
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if ([identifier isEqualToString:@"CreditPaySegue"]) {
        if (self.sumTextField.text.length == 0) {
            [Common showMsgBox:nil msg:@"金额不能为空" parentCtrl:self];
            return NO;
        }
        hud = [MBProgressHUD showMessag:@"正在生成订单。。" toView:self.view];
        //申请交易订单
        NSString *orderAmt = [Common orderAmtFormat:self.sumTextField.text];
        Request *req = [[Request alloc]initWithDelegate:self];
        productId = @"0000000001" ;
        merchantId = @"0002000001";
        NSString *orderDesc = self.bankCardItem.accountNo;
        NSString *orderRemark = [NSString stringWithFormat:@"%@,%@,%@,%@,%@",self.bankCardItem.name,self.bankCardItem.bankCityId,self.bankCardItem.cardIdx,self.bankCardItem.branchBankId,[DateUtil getCurTimeString]];
//        NSString *orderRemark = [NSString stringWithFormat:@"%@,%@,%@,%@",self.bankCardItem.name,self.bankCardItem.bankCityId,self.bankCardItem.cardIdx,self.bankCardItem.branchBankId];
        
        if (payType == AccountPayType) {
            [req applyOrderMobileNo:[AppDelegate getUserBaseData].mobileNo MerchanId:@"0002000001" productId:@"0000000001" orderAmt:orderAmt orderDesc:orderDesc orderRemark:orderRemark commodityIDs:@"" payTool:@"02"];
        }else if(payType == CardPayType){
            [req applyOrderMobileNo:[AppDelegate getUserBaseData].mobileNo MerchanId:@"0002000001" productId:@"0000000001" orderAmt:orderAmt orderDesc:orderDesc orderRemark:orderRemark commodityIDs:@"" payTool:@"01"];
        }else{
            [req applyOrderMobileNo:[AppDelegate getUserBaseData].mobileNo MerchanId:@"0002000001" productId:@"0000000001" orderAmt:orderAmt orderDesc:orderDesc orderRemark:orderRemark commodityIDs:@"" payTool:@"03"];
        }

        return NO;
    }
    return NO;
}



@end
