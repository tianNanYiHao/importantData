//
//  CardToCardPayViewController.m
//  QuickPos
//
//  Created by feng Jie on 16/6/19.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "CardToCardPayViewController.h"
#import "Request.h"
#import "OrderData.h"
#import "Common.h"
#import "OrderViewController.h"
#import "ChooseView.h"
#import "PayType.h"
#import "WebViewController.h"
#import "MallViewController.h"
#import "HelpViewController.h"

@interface CardToCardPayViewController ()<ResponseData,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,ChooseViewDelegate>{
    
    NSUInteger payType;
    NSUInteger payTimeType;//普通、实时
    OrderData *orderData;
    NSArray *numArr;
    NSString *productId;
    NSString *merchantId;
    NSRange  ran;
    Request *request;
    NSString *payTool;
    NSMutableArray *commodityIDArr;
    NSString *orderDesc;
    NSString *commodityIDs; //商品id
    
}
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *chooseTypeBtns;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *inputTextFields;//金额
@property (weak, nonatomic) IBOutlet UITextField *finalPrice;//转账金额

@property (weak, nonatomic) IBOutlet UITextField *BeneficiaryName;//收款方姓名
@property (weak, nonatomic) IBOutlet UITextField *BeneficiaryAccount;//收款方账户
@property (weak, nonatomic) IBOutlet UITextField *BeneficiaryPhoneField;//收款方手机号
@property (weak, nonatomic) IBOutlet UILabel *BeneficiaryPhoneLabel;//



@property (weak, nonatomic) IBOutlet UIButton *choosePayTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *transferToHim;
@property (weak, nonatomic) IBOutlet UISegmentedControl *payTypeSeg;
@property (weak, nonatomic) IBOutlet UIView *_subview;
@property (nonatomic, strong)UIBarButtonItem *help;
@property (weak, nonatomic) IBOutlet UIButton *comfirt;//转账确认按钮
@property (nonatomic, strong) NSString *isAccount;//是否是账户充值的标准

@end

@implementation CardToCardPayViewController
@synthesize finalPrice;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"卡卡转账";
   
    
    self.comfirt.layer.cornerRadius = 5;
   
    UIView *tip = [Common tipWithStr:@"2小时内到账 手续费1% 15元封顶" color:[UIColor redColor] rect:CGRectMake(0, CGRectGetMaxY(_comfirt.frame)+50, self.view.frame.size.width, 40)];
    [self.view addSubview:tip];
    
//    [self creatRightBtn];
    
    numArr = @[@"实时还款",@"普通还款"];
//    payType = CardPayType;
    payTimeType = NormalPayTimeType;
    NSLog(@"%@",self.chooseTypeBtns);
    request = [[Request alloc]initWithDelegate:self];
    
    self.comfirt.userInteractionEnabled = YES;
    
    
    merchantId = @"0001000005";
    productId = @"0000000000";
    payTool = @"01";
    self.isAccount = @"0";
    payType = CardPayType;
    commodityIDArr = [NSMutableArray array];
    orderDesc = [NSMutableString string];
    
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



- (IBAction)TransfersComfirt:(id)sender {//确认按钮-确认支付
    
    NSString *priceVer = finalPrice.text;
    priceVer = [NSString stringWithFormat:@"%.2f",[priceVer doubleValue]];
    NSString *priceVerde = finalPrice.text;
    if ([priceVer length] > 9 || [priceVerde isEqualToString:@""] || ![self matchStringFormat:priceVer withRegex:@"^([0-9]+\\.[0-9]{2})|([0-9]+\\.[0-9]{1})|[0-9]*$"]  || [priceVer isEqualToString:@"0.00"]) {
//        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"请输入充值金额")];
        [Common showMsgBox:nil msg:@"请输入充值金额" parentCtrl:self];
    }
    else if (![self matchStringFormat:priceVerde withRegex:@"^([0-9]+\\.[0-9]{2})|([0-9]+\\.[0-9]{1})|[0-9]*$"])
    {
//        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"CorrectPrice")];
        [Common showMsgBox:nil msg:L(@"CorrectPrice") parentCtrl:self];
    }else if ([self.BeneficiaryName.text length] == 0){
        [Common showMsgBox:nil msg:@"请输入收款人姓名" parentCtrl:self];
    }else if ([self.BeneficiaryAccount.text length] == 0){
        [Common showMsgBox:nil msg:@"请输入收款方卡号" parentCtrl:self];
    }else if ([self.BeneficiaryAccount.text length] < 16){
        [Common showMsgBox:nil msg:@"请输入正确的银行卡号" parentCtrl:self];
    }else if ([self.BeneficiaryAccount.text length] >19){
        [Common showMsgBox:nil msg:@"请输入正确的银行卡号" parentCtrl:self];
    }else if ([self.BeneficiaryPhoneField.text length] == 0){
        [Common showMsgBox:nil msg:@"请输入收款方手机号" parentCtrl:self];
    }else if ([self.BeneficiaryPhoneField.text length] != 11){
        [Common showMsgBox:nil msg:@"请输入正确的手机号" parentCtrl:self];
    }else
    {
        NSString *price = [priceVer stringByReplacingOccurrencesOfString:@"." withString:@""];
        
        
        if ([self.isAccount isEqualToString:@"0"]) {
        
            
            //
            [request applyOrderMobileNo:[AppDelegate getUserBaseData].mobileNo
                              MerchanId:merchantId
                              productId:productId
                               orderAmt:price
                              orderDesc:self.BeneficiaryAccount.text
                            orderRemark:@""
                           commodityIDs:@""
                                payTool:payTool];
            
            [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:L(@"OrderHasBeenSubmitted-PleaseLater")];
            NSLog(@"%@",self.BeneficiaryAccount.text);
        }
        
    }
    
    
}

- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
  
    
//        if([[dict objectForKey:@"respCode"]isEqualToString:@"0000"]){
    if (type == REQUSET_ORDER) {
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        OrderViewController *shopVc = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderViewController"];
        orderData = [[OrderData alloc]initWithData:dict];
    
        shopVc.ReceivablesName = self.BeneficiaryName.text;
        shopVc.ReceivablesPhoneNo = self.BeneficiaryPhoneField.text;
        shopVc.ReceivablesCardNo = self.BeneficiaryAccount.text;

        orderData = [[OrderData alloc]initWithData:dict];
        orderData.orderAccount = self.BeneficiaryAccount.text;
        orderData.orderPayType = payType;
        orderData.merchantId = merchantId;
        orderData.productId = productId;
        orderData.isCardToCardPay = YES;
        shopVc.orderData = orderData;
        
        NSLog(@"%@ %@ %d %@ %@ %@",orderData,orderData.orderAccount,orderData.orderPayType,orderData.merchantId,orderData.productId,shopVc.orderData);
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




