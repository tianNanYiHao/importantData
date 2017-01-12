//
//  ChangePasswordViewController.m
//  YoolinkIpos
//
//  Created by 张倡榕 on 15/3/4.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()<ResponseData>{
    
    int showpasswordChangeTag;//标记
    NSTimer *timer;
    int Second;
    Request *requst;
}

@property (weak, nonatomic) IBOutlet UITextField *accountTextField;//账户输入框

@property (weak, nonatomic) IBOutlet UITextField *IdTextField;//身份证输入框

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;//账户输入框

@property (weak, nonatomic) IBOutlet UIButton *backPasswordButton;//找回密码按钮

@property (weak, nonatomic) IBOutlet UIButton *verificationCodeButton;//获取验证码按钮

@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTextField;//验证码输入框

@property (weak, nonatomic) IBOutlet UIView *realNameView;//真实姓名输入框背景

@property (weak, nonatomic) IBOutlet UITextField *realNameTextField;//真实姓名输入框

@property (weak, nonatomic) IBOutlet UIView *accountTextFieldBg;

@property (weak, nonatomic) IBOutlet UIView *IdTextFieldBg;

@property (weak, nonatomic) IBOutlet UIView *passwordTextFieldBg;

@property (weak, nonatomic) IBOutlet UIView *verificationCodeTextFieldBg;

@property (weak, nonatomic) IBOutlet UIImageView *switchImage;

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    showpasswordChangeTag = 1;
    requst = [[Request alloc]initWithDelegate:self];
    
    
    self.IdTextFieldBg.layer.masksToBounds = YES;
    self.IdTextFieldBg.layer.cornerRadius = 1;
    
    self.realNameView.layer.masksToBounds = YES;
    self.realNameView.layer.cornerRadius = 1;
    
    self.accountTextFieldBg.layer.masksToBounds = YES;
    self.accountTextFieldBg.layer.cornerRadius = 1;
    
    self.passwordTextFieldBg.layer.masksToBounds = YES;
    self.passwordTextFieldBg.layer.cornerRadius = 1;
    
    self.verificationCodeButton.layer.masksToBounds = YES;
    self.verificationCodeButton.layer.cornerRadius = 4;
    
    self.backPasswordButton.layer.masksToBounds = YES;
    self.backPasswordButton.layer.cornerRadius = 5;
    
    self.verificationCodeTextFieldBg.layer.masksToBounds = YES;
    self.verificationCodeTextFieldBg.layer.cornerRadius = 1;

    _switchImage.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOn:)];
    [self.switchImage addGestureRecognizer:tap];
    
    
    self.navigationController.navigationBar.barTintColor = [Common hexStringToColor:@"#068bf4"];//导航栏颜色
    self.navigationController.navigationBar.tintColor = [Common hexStringToColor:@"#ffffff"];//返回键颜色
    self.navigationController.navigationBar.contentMode = UIViewContentModeScaleAspectFit;
    //设置标题颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [Common hexStringToColor:@"#ffffff"], UITextAttributeTextColor,
                                                                     [UIFont systemFontOfSize:17], UITextAttributeFont,
                                                                     nil]];
    
    
    
    
    //自定义键盘
//    NumberKeyBoard *numberkeyboard = [[NumberKeyBoard alloc]init];
//    [numberkeyboard setTextView:self.accountTextField];
    
//    NumberKeyBoard *verificationCodenumberkeyboard = [[NumberKeyBoard alloc]init];
//    [verificationCodenumberkeyboard setTextView:self.verificationCodeTextField];
    
//    SafeStringKeyBoard *strkeyboard = [[SafeStringKeyBoard alloc]init];
//    [strkeyboard setTextView:self.passwordTextField];
//    SafeStringKeyBoard *strkeyboard2 = [[SafeStringKeyBoard alloc]init];
//    [strkeyboard2 setTextView:self.IdTextField];

    
}
- (void)tapOn:(UITapGestureRecognizer *)tap{
    
    //密码的可见显示
    if(showpasswordChangeTag == 1){
        self.passwordTextField.secureTextEntry = NO;
        showpasswordChangeTag = 2;
        self.switchImage.image = [UIImage imageNamed:@"login_abc_press"];
        
    }
    else{
        self.switchImage.image = [UIImage imageNamed:@"login_abc_nomal"];
        self.passwordTextField.secureTextEntry = YES;
        showpasswordChangeTag = 1;
    }
    
}
- (void)viewDidLayoutSubviews
{
    self.navigationController.navigationBarHidden = NO;
}


- (IBAction)backPassword:(UIButton *)sender {
    
    if([self.realNameTextField.text isEqual:@""]){
    
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"InputName")];
    
    
    }else if ([self.accountTextField.text isEqual:@""]){
    
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"InputAccount")];
        
    }else if (self.accountTextField.text.length < 11){
        
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"InputCorrectAccount")];
        
    }else if (self.accountTextField.text.length > 11){
        
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"InputCorrectAccount")];
        
    }
  /////////////////// /////////////////// /////////////////// ///////////////////
    
    else if ([self.IdTextField.text isEqual:@""]){
        
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"InputID")];
        
    }else if (self.IdTextField.text.length > 18){
        
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"InputCorrectID")];
        
    }else if (self.IdTextField.text.length < 15){
        
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"InputCorrectID")];
        
    }else if (self.IdTextField.text.length == 17){
        
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"InputCorrectID")];
        
    }
    
    
    /////////////////// /////////////////// /////////////////// ///////////////////
    
    else if ([self.passwordTextField.text isEqual:@""]){
        
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"Inputpwd")];
        
    }
    
    
    
    else if ([self.verificationCodeTextField.text isEqual:@""]){
        
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"InputCode")];
        
    }else{
        
        [requst backPasswordWithMobileNo:self.accountTextField.text newPassword:self.passwordTextField.text cardID:self.IdTextField.text mobileMac:self.verificationCodeTextField.text realNmae:self.realNameTextField.text];
    
    }
    

    
}



- (IBAction)getcode:(UIButton *)sender {
    Second = 60;
    [timer invalidate];
    timer = nil;
    
    
    
    if(self.accountTextField.text.length == 11){
        [requst getMobileMacWithAccount:self.accountTextField.text appType:@"RetrievePassword"];

        
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(repeats) userInfo:nil repeats:YES];
        
    }else{
        
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"InputCorrectNumber")];
    }
    
    
    
    
    
    
}
- (void)repeats
{
    
    if (Second > 0)
    {  --Second;
        
        self.verificationCodeButton.enabled = NO;
        [self.verificationCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        
        
        [self.verificationCodeButton setTitle:[NSString stringWithFormat:L(@"ToResendToSecond"),Second] forState:UIControlStateNormal];
    }
    else
    {
        //[self.verificationCodeButton setBackgroundImage:[UIImage imageNamed:@"fasongyanzma2.png"] forState:UIControlStateNormal];
        self.verificationCodeButton.enabled = YES;
        
        [self.verificationCodeButton setTitle:[NSString stringWithFormat:L(@"ToResend")] forState:UIControlStateNormal];
        [self.verificationCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        
        
    }
    
}
- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    

    if([dict[@"respCode"] isEqual:@"0000"]){
        if(type == REQUEST_BACKPASSWORD ){
            [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"PasswordSuccessfully")];
            
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(backTOlogin) userInfo:nil repeats:NO];
            
        }else if(type == REQUEST_GETMOBILEMAC){
            [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"VerificationCodeSentSuccessfully")];
            
        }
    }
    else{
        
        [MBProgressHUD showHUDAddedTo:self.view WithString:dict[@"respDesc"]];
        
    }
    
}


- (void)backTOlogin{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
