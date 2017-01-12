//
//  BindingSDJBankCardViewController.m
//  QuickPos
//
//  Created by feng Jie on 16/7/29.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "BindingSDJBankCardViewController.h"
#import "SDJBankPayViewController.h"
#import "Request.h"
#import "UserInfo.h"
#import "QuickBankData.h"
#import "BankListViewController.h"
#import "SDJBankViewController.h"
#import "Common.h"

@interface BindingSDJBankCardViewController ()<ResponseData,UITextFieldDelegate>
{

    Request *request;
    OrderData *orderId;
    QuickBankData *bankData;
    QuickBankItem *bankItem;
    
    int Second;//秒数
    NSTimer *timer;//倒计时
    NSMutableArray *resultBeanArr;
    NSDictionary *resultDict;
    
    
    int banktag;//银行类标记
    NSUserDefaults *userDefaults;//存取
    BankCardItem *item;
    

}
@property (weak, nonatomic) IBOutlet UITextField *AccountNameTextField;//开户人

@property (weak, nonatomic) IBOutlet UITextField *bankCardNumTextField;//银行卡号

@property (weak, nonatomic) IBOutlet UITextField *ICCardNumTextField;//身份证号

@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;//手机号

@property (weak, nonatomic) IBOutlet UITextField *smsTextField;//短信输入框

@property (nonatomic,strong) NSString *bankCode;

@property (weak, nonatomic) IBOutlet UIButton *GetCodeBtn;//获取验证码Btn


@property (weak, nonatomic) IBOutlet UIButton *chooseBankBtn;//选择银行按钮

@property (nonatomic,strong) NSString *bindID;

@property (nonatomic,strong) NSString *bankName;

@property (nonatomic,strong) NSString *message;

@property (nonatomic,strong) NSString *respCode;

@property (nonatomic,strong) NSString *authenFlag;

@end

@implementation BindingSDJBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定银行卡";
    
    self.bankCardNumTextField.delegate = self;
    
    banktag = 1000;
    request = [[Request alloc]initWithDelegate:self];
     [request userInfo:[AppDelegate getUserBaseData].mobileNo];
}
//获取短信验证码
- (IBAction)GetSMSCode:(id)sender {
    
    Second = 120;
    
    [timer invalidate];
    
    timer = nil;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(repeats) userInfo:nil repeats:YES];
    [request QuickBankCardComfirmSdjSmsWithbindID:self.bankCardNumTextField.text mobileNo:self.phoneNumTextField.text];
    
}

- (void)repeats
{
    
    if (Second > 0)
    {  --Second;
        
        self.GetCodeBtn.enabled = NO;
        [self.GetCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        
        
        [self.GetCodeBtn setTitle:[NSString stringWithFormat:L(@"ToResendToSecond"),Second] forState:UIControlStateNormal];
        
        
    }else
    {
        [self.GetCodeBtn setBackgroundImage:[UIImage imageNamed:@"fasongyanzma2.png"] forState:UIControlStateNormal];
        self.GetCodeBtn.enabled =YES;
        
        [self.GetCodeBtn setTitle:[NSString stringWithFormat:L(@"ToResend")] forState:UIControlStateNormal];
        [self.GetCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        
        
    }
    
}
- (void)viewWillAppear:(BOOL)animated
{
    //银行的通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(banktongzhi:) name:@"banktongzhi" object:nil];
}

//银行赋值
- (void)banktongzhi:(NSNotification *)text{
    
    
    NSDictionary *dic = (NSDictionary*)text.object;
    
    self.bankName = [dic objectForKey:@"bankName"];
    self.bankCode = [dic objectForKey:@"bankCode"];
    [self.chooseBankBtn setTitle:[dic objectForKey:@"bankName"] forState:UIControlStateNormal];
    NSLog(@"%@  %@  %@  %@",self.bankName,self.bankCode,dic,[dic objectForKey:@"bankName"]);
    
    NSLog(@"%@",text.object);
    NSLog(@"－－－－－接收到通知------");
    
    
}

//选择银行列表
- (IBAction)bankList:(id)sender {
    
    if ([self.smsTextField.text length] == 0) {
        [Common showMsgBox:nil msg:@"请先输入短信验证码" parentCtrl:self];
    }
    else if(![self.bankCardNumTextField.text isEqual:@""]){
        
        item.accountNo = self.bankCardNumTextField.text;
        
        banktag =88;
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"QuickPay" bundle:nil];
        SDJBankViewController *SDJBankVc = [mainStoryboard instantiateViewControllerWithIdentifier:@"SDJBankVc"];
        
        SDJBankVc.resultBeanArray = self->resultBeanArr;
        NSLog(@"%@",SDJBankVc.resultBeanArray);
        [self.navigationController pushViewController:SDJBankVc animated:YES];
        
    }else{
        
        
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"InputBankCardNumber")];
        
    }
}

//确定按钮
- (IBAction)comfirmBtn:(id)sender {
    
    
    
    if ([self.smsTextField.text length] == 0) {
        [Common showMsgBox:nil msg:@"请先输入短信验证码" parentCtrl:self];
    }else if (banktag == 1000){
        [Common showMsgBox:nil msg:@"请选择开户银行" parentCtrl:self];
    }else{
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"正在绑定银行卡.."];
        [request QuickBankCardPaySdjWithorderId:self.orderId
                                         cardNo:[self.bankCardNumTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""]
                                   customerName:self.AccountNameTextField.text
                                  legalCertType:@"1"
                                   legalCertPid:self.ICCardNumTextField.text
                                       cardType:@"0"
                               referrerMobileNo:self.smsTextField.text
                                       mobileNo:self.phoneNumTextField.text
                                          phone:@""
                                       bankCode:self.bankCode
                                   unitBankCode:@""
         ];
        
    }
    
    
}

- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type
{
    if (type == REQUSET_QUICKBANKCARDCOMFIRMSDJSMS) {
        
        resultBeanArr = [[dict objectForKey:@"data"]objectForKey:@"resultBean"];
        
        if (resultBeanArr.count == 0) {
            bankData = [[QuickBankData alloc]initWithData:dict];
        }else{
            bankData = [[QuickBankData alloc]initWithData:dict];
            self.message = [[[dict objectForKey:@"data"]objectForKey:@"result"]objectForKey:@"message"];
            NSLog(@"%@",self.message);
            resultDict = resultBeanArr[0];
            self.bankCode = [resultDict objectForKey:@"bankCode"];
            self.bankName = [resultDict objectForKey:@"bankName"];
            
            NSLog(@"%@  %@",self.bankCode,self.bankName);
            
        }
    }
    
    
    else if (type == REQUSET_QUICKBANKCARDPAYSDJ) {
        
        self.respCode = [dict objectForKey:@"respCode"];
        NSLog(@"%@",self.respCode);
        
        if ([self.respCode isEqualToString:@"0000"]) {
            UIStoryboard *quickStoryboard = [UIStoryboard storyboardWithName:@"QuickPay" bundle:nil];
            SDJBankPayViewController *SDJBankPayVc = [quickStoryboard instantiateViewControllerWithIdentifier:@"SDJBankPayVc"];
            [SDJBankPayVc setOrderData:self.orderData];
            SDJBankPayVc.bankCodes = self.bankCode;
            SDJBankPayVc.ICCardNo = self.ICCardNumTextField.text;
            SDJBankPayVc.bankCardNo = [self.bankCardNumTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
            SDJBankPayVc.phoneNo = self.phoneNumTextField.text;
            SDJBankPayVc.orderId = self.orderId;
            SDJBankPayVc.orderAmt = self.orderAmt;
            SDJBankPayVc.bankName = self.bankName;
            SDJBankPayVc.AccountName = self.AccountNameTextField.text;
            SDJBankPayVc.mobileNo = self.phoneNumTextField.text;
            
            NSLog(@"%@  %@",SDJBankPayVc.bankCodes,self.bankCode);
            
            [self.navigationController pushViewController:SDJBankPayVc animated:YES];
        }else
        {
            
            [Common showMsgBox:nil msg:dict[@"respDesc"] parentCtrl:self];
        }
        
        
    }
    else if (type == REQUSET_USERINFOQUERY){
        
        self.authenFlag = [[[dict objectForKey:@"data"]objectForKey:@"resultBean"]objectForKey:@"authenFlag"];
        NSLog(@"%@",self.authenFlag);
        
        if ([self.authenFlag isEqualToString:@"3"]) {
            
        }else
        {
            [Common showMsgBox:nil msg:@"请实名认证后,再进行操作" parentCtrl:self];
            self.bankCardNumTextField.userInteractionEnabled = NO;
            self.AccountNameTextField.userInteractionEnabled = NO;
            self.ICCardNumTextField.userInteractionEnabled = NO;
            self.phoneNumTextField.userInteractionEnabled = NO;
            self.smsTextField.userInteractionEnabled = NO;
            self.chooseBankBtn.userInteractionEnabled = NO;
            
        }
    }

    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}

//输入银行卡号时,每4位,空格隔开
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.bankCardNumTextField) {
        NSString *text = self.bankCardNumTextField.text;
        
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
