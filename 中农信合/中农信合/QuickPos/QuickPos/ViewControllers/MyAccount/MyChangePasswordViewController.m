//
//  MyChangePasswordViewController.m
//  QuickPos
//
//  Created by Leona on 15/4/12.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "MyChangePasswordViewController.h"
#import "LoginViewController.h"
#import "QuickPosNavigationController.h"
#import "QuickPosTabBarController.h"

@interface MyChangePasswordViewController ()<ResponseData>{
    
    NSTimer *timer;//倒计时
    int Second;//秒数
    Request *requst;
    
}

@property (weak, nonatomic) IBOutlet UIView *oldPasswordView;//旧密码的容器View

@property (weak, nonatomic) IBOutlet UIView *nowPasswordView;//新密码的容器View

@property (weak, nonatomic) IBOutlet UIView *codeView;//验证码容器View

@property (weak, nonatomic) IBOutlet UITextField *oldTextField;//旧密码输入框

@property (weak, nonatomic) IBOutlet UITextField *nowTextField;//新密码输入框

@property (weak, nonatomic) IBOutlet UITextField *codeTextField;//验证码输入框

@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;//获取验证码按钮

@property (weak, nonatomic) IBOutlet UIButton *OKbutton;//完成按钮

@end

@implementation MyChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = L(@"ChangePassword");
    self.OKbutton.layer.cornerRadius = 5;
    requst = [[Request alloc]initWithDelegate:self];
    
    self.oldPasswordView.layer.masksToBounds = YES;
    self.oldPasswordView.layer.cornerRadius = 1;
    
    self.nowPasswordView.layer.masksToBounds = YES;
    self.nowPasswordView.layer.cornerRadius = 1;
    
    self.codeView.layer.masksToBounds = YES;
    self.codeView.layer.cornerRadius = 1;
    

    //自定义键盘
//    NumberKeyBoard *numberkeyboardOfoldTextField = [[NumberKeyBoard alloc]init];
//    [numberkeyboardOfoldTextField setTextView:self.oldTextField];
//    
//    NumberKeyBoard *numberkeyboardOfnowTextField = [[NumberKeyBoard alloc]init];
//    [numberkeyboardOfnowTextField setTextView:self.nowTextField];
    
    NumberKeyBoard *numberkeyboardOfcodeTextField = [[NumberKeyBoard alloc]init];
    [numberkeyboardOfcodeTextField setTextView:self.codeTextField];
    
}

- (IBAction)OK:(UIButton *)sender {
    
    if([_oldTextField.text isEqual:@""]){
    
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"InputOldPassward")];
    
    
    }else if([_nowTextField.text isEqual:@""]){
        
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"InputNewPassward")];
        
        
    }else if([_codeTextField.text isEqual:@""]){
        
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"InputCode")];
        
        
    }else{
        
        [requst changePasswordWithMobileNo:[AppDelegate getUserBaseData].mobileNo newPassword:self.nowTextField.text olePassword:self.oldTextField.text mobileMac:self.codeTextField.text];
    
    }
    
}


- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    
    if([dict[@"respCode"] isEqual:@"0000"]){
        
       if(type == REQUEST_CHANGEPASSWORD){
           
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"ChangeComplete")];
           
        [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(goback) userInfo:nil repeats:NO];

    }else if(type == REQUEST_GETMOBILEMAC){
        
         [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"VerificationCodeSentSuccessfully")];

    }
    }else{
    
        [MBProgressHUD showHUDAddedTo:self.view WithString:dict[@"respDesc"]];
    }

    
    
    

}
//sb用
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"loginSegue"]) {
        
        LoginViewController *vc = segue.destinationViewController;
   
        QuickPosNavigationController *navCon = [[QuickPosNavigationController alloc] initWithRootViewController:vc];
  
        if (self.presentedViewController == nil)
        {
           [self presentViewController:navCon animated:YES completion:nil];
            
        }
        
    }

}



- (void)goback{
    
    [[QuickPosTabBarController getQuickPosTabBarController]gotoLoginViewCtrl];
}



- (IBAction)getcode:(UIButton *)sender {
    Second = 60;
    [timer invalidate];
    timer = nil;
    
    
    
    if([self.oldTextField.text length] > 0){
        [requst getMobileMacWithAccount:[AppDelegate getUserBaseData].mobileNo appType:@"UserUpdatePwd"];
        
        
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(repeats) userInfo:nil repeats:YES];
        
    }else{
        
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"InputOldPassward")];
    }
    
    
    
    
    
    
}
- (void)repeats{
    
    if (Second >0){
        
        --Second;
        
        self.getCodeButton.enabled = NO;
        [self.getCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        
        
        [self.getCodeButton setTitle:[NSString stringWithFormat:L(@"ToResendToSecond"),Second] forState:UIControlStateNormal];
    }else{
        
        self.getCodeButton.enabled = YES;
        
        [self.getCodeButton setTitle:[NSString stringWithFormat:L(@"ToResend")] forState:UIControlStateNormal];
        [self.getCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        
    }
    
}






@end
