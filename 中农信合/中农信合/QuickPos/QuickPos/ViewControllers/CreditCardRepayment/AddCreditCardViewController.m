//
//  AddCreditCardViewController.m
//  QuickPos
//
//  Created by Leona on 15/3/12.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "AddCreditCardViewController.h"
#import "BankListViewController.h"
#import "AccountOfProvincesViewController.h"
#import "AccountOfCityViewController.h"
#import "BankOfBranchViewController.h"
#import "PayType.h"
#import "TakeCashViewController.h"
#import "TransferViewController.h"
#import "CreditCardPayDetailViewController.h"
#import "Common.h"
#import "UserInfo.h"



@interface AddCreditCardViewController ()<UITextFieldDelegate,ResponseData>{

    
    NSUserDefaults *userDefaults;//存取
    NSDictionary *dataDic;//请求返回字典
    
    Request *request;
    
    int banktag;//银行类标记
    int provincestag;//省份类标记
    int citytag;//城市类标记
    int branchtag;//支行类标记
    
    BankCardItem *item;
    
}
@property (weak, nonatomic) IBOutlet UIButton *comfirtbtn;

@property (weak, nonatomic) IBOutlet UIView *ios6UseAddView;//用于ios6显示

@property (weak, nonatomic) IBOutlet UITextField *bankCardNumberTextField;//银行卡输入框

@property (weak, nonatomic) IBOutlet UIView *confirmBankCardNumberTextFiedBg;

@property (weak, nonatomic) IBOutlet UITextField *confirmBankCardNumberTextFied;//手机号


@property (weak, nonatomic) IBOutlet UITextField *realNameTextField;//真实姓名输入框

@property (weak, nonatomic) IBOutlet UIView *bankCardNumberTextFieldBg;//银行卡输入框容器view

@property (weak, nonatomic) IBOutlet UIView *bankBelongTextFieldBg;//总行输入框容器view

@property (weak, nonatomic) IBOutlet UIView *accountOfProvincesTextFieldBg;//省份输入框容器view

@property (weak, nonatomic) IBOutlet UIView *accountOfCityTextFieldBg;//城市输入框容器view

@property (weak, nonatomic) IBOutlet UIView *accountOfBankDataTextFieldBg;//支行输入框容器view

@property (weak, nonatomic) IBOutlet UIButton *bankListButton;//总行

@property (weak, nonatomic) IBOutlet UIButton *provincesListButton;//省份

@property (weak, nonatomic) IBOutlet UIButton *cityListButton;//城市

@property (weak, nonatomic) IBOutlet UIButton *banchListButton;//支行

@property (weak, nonatomic) IBOutlet UIScrollView *addBankcardScrollView;

@property (nonatomic,strong) NSString *authenFlag;

@end



@implementation AddCreditCardViewController


@synthesize destinationType;


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    banktag = 1000;
    provincestag = 1001;
    citytag = 1002;
    branchtag = 1003;
    
    request = [[Request alloc]initWithDelegate:self];
    [request userInfo:[AppDelegate getUserBaseData].mobileNo];
    
    if(![UIDevice currentDevice].isIOS6){
        
        self.automaticallyAdjustsScrollViewInsets = NO;
        
    }
    
    //    self.ios6UseAddView.hidden = YES;
    //
    //    if([UIDevice currentDevice].isIOS6){
    //
    //        self.ios6UseAddView.hidden = NO;
    //
    //
    //    }else{
    //
    //        self.ios6UseAddView.hidden = YES;
    //
    //    }
    
    
    self.title = @"添加信用卡";
    self.comfirtbtn.layer.cornerRadius = 5;
    
    dataDic = [NSDictionary dictionary];
    item = [[BankCardItem alloc]init];
    
    self.bankCardNumberTextFieldBg.layer.masksToBounds = YES;
    self.bankCardNumberTextFieldBg.layer.cornerRadius = 1;
    
    self.confirmBankCardNumberTextFiedBg.layer.masksToBounds = YES;
    self.confirmBankCardNumberTextFiedBg.layer.cornerRadius = 1;
    
    self.accountOfProvincesTextFieldBg.layer.masksToBounds = YES;
    self.bankCardNumberTextFieldBg.layer.cornerRadius = 1;
    
    self.accountOfProvincesTextFieldBg.layer.masksToBounds = YES;
    self.accountOfProvincesTextFieldBg.layer.cornerRadius = 1;
    
    self.accountOfCityTextFieldBg.layer.masksToBounds = YES;
    self.accountOfCityTextFieldBg.layer.cornerRadius = 1;
    
    self.accountOfBankDataTextFieldBg.layer.masksToBounds = YES;
    self.accountOfBankDataTextFieldBg.layer.cornerRadius = 1;
    
    self.bankCardNumberTextField.tintColor = [Common hexStringToColor:@"#068bf4"];
    self.confirmBankCardNumberTextFied.tintColor = [Common hexStringToColor:@"#068bf4"];
    
//    self.realNameTextField.userInteractionEnabled = YES;
    
    //自定义键盘
//        NumberKeyBoard *numberkeyboard = [[NumberKeyBoard alloc]init];
//        [numberkeyboard setTextView:self.bankCardNumberTextField];
//    
//        NumberKeyBoard *confirmNumberkeyboard = [[NumberKeyBoard alloc]init];
//        [confirmNumberkeyboard setTextView:self.confirmBankCardNumberTextFied];
//    
    
    
    
}

-(void)viewDidLayoutSubviews
{
    
    if([UIDevice currentDevice].isIphone4){
        
        self.addBankcardScrollView.contentSize = CGSizeMake(0,500);
        
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    
    self.realNameTextField.text = [AppDelegate getUserBaseData].userName;
    self.realNameTextField.userInteractionEnabled = NO;
    
}



- (IBAction)addBankCard:(UIButton *)sender {
    if (self.confirmBankCardNumberTextFied.text.length == 0) {
        [MBProgressHUD showHUDAddedTo:self.view WithString:@"请输入手机号码"];
    }else if (self.confirmBankCardNumberTextFied.text.length > 11){
        [MBProgressHUD showHUDAddedTo:self.view WithString:@"请输入正确手机号码"];
    }
    else if (self.bankCardNumberTextField.text.length == 0){
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"InputBankCardNumber")];
    }
    else if (self.bankCardNumberTextField.text.length < 16){
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"InputCorrectBankCardNumber")];
    }
   
    else if (self.bankCardNumberTextField.text.length > 23){
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"InputCorrectBankCardNumber")];
    }else {

        [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"正在验证卡."];
        
        
        [request BankCardBind:[self.bankCardNumberTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""]
                    andMobile:self.confirmBankCardNumberTextFied.text
                  andcustName:self.realNameTextField.text
                  andBandType:@"04"
         ];
        
    }
    
}


- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    
    
//    if ([[dict objectForKey:@"respDesc"]isEqualToString:@"0000"]) {
    
       
        
        if(type == REQUSET_BankCardBind ){
            
            
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            CreditCardPayDetailViewController *creditCardPay = [mainStoryboard instantiateViewControllerWithIdentifier:@"CreditCardPayDetailViewController"];
            
            
            creditCardPay.BeneficiaryAccount = self.bankCardNumberTextField.text;
            item.name = self.realNameTextField.text;
            creditCardPay.BeneficiaryName = self.realNameTextField.text;
            creditCardPay.BeneficiaryPhoneField = self.confirmBankCardNumberTextFied.text;
            NSLog(@"%@  %@  %@",creditCardPay.BeneficiaryAccount,creditCardPay.BeneficiaryName,creditCardPay.BeneficiaryPhoneField);
        
            [self.navigationController pushViewController:creditCardPay animated:YES];
            
            dataDic = dict;
            
            
            [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"BindingSuccess")];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
//            [self.navigationController popViewControllerAnimated:YES];
            
        }
        else if(type == REQUEST_QUERYCREDITINFO){
            
            CreditCardPayDetailViewController *tr = [self.storyboard instantiateViewControllerWithIdentifier:@"CreditCardPayDetailViewController"];
            
            item.cardIdx = [dict objectForKey:@"bankId"];
            item.bankName = [dict objectForKey:@"bankName"];
            item.payMode = [dict objectForKey:@"payMode"];
            
            tr.bankCardItem = item;
            [self.navigationController pushViewController:tr animated:YES];

        }else if (type == REQUSET_USERINFOQUERY){
            
            self.authenFlag = [[[dict objectForKey:@"data"]objectForKey:@"resultBean"]objectForKey:@"authenFlag"];
            NSLog(@"%@",self.authenFlag);
            
            if ([self.authenFlag isEqualToString:@"3"]) {
                
            }else
            {
                [Common showMsgBox:nil msg:@"请实名认证后,再进行操作" parentCtrl:self];
                self.bankCardNumberTextField.userInteractionEnabled = NO;
                self.confirmBankCardNumberTextFied.userInteractionEnabled = NO;
                
                
            }
        }
    
    else{
        
        [MBProgressHUD showHUDAddedTo:self.view WithString:dict[@"respDesc"]];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
//}
}
- (IBAction)CardNumberTextFildAct:(UITextField *)sender {
    
    
    
    
    
}

//输入银行卡号时,每4位,空格隔开
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.bankCardNumberTextField) {
        NSString *text = self.bankCardNumberTextField.text;
        
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
        string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
            return NO;
        }
        text = [text stringByReplacingCharactersInRange:range withString:string];
        text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSString *newString = @"";
        while (text.length > 0) {
            NSString *subString = [text substringToIndex:MIN(text.length, 4)];
            newString = [newString stringByAppendingString:subString];
            if (subString.length == 4) {
                newString = [newString stringByAppendingString:@" "];
            }
            text = [text substringFromIndex:MIN(text.length, 4)];
        }
        
        newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
        
        //    if (newString.length >= 20) {
        //        return NO;
        //    }
        
        [textField setText:newString];
    }
    else{
        return YES;
    }
    return NO;
}



- (IBAction)bankListAct:(UIButton *)sender {
    
    if(![self.bankCardNumberTextField.text isEqual:@""]){
        
        item.accountNo = self.bankCardNumberTextField.text;
        
        banktag =88;
        BankListViewController *BankList = [self.storyboard instantiateViewControllerWithIdentifier:@"banklistVC"];
        
        [self.navigationController pushViewController:BankList animated:YES];
        
    }else{
        
        
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"InputBankCardNumber")];
        
    }
    
    
}

- (IBAction)provincesListAst:(UIButton *)sender {
    
    if(banktag == 88){
        
        AccountOfProvincesViewController *provincesVC = [self.storyboard instantiateViewControllerWithIdentifier:@"provincesVC"];
        
        provincestag = 99;
        
        [self.navigationController pushViewController:provincesVC animated:YES];
        
    }else if (banktag == 1000){
        
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"ChooseBelongBank")];
        
        
    }
    
}


- (IBAction)cityListAct:(UIButton *)sender {
    
    if(provincestag == 99){
        
        AccountOfCityViewController*cityVC = [self.storyboard instantiateViewControllerWithIdentifier:@"cityVC"];
        
        citytag = 77;
        
        [self.navigationController pushViewController:cityVC animated:YES];
        
    }else if(provincestag == 1001){
        
        
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"ChooseProvinces")];
        
    }
}

- (IBAction)banchListAct:(UIButton *)sender {
    
    if(citytag == 77){
        
        BankOfBranchViewController*branchVC = [self.storyboard instantiateViewControllerWithIdentifier:@"branchVC"];
        
        branchtag = 66;
        
        [self.navigationController pushViewController:branchVC animated:YES];
        
    }else if (branchtag ==1003){
        
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"ChooseCity")];
        
    }
    
    
    
    
    
}

//- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    
//    if ([textField isFirstResponder]) {
//        
//        [textField resignFirstResponder];
//        
//    }
//    return YES;
//}
//


@end
