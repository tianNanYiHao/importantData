//
//  TransferViewController.m
//  QuickPos
//
//  Created by 张倡榕 on 15/3/6.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "TransferViewController.h"
#import "Request.h"
#import "OrderData.h"
#import "Common.h"
#import "OrderViewController.h"
#import "ChooseView.h"
#import "PayType.h"
#import "WebViewController.h"
#import "MallViewController.h"
#import "HelpViewController.h"

@interface TransferViewController ()<ResponseData,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,ChooseViewDelegate>{
    
    NSUInteger payType;
    NSUInteger payTimeType;//普通、实时
    OrderData *orderData;
    NSArray *numArr;
    NSString *productId;
    NSString *merchantId;
    NSRange  ran;
    Request *request;
    NSString *payTool;

}
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *chooseTypeBtns;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *inputTextFields;//金额
@property (weak, nonatomic) IBOutlet UITextField *finalPrice;//转账金额

@property (weak, nonatomic) IBOutlet UITextField *BeneficiaryName;//收款方姓名
@property (weak, nonatomic) IBOutlet UITextField *BeneficiaryAccount;//收款方账户


@property (weak, nonatomic) IBOutlet UIButton *choosePayTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *transferToHim;
@property (weak, nonatomic) IBOutlet UISegmentedControl *payTypeSeg;
@property (weak, nonatomic) IBOutlet UIView *_subview;
@property (nonatomic, strong)UIBarButtonItem *help;
@property (weak, nonatomic) IBOutlet UIButton *comfirt;//转账确认按钮
@property (nonatomic, strong) NSString *isAccount;//是否是账户充值的标准
@property (nonatomic,strong) NSString *respCode;

@end

@implementation TransferViewController
@synthesize finalPrice;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"账户转账";
//    payType = CardPayType;
    
    self.comfirt.layer.cornerRadius = 5;
//    [self creatRightBtn];
    
    numArr = @[@"实时还款",@"普通还款"];
    payType = CardPayType;
    payTimeType = NormalPayTimeType;
    NSLog(@"%@",self.chooseTypeBtns);
    request = [[Request alloc]initWithDelegate:self];
    
    self.comfirt.userInteractionEnabled = YES;
    
    //使用账户支付 id
    merchantId = @"0002000002";
    productId = @"0000000004";
    payTool = @"02";
    self.isAccount = @"1";  //是账户支付
    payType = AccountPayType;
    

    for (UITextField *txt in self.inputTextFields) {
        if ([self.inputTextFields indexOfObject:txt] != 0) {
            NumberKeyBoard *keyBoard = [[NumberKeyBoard alloc]init];
            [keyBoard setTextView:txt];
        }
    }

}

//右侧点击按钮
- (void)creatRightBtn
{
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightBtn setImage:[UIImage imageNamed:@"serve_more"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(helpClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    //    [rightBtn release];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)helpClick{
    
    HelpViewController *helpVc = [HelpViewController new];
    [self.navigationController pushViewController:helpVc animated:YES];
    
    
//    WebViewController *web = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
//    [web setTitle:L(@"help")];
//    [web setUrl:TransferHelp];
//    [self.navigationController pushViewController:web animated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    for (UITextField *txt in self.inputTextFields) {
        switch (txt.tag) {
            case 1:
                txt.text = self.bankCardItem.name;
                txt.userInteractionEnabled = NO;
                break;
            case 2:
                txt.text = [Common bankCardNumSecret:self.bankCardItem.accountNo];
                txt.userInteractionEnabled = NO;
                break;
                
            default:
                break;
        }

    }

}

- (IBAction)closeKeyboard:(UITapGestureRecognizer *)sender {
    
    [[[UIApplication sharedApplication]keyWindow]endEditing:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


//选择支付方式
//- (IBAction)choosePayType:(UIButton *)sender {
//    
//    NSLog(@"%@",sender.description);
//    for (UIButton* btn in self.chooseTypeBtns) {
//        if (btn == sender) {
//            btn.enabled = NO;
//            btn.backgroundColor = [UIColor grayColor];
//            payType = [self.chooseTypeBtns indexOfObject:btn];
//        }else{
//            btn.enabled = YES;
//            btn.backgroundColor = [UIColor redColor];
//        }
//    }
//    NSLog(@"payType ==== %d",payType);
//
//}


//- (IBAction)choosePayType:(UISegmentedControl *)sender {
//    payType = sender.selectedSegmentIndex;
//}
//
//
//- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
//    
//    
//    for (UITextField *text in self.inputTextFields) {
//        if (text.text.length == 0) {
//            [Common showMsgBox:nil msg:L(@"IncompleteInformation") parentCtrl:self];
//            return NO;
//        }
//        
//        switch (text.tag) {
//                
//            case 3:
//                
//                if (![self matchStringFormat:text.text withRegex:@"^([0-9]+\\.[0-9]{2})|([0-9]+\\.[0-9]{1})|[0-9]*$"]){
//                    
//                    [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"Highest2bit")];
//                    
//                    return NO;
//                    
//                }else
//           
//                if (text.text.length >9 && ![self matchStringFormat:text.text withRegex:@"^([0-9]+\\.[0-9]{2})|([0-9]+\\.[0-9]{1})|[0-9]*$"]){
//                
//                        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"Highest2bit")];
//                    
//                    return NO;
//                
//                }else
//                    if([Common isPureInt:text.text]&& text.text.length >6){
//                    
//                        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"Highest")];
//                        
//                        return NO;
//                    
//                    }else if (text.text.length >9){
//                    
//                        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"InputCorrectAmount")];
//                        
//                        return NO;
//                    }
//                
//                
//                
//                break;
//            default:
//                break;
//        }
//        
//        
//        
//        
//        
//        
//    }
//    
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:nil];
//    
//    if([identifier isEqualToString:@"TransferSegue"]){
//        Request *req = [[Request alloc]initWithDelegate:self];
//        NSString *orderAmt = [Common orderAmtFormat:[(UITextField*)[self.inputTextFields objectAtIndex:2] text]];
//        NSString *orderDesc = self.bankCardItem.accountNo;
////        NSString *orderDesc = [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@|",self.bankCardItem.accountNo,self.bankCardItem.cardIdx,self.bankCardItem.bankName,self.bankCardItem.bankProviceId,self.bankCardItem.bankCityId,self.bankCardItem.name];
//        for (UITextField *txt in self.inputTextFields) {
//            switch (txt.tag) {
//                case 1:
//                    self.bankCardItem.name = txt.text;
//                    break;
//                default:
//                    break;
//            }
//            
//        }
//
//        NSString *orderRemark = [NSString stringWithFormat:@"%@,%@,%@,%@,%@|",self.bankCardItem.name,self.bankCardItem.bankCityId,self.bankCardItem.cardIdx,self.bankCardItem.branchBankId,self.bankCardItem.remark?self.bankCardItem.remark:@""];
//        if (payTimeType == NormalPayTimeType) {
//            productId = @"0000000000";
//            merchantId = @"0002000003";
//            if (payType == AccountPayType) {
//                [req applyOrderMobileNo:[AppDelegate getUserBaseData].mobileNo MerchanId: @"0002000002" productId:@"0000000004" orderAmt:orderAmt orderDesc:orderDesc orderRemark:orderRemark commodityIDs:@"" payTool:@"02"];
//            }else if(payType == CardPayType){
//                [req applyOrderMobileNo:[AppDelegate getUserBaseData].mobileNo MerchanId:@"0002000003" productId:@"0000000000" orderAmt:orderAmt orderDesc:orderDesc orderRemark:orderRemark commodityIDs:@"" payTool:@"01"];
//            }else{
//                [req applyOrderMobileNo:[AppDelegate getUserBaseData].mobileNo MerchanId:@"0002000003" productId:@"0000000000" orderAmt:orderAmt orderDesc:orderDesc orderRemark:orderRemark commodityIDs:@"" payTool:@"03"];
//            
//            }
//            
//        }else{
//            productId = @"0000000001";
//            merchantId = @"0002000003";
//            if (payType == AccountPayType) {
//                [req applyOrderMobileNo:[AppDelegate getUserBaseData].mobileNo MerchanId:@"0002000003" productId:@"0000000001" orderAmt:orderAmt orderDesc:orderDesc orderRemark:orderRemark commodityIDs:@"" payTool:@"02"];
//            }else if(payType == CardPayType){
//                [req applyOrderMobileNo:[AppDelegate getUserBaseData].mobileNo MerchanId:@"0002000003" productId:@"0000000001" orderAmt:orderAmt orderDesc:orderDesc orderRemark:orderRemark commodityIDs:@"" payTool:@"01"];
//            }else{
//                [req applyOrderMobileNo:[AppDelegate getUserBaseData].mobileNo MerchanId:@"0002000003" productId:@"0000000001" orderAmt:orderAmt orderDesc:orderDesc orderRemark:orderRemark commodityIDs:@"" payTool:@"03"];
//            
//            }
//            
//            
//        }
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//    }
//    return NO;
//}
- (IBAction)TransfersComfirt:(id)sender {
    
    NSString *priceVer = finalPrice.text;
    priceVer = [NSString stringWithFormat:@"%.2f",[priceVer doubleValue]];
    NSString *priceVerde = finalPrice.text;
    if ([priceVer length] > 9 || [priceVerde isEqualToString:@""] || ![self matchStringFormat:priceVer withRegex:@"^([0-9]+\\.[0-9]{2})|([0-9]+\\.[0-9]{1})|[0-9]*$"]  || [priceVer isEqualToString:@"0.00"]) {
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"转账金额不能为空或0，请重新输入")];
    }
    else if (![self matchStringFormat:priceVerde withRegex:@"^([0-9]+\\.[0-9]{2})|([0-9]+\\.[0-9]{1})|[0-9]*$"])
    {
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"CorrectPrice")];
    }else if ([self.BeneficiaryName.text length] == 0){
        [Common showMsgBox:nil msg:@"请输入收款方姓名" parentCtrl:self];
    }else if ([self.BeneficiaryAccount.text length] == 0){
        [Common showMsgBox:nil msg:@"请输入收款方账户" parentCtrl:self];
    }else if ([self.BeneficiaryAccount.text length] != 11){
        [Common showMsgBox:nil msg:@"收款方账户有误" parentCtrl:self];
    }
    else
    {
        NSString *price = [priceVer stringByReplacingOccurrencesOfString:@"." withString:@""];
        
        if ([self.isAccount isEqualToString:@"1"]) {
    
            
            //账户支付-申请订单
            [request applyOrderMobileNo:[AppDelegate getUserBaseData].mobileNo
                              MerchanId:merchantId
                              productId:productId
                               orderAmt:price
                              orderDesc:self.BeneficiaryAccount.text
                            orderRemark:@""
                           commodityIDs:@""
                                payTool:payTool];
            
            [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:L(@"OrderHasBeenSubmitted-PleaseLater")];
        }
        
    }

    
}

- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    
    if([[dict objectForKey:@"respCode"] isEqualToString:@"0000"]){
        
        if (type == REQUSET_ORDER ) {
            UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            OrderViewController *shopVc = [mainStoryboard instantiateViewControllerWithIdentifier:@"OrderViewController"];
            orderData = [[OrderData alloc]initWithData:dict];
            orderData.orderAccount = [AppDelegate getUserBaseData].mobileNo;
            orderData.orderPayType = payType;
            orderData.merchantId = merchantId;
            orderData.productId = productId;
            //                orderData.mallOrder = YES;
            shopVc.orderData = orderData;
            for (UIViewController *v in self.navigationController.viewControllers) {
                if ([v isKindOfClass:[MallViewController class]]) {
                    shopVc.delegate = v;
                }
            }
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.navigationController pushViewController:shopVc animated:YES];
        }
        
    }else{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [Common showMsgBox:nil msg:[dict objectForKey:@"respDesc"] parentCtrl:self];
    }
}

#pragma mark - UitextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField isFirstResponder]) {
        [textField resignFirstResponder];
    }
    return YES;
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
        return L(@"RealTimeReimbursement");
    }else if (row == 1) {
        return L(@"RegularPayments");
    }
    return L(@"RealTimeReimbursement");
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 2;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self.choosePayTimeBtn setTitle:[NSString stringWithFormat:@"%@",numArr[row]] forState:UIControlStateNormal];
    payTimeType = row;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.destinationViewController isKindOfClass:[OrderViewController class]]) {
        [(OrderViewController*)segue.destinationViewController setOrderData:orderData];
        
    }

}


#pragma mark - 正则判断
- (BOOL)matchStringFormat:(NSString *)matchedStr withRegex:(NSString *)regex
{
    //SELF MATCHES一定是大写
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    return [predicate evaluateWithObject:matchedStr];
}

@end
