
//
//  TakeCashViewController.m
//  QuickPos
//
//  Created by Leona on 15/4/3.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "TakeCashViewController.h"
#import "XYSwitch.h"
#import "Common.h"
#import "WebViewController.h"

@interface TakeCashViewController ()<ResponseData>{
 
    NSTimer *timer;//倒计时
    
    int Second;//秒数
    
    Request*request;

    NSDictionary *dataDic;//请求返回字典
    
    NSString *availableAmtStr;//账户余额
    
    NSString *cashAvailableAmtStr;//可提现余额
    
    NSString *realNameStr;//用来取用户名
    
    NSString *newCardNumber;//截取卡号后的赋值
    
    NSString *picStr;//头像str
    
    int requestType;//请求标记
    
    UIImage *image;//GCD头像用
    
    NSData *data;//GCD转换数据库的头像用
    
    int buttonTag;//提现属性标记
    
    NSString *cashType;//提现类型
    
    
    
    
}
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;//头像容器

@property (weak, nonatomic) IBOutlet UIView *infoView;//显示信息的容器view

@property (weak, nonatomic) IBOutlet UILabel *NameLabel;//账户名

@property (weak, nonatomic) IBOutlet UILabel *accountBalanceLabel;//账户余额

@property (weak, nonatomic) IBOutlet UILabel *CanCashBalancesLabel;//可提现余额

@property (weak, nonatomic) IBOutlet UITextField *amountTextField;//提款金额输入框

@property (weak, nonatomic) IBOutlet UITextField *mobileMacTextField;//验证码输入框

@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;//获取验证码按钮

@property (weak, nonatomic) IBOutlet UIButton *takeCashButton;//提现按钮

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;//登入密码输入框

@property (weak, nonatomic) IBOutlet XYSwitch *normalButton;//普通提现

@property (weak, nonatomic) IBOutlet XYSwitch *fastButton;//快速提现
@property (nonatomic, strong)UIBarButtonItem *help;

@property (weak, nonatomic) IBOutlet UIButton *comfirt;

@end

@implementation TakeCashViewController

@synthesize cardIdx;
@synthesize cardNumber;


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = L(@"TakeCash");
    
//    [self creatRightBtn];
    
    self.comfirt.layer.cornerRadius = 5;
    self.infoView.layer.masksToBounds = YES;
    self.infoView.layer.cornerRadius = 1;
    
    self.amountTextField.layer.masksToBounds = YES;
    self.amountTextField.layer.cornerRadius = 1;
    
    self.passwordTextField.layer.masksToBounds = YES;
    self.passwordTextField.layer.cornerRadius = 1;
    
    self.getCodeButton.layer.masksToBounds = YES;
    self.getCodeButton.layer.cornerRadius = 1;
    
    
    self.takeCashButton.layer.masksToBounds = YES;
    self.takeCashButton.layer.cornerRadius = 1;
    
    self.mobileMacTextField.layer.masksToBounds = YES;
    self.mobileMacTextField.layer.cornerRadius = 1;
    
    
    
//    self.help = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"phone_help"] style:UIBarButtonItemStylePlain target:self action:@selector(helpClick)];
//    
//    [self.navigationItem setRightBarButtonItem:self.help];
//    
//    self.navigationItem.rightBarButtonItem.tintColor = [Common hexStringToColor:@"46a7ec"];
    
    
    requestType = 1;
    
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = 35;
    
    
    //获取到的卡号做截取后4位的操作
    
    newCardNumber = [cardNumber substringFromIndex:cardNumber.length-4];
    
    
    
    //键盘绑定
    
//    NumberKeyBoard *numberkeyboard = [[NumberKeyBoard alloc]init];
//    [numberkeyboard setTextView:self.amountTextField];
//    
//    NumberKeyBoard *numberkeyboard2 = [[NumberKeyBoard alloc]init];
//    [numberkeyboard2 setTextView:self.mobileMacTextField];
    
    
    
    [self.normalButton setOnImage:[UIImage imageNamed:@"xuanzeyuandian"] offImage:[UIImage imageNamed:@"yuandian"]];//设置图片
    
    [self.fastButton setOnImage:[UIImage imageNamed:@"xuanzeyuandian"] offImage:[UIImage imageNamed:@"yuandian"]];//设置图片
    
     buttonTag = 9;
    
    self.fastButton.on=YES;//默认快速提款
    
    if(self.fastButton.on){
    
      cashType = @"1";
    
    
    }
    
    
    
    
    
    request = [[Request alloc]initWithDelegate:self];
    
    
    
    [request userInfo:[AppDelegate getUserBaseData].mobileNo];//用户信息
    
    [request getVirtualAccountBalance:@"00" token:[AppDelegate getUserBaseData].token];//账户信息
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:L(@"MBPLoading")];
    [hud hide:YES afterDelay:2];
    
    
    
    
    
    
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
    WebViewController *web = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    [web setTitle:L(@"help")];
    [web setUrl:WithdrawHelp];
    [self.navigationController pushViewController:web animated:YES];
}

- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    
    
    if(type == REQUSET_USERINFOQUERY && [dict[@"respCode"]isEqual:@"0000"] ){
        
        //用户名的返回
        
        dataDic = dict;
        
        NSMutableDictionary *getDic = [NSMutableDictionary dictionary];
        getDic = dict[@"data"];
        
        NSDictionary*realNameDic=[NSDictionary dictionary];
        realNameDic = getDic[@"resultBean"];
        
        realNameStr = realNameDic[@"realName"];
        
        self.NameLabel.text = realNameStr;
        
        picStr = realNameDic[@"pic"];
        
        //state = realNameDic[@"authenFlag"];
        
        
        //GCD操作
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 耗时的操作
            
            image = [UIImage imageWithData:[self headImage:picStr]];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // 更新界面
                if([picStr isEqual:@""]){
                    
                    self.headImageView.image = [UIImage imageNamed:@"icon"];
                    
                }else{
                    
                    self.headImageView.image = image;
                    
                }
                
            });
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
        
        
        
        
        
        
    }else if(type == REQUEST_ACCTENQUIRY && [dict[@"respCode"]isEqual:@"0000"] ){
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        
        //账户金额的返回
        
        dataDic = dict;
        double userSum = [[dict objectForKey:@"availableAmt"] doubleValue];
        double withdrawSum = [[dict objectForKey:@"cashAvailableAmt"] doubleValue];
        
        availableAmtStr = [NSString stringWithFormat:@"%0.2f",userSum/100];
        cashAvailableAmtStr = [NSString stringWithFormat:@"%0.2f",withdrawSum/100];
        
        self.accountBalanceLabel.text = availableAmtStr;
        self.CanCashBalancesLabel.text = cashAvailableAmtStr;
        
    }else if([dict[@"respCode"]isEqual:@"0000"] && type == REQUSET_JFPalCash){
        
        //提现的返回
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [Common showMsgBox:nil msg:@"提现成功" parentCtrl:self];
        timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(back) userInfo:nil repeats:NO];
        
        
        
        
    }else if([dict[@"respCode"]isEqual:@"0000"] && type == REQUEST_GETMOBILEMAC){
        
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"VerificationCodeSentSuccessfully")];
        
    }else {
        
//        [MBProgressHUD showHUDAddedTo:self.view WithString:dict[@"respDesc"]];
        [Common showMsgBox:nil msg:dict[@"respDesc"] parentCtrl:self];
        
    }
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}


- (void)back{

    [self.navigationController popToRootViewControllerAnimated:YES];


}



- (IBAction)getcode:(UIButton *)sender {
    
    Second = 60;
    
    [timer invalidate];
    
    timer = nil;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(repeats) userInfo:nil repeats:YES];

    [request getMobileMacWithAccount:[AppDelegate getUserBaseData].mobileNo appType:@"JFPalAcctPay"];
    
    
    
    
    
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

- (IBAction)takeCashAct:(UIButton *)sender {
    
    
    
    if([self.amountTextField.text isEqual:@""]){
        
         [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"TakeCashAmount")];
        
    }else if(![Common isPureInt:self.amountTextField.text]){
        
         [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"AmountMustBeInteger")];
        
    }else if([self.passwordTextField.text isEqual:@""]){
        
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"InputLoginPassward")];
        
    }else if([self.mobileMacTextField.text isEqual:@""]){
        
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"InputCode")];
        
    }else
            if([Common isPureInt:self.amountTextField.text] && self.amountTextField.text.length >6){
                
                [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"Highest")];
                
                
                
            }
    
        else{
        
        requestType = 7;
        
        
        //元转分
        float turnCash = [self.amountTextField.text floatValue];
        
        NSString *turnStr = [NSString stringWithFormat:@"%0.2f",turnCash];
        
        turnStr = [turnStr stringByReplacingOccurrencesOfString:@"." withString:@""];
        
        
 
            [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"请稍后.."];
        [request takeCash:turnStr andPassword:self.passwordTextField.text andMobileMac:self.mobileMacTextField.text andCashType:cashType andCardTag:newCardNumber andCardIdx:cardIdx];
    }
    
    

    
}



-(NSData *)headImage:(NSString *)icon{
    
    int len = [icon length] / 2;    // Target length
    unsigned char *buf = malloc(len);
    unsigned char *whole_byte = buf;
    char byte_chars[3] = {'\0','\0','\0'};
    
    int i;
    for (i = 0; i < [icon length] / 2; i++) {
        byte_chars[0] = [icon characterAtIndex:i*2];
        byte_chars[1] = [icon characterAtIndex:i*2+1];
        * whole_byte = strtol(byte_chars, NULL, 16);
        whole_byte++;
    }
    
    data = [NSData dataWithBytes:buf length:len];
    
    
    return data;
}


- (IBAction)normalButtonAct:(UIButton *)sender {
    buttonTag = 9;
    
    if(buttonTag == 9){
        
        NSLog(@"开启");
        
        self.fastButton.on = NO;
       
        cashType = @"0";
        
        
    }else {
        
        NSLog(@"关闭");
    }

}

- (IBAction)fastButtonAct:(UIButton *)sender {
    
    buttonTag = 3;
    
    
    if(buttonTag == 3){
        
        NSLog(@"开启");
        
        self.normalButton.on = NO;
        
        cashType = @"1";
        
        
    }else {
        
        NSLog(@"关闭");
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
