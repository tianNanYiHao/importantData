//
//  LoginViewController.m
//  QuickPos
//
//  Created by 张倡榕 on 15/3/6.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "LoginViewController.h"
#import "ConvenientServiceViewController.h"
#import "QuickPosTabBarController.h"
#import "UserBaseData.h"
#import "Common.h"
#import "QuickPosTabBarController.h"
#import "DDMenuController.h"
#import "SetupViewController.h"
#import "ABCIntroView.h"
#import "LocationManager.h"
#import "QuickPosNavigationController.h"
#import "YoolinkTestViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>


@interface LoginViewController ()<ABCIntroViewDelegate,ResponseData,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>{
    
    NSDictionary *dataDic; //请求返回的字典
    Request *requst;
    BOOL isLogin;
}
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;//账号输入框

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;//密码输入框

@property (weak, nonatomic) IBOutlet UIButton *LogintoButton;//登入按钮

@property (weak, nonatomic) IBOutlet UIButton *registeredButton;//注册按钮

@property (weak, nonatomic) IBOutlet UIButton *forgetpasswordButton;//忘记密码按钮

@property (weak, nonatomic) IBOutlet UIView *accountTextFieldBg;

@property (weak, nonatomic) IBOutlet UIView *passwordTextFieldBg;

@property (nonatomic, strong)MBProgressHUD *hub;//载入提醒

@property (nonatomic, strong)UITableView *tableViewhistory;//历史手机号码记录表格
@property (nonatomic, strong)NSMutableArray *dataA;
@property (nonatomic, assign)BOOL select;
@property (nonatomic, assign)NSString *number;
@property ABCIntroView *introView;
@property (weak, nonatomic) IBOutlet UIImageView *switchImage;
@property (nonatomic,assign) BOOL canEnable;
@property (weak, nonatomic) IBOutlet UIButton *touchidBtn;



@end

@implementation LoginViewController
- (IBAction)show:(UIButton *)sender {
    
    //    if ([self.dataA count] == 0) return;
    //    self.tableViewhistory.hidden = !self.tableViewhistory.hidden;
    //    if (self.tableViewhistory.hidden == NO) {
    //        [self.tableViewhistory reloadData];
    //    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(isLogin:) name:@"IsLoginNotification" object:nil];
    
    //    [self addintro];
    
    [self goBackBtn];
    
    self.title = L(@"UserLogin");
    [self reach];
    self.view.backgroundColor = [Common hexStringToColor:@"eeeeee"];
    dataDic = [NSDictionary dictionary];
    
    self.LogintoButton.layer.masksToBounds = YES;
    self.LogintoButton.layer.cornerRadius = 5;
    self.touchidBtn.layer.cornerRadius = 5;
    
    self.accountTextFieldBg.layer.masksToBounds = YES;
    self.accountTextFieldBg.layer.cornerRadius = 1;
    self.accountTextField.delegate = self;
    self.passwordTextFieldBg.layer.masksToBounds = YES;
    self.passwordTextFieldBg.layer.cornerRadius = 1;
    
    self.accountTextField.delegate = self;
    
    self.accountTextField.text = [[NSUserDefaults standardUserDefaults]objectForKey:UserPhone];
    //    self.registeredButton.frame = CGRectMake(10, CGRectGetMaxY(self.LogintoButton.frame), 88, 30);
    //自定义键盘
    //    NumberKeyBoard *numberkeyboard = [[NumberKeyBoard alloc]init];
    //    [numberkeyboard setTextView:self.accountTextField];
    //    SafeStringKeyBoard *strkeyboard = [[SafeStringKeyBoard alloc]init];
    //    [strkeyboard setTextView:self.passwordTextField];
    
    //    [self.accountTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.dataA = [NSMutableArray array];
    self.tableViewhistory = [[UITableView alloc]initWithFrame:CGRectMake(40,253,250,200) style:UITableViewStyleGrouped];
    self.tableViewhistory.dataSource = self;
    self.tableViewhistory.delegate = self;
    self.tableViewhistory.hidden = YES;
    self.tableViewhistory.backgroundColor = [UIColor whiteColor];
    //    [self.view addSubview:self.tableViewhistory];
    
    self.number = @"1";
    self.switchImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOn:)];
    [self.switchImage addGestureRecognizer:tap];
    
    //通知控制键盘以及明暗文转换
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardwillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardwillHiden:) name:UIKeyboardWillHideNotification object:nil];
    
}


//返回按钮
- (void)goBackBtn
{
    UIButton *gotoButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 50, 20)];
    
    [gotoButton setTintColor:[UIColor whiteColor]];
    [gotoButton setTitle:@"返回" forState:UIControlStateNormal];
    [gotoButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:16.0]];
    gotoButton.backgroundColor = [UIColor clearColor];
    [gotoButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [gotoButton addTarget:self action:@selector(onFinishedIntroButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:gotoButton];
}

//由登录界面返回到便民服务主页面
- (void)onFinishedIntroButtonPressed:(id)sender {
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ConvenientServiceViewController *convenientVc = [storyBoard instantiateViewControllerWithIdentifier:@"ConvenientServiceSB"];
    convenientVc.navigationItem.hidesBackButton = YES;
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}





-(void)keyboardwillShow:(NSNotification*)noti{
    
    _canEnable = NO;
    
}
-(void)keyboardwillHiden:(NSNotification*)noti
{
    _canEnable = YES;
    
}

- (void)tapOn:(UITapGestureRecognizer *)tap{
    
    if (_canEnable) {
        if ([self.number isEqualToString:@"1"]) {
            self.switchImage.image = [UIImage imageNamed:@"login_abc_press"];
            self.passwordTextField.secureTextEntry = NO;
            self.number = @"2";
        }else{
            self.switchImage.image = [UIImage imageNamed:@"login_abc_nomal"];
            self.passwordTextField.secureTextEntry = YES;
            self.number = @"1";
        }
    }
}
#pragma UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataA count];;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //由于此方法调用十分频繁，cell的标示声明成静态变量有利于性能优化
    static NSString *cellIdentifier=@"UITableViewCellIdentifierKey1";
    //首先根据标识去缓存池取
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //如果缓存池没有到则重新创建并放到缓存池中
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[self.dataA objectAtIndex:indexPath.row]];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.tableViewhistory.hidden = YES;
    self.accountTextField.text = [NSString stringWithFormat:@"%@",[self.dataA objectAtIndex:indexPath.row]];
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.passwordTextField.text = @"";
    
    //注册成功后清空账号和密码
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cleanText:) name:@"cleanText" object:nil];
}

- (void)cleanText:(NSNotification *)text{
    
    //清空输入框的字符
    self.accountTextField.text = @"";
    self.passwordTextField.text = @"";
    
}

- (void)isLogin:(NSNotification*)n{
    isLogin = [(NSNumber*)n.object boolValue];
}


- (void)addintro{
    
    /////用来判断第一次启动而是否加载引导页
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"intro_screen_viewed"]) {
        
        self.navigationController.navigationBarHidden = YES;
        //引导页的的方法
        self.introView = [[ABCIntroView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        self.introView.delegate = self;
        self.introView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:self.introView];
    }
    
}


- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    
    NSString * MOBILE = @"^1\\d{10}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    if ([regextestmobile evaluateWithObject:mobileNum] == YES){
        
        return YES;
        
    }else{
        
        return NO;
    }
}

//指纹登录
- (IBAction)touchidLogin:(id)sender {
    
    if([[[UIDevice currentDevice] systemVersion]floatValue]<8){
        [Common showMsgBox:@"" msg:@"你的设备不支持改功能" parentCtrl:self];
        return;
    }
    
    LAContext *context = [[LAContext alloc]init];
    NSError *error;
    if (![context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        NSLog(@"当前的设备不支持指纹识别:%@",error.localizedDescription);
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"你手机还没有设置指纹,去设置手势密码吧" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        return;
    }
    [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"请按指纹" reply:^(BOOL success, NSError *authenticationError) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (success) {
                
                NSLog(@"指纹正确");
                
                NSString *pwd = [[NSUserDefaults standardUserDefaults] objectForKey:@"pwd"];
                self.passwordTextField.text = pwd;
                
                if ([pwd length] == 0) {
                    [Common showMsgBox:@"" msg:@"指纹登录失败,请用密码登录" parentCtrl:self];
                }else{
                    requst = [[Request alloc]initWithDelegate:self];
                    [requst userLoginWithAccount:self.accountTextField.text password:pwd];
                    
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    [defaults setObject:self.accountTextField.text forKey:@"phoneNumber"];//存手机号（账号）
                    [defaults synchronize];
                    
                    self.hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:L(@"loging")];
                }
                
            }else{
                NSLog(@"搞不个error == :%@",authenticationError);
                if (authenticationError.code==-3) {
                    NSLog(@"输入登陆密码");
                }
                if (authenticationError.code==-2) {
                    NSLog(@"取消指纹验证");
                }
                if (authenticationError.code==-8) {
                    NSLog(@"设备被锁了");
                }
                if (authenticationError.code==-1) {
                    NSLog(@"多次验证指纹失败");
                }
            }
            
        }) ;
    }];
}

- (IBAction)login:(UIButton *)sender {
    
    if (isLogin) {
        //        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"UpdateNewVersion")];
        [Common showMsgBox:@"" msg:L(@"UpdateNewVersion") parentCtrl:self];
        
    }else{
        [self.passwordTextField resignFirstResponder];
        
        requst = [[Request alloc]initWithDelegate:self];
        
        if ([self.accountTextField.text isEqualToString:@"1"] && [self.passwordTextField.text isEqualToString:@"yoolinktest"]) {
            YoolinkTestViewController *vc = [[YoolinkTestViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if(self.accountTextField.text.length == 0){
            
            //            [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"InputNumber")];
            [Common showMsgBox:@"" msg:L(@"InputNumber") parentCtrl:self];
            
        }else if(self.accountTextField.text.length > 11){
            
            //            [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"InputCorrectNumber")];
            [Common showMsgBox:@"" msg:L(@"InputCorrectNumber") parentCtrl:self];
            
        }else if(self.accountTextField.text.length < 11){
            
            //            [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"InputCorrectNumber")];
            [Common showMsgBox:@"" msg:L(@"InputCorrectNumber") parentCtrl:self];
            
        }
        
        
        
        else if ([self.passwordTextField.text isEqualToString:@""]){
            
            //            [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"Inputpwd")];
            [Common showMsgBox:@"" msg:L(@"Inputpwd") parentCtrl:self];
            
        }
        else
        {
            [requst userLoginWithAccount:self.accountTextField.text password:self.passwordTextField.text];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:self.accountTextField.text forKey:@"phoneNumber"];//存手机号（账号）
            [defaults synchronize];
            
            self.hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:L(@"loging")];
            
        }
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if (isLogin) {
        if ([identifier isEqualToString:@"FindpwdSegue"] || [identifier isEqualToString:@"RegisterSegue"]) {
            [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"UpdateNewVersion")];
            return NO;
        }else{
            
        }
    }else{
        return YES;
    }
    
    return YES;
}


- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    
    dataDic = dict;
    
    [self.hub hide:YES];
    
    if ([[dict objectForKey:@"respCode"]isEqualToString:@"0000"]) {
        
        if(type == REQUEST_USERLOGIN){
            
            [[NSUserDefaults standardUserDefaults] setObject:self.passwordTextField.text forKey:@"pwd"];
            
            UserBaseData *u = [[UserBaseData alloc]initWithData:dict];
            
            [AppDelegate getUserBaseData].token = u.token;
            
            [AppDelegate getUserBaseData].userName = u.userName;
            
            [AppDelegate getUserBaseData].userType = u.userType;
            
            [AppDelegate getUserBaseData].mobileNo = u.mobileNo;
            
            [AppDelegate getUserBaseData].token = u.token;
            
            [AppDelegate getUserBaseData].pic = @"";
            
            NSLog(@"%@  %@  %@",u.token,u.mobileNo,u.userName);
            
            [[LocationManager instance] startLocationManager:^(float lon, float lat) {
                [AppDelegate getUserBaseData].lon = lon;
                [AppDelegate getUserBaseData].lat = lat;
            }];
            
            //            UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            //            QuickPosTabBarController *quick = [main instantiateViewControllerWithIdentifier:@"QuickPosTabBarController"];
            
            //            [self performSegueWithIdentifier:@"loginSegue" sender:self.LogintoButton];
            
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            QuickPosTabBarController *quick = [storyBoard instantiateViewControllerWithIdentifier:@"QuickPosTabBarController"];
            SetupViewController  *setupCtrl = [storyBoard instantiateViewControllerWithIdentifier:@"SetupViewController"];
            DDMenuController *dd = [[DDMenuController alloc]initWithRootViewController:quick];
            dd.rightViewController = setupCtrl;
            quick.parentCtrl = dd;
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            [self.dataA addObject:self.accountTextField.text];
            [self.navigationController presentViewController:dd animated:YES completion:nil];
            
            
            
        }else{
            [Common showMsgBox:@"" msg:[dict objectForKey:@"respDesc"] parentCtrl:self];
        }
        
        
    }else{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showHUDAddedTo:self.view WithString:dataDic[@"respDesc"]];
    }
    
    
}
- (UIColor *) stringTOColor:(NSString *)str
{
    if (!str || [str isEqualToString:@""]) {
        return nil;
    }
    unsigned red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 1;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&red];
    range.location = 3;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&green];
    range.location = 5;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&blue];
    UIColor *color= [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
    return color;
}


#pragma mark - ABCIntroViewDelegate Methods

- (void)onDoneButtonPressed{
    
    //    Uncomment so that the IntroView does not show after the user clicks "DONE"
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"YES"forKey:@"intro_screen_viewed"];
    [defaults synchronize];
    
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.introView.alpha = 0;
        self.navigationController.navigationBarHidden = YES;
        
    } completion:^(BOOL finished) {
        
        [self.introView removeFromSuperview];
        
    }];
}
- (void)reach
{
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // 局域网络,不花钱
     */
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        UIAlertView *altv;
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"无线网络");
                //[self.switchButton setOn:YES];
                
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"3G网络");
                
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"未连接");
                
                altv = [[UIAlertView alloc]initWithTitle:nil message:L(@"NoInternetconnection") delegate:self cancelButtonTitle:nil otherButtonTitles:L(@"OK"), nil];
                [altv show];
                break;
                
                
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知错误");
                
                altv = [[UIAlertView alloc]initWithTitle:nil message:L(@"UnknownErrorNet") delegate:self cancelButtonTitle:nil otherButtonTitles:L(@"OK"), nil];
                
                [altv show];
                
                
                break;
        };
        
        
        
    }];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.tableViewhistory.hidden = YES;
}
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.accountTextField) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
            [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"InputCorrectNumber")];
            [textField resignFirstResponder];
            
        }
    }
}

@end
