//
//  ViewController.m
//  MQTTSDKLearn
//
//  Created by Vie on 2017/3/3.
//  Copyright © 2017年 Vie. All rights reserved.
//

#import "ViewController.h"
#import "MQTTClientManager.h"
#import "MQTTClientManagerDelegate.h"
#import "MBProgressHUD.h"
#import "ShowMessageViewController.h"

@interface ViewController ()<MQTTClientManagerDelegate>
@property (nonatomic, strong)MQTTSession *mqttSession;
@property (nonatomic, strong)UIScrollView *scrollView;//滚动视图
@property (nonatomic, strong)UITextField *userNameField;//账号输入框
@property (nonatomic, strong)UITextField *passwordField;//密码输入框
@property (nonatomic, strong)UITextField *ipField;//ip输入框
@property (nonatomic, strong)UITextField *portField;//端口号输入框
@property (nonatomic, strong)UIButton *loginBtn;//登陆按钮
@property (nonatomic, strong)MBProgressHUD *hud;//提示弹窗
@end

@implementation ViewController
#pragma mark LazyLoading
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView=[[UIScrollView alloc] init];
        _scrollView.translatesAutoresizingMaskIntoConstraints=false;
        //设置垂直指示滚动标不可见
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}
-(UITextField *)userNameField{
    if (!_userNameField) {
        _userNameField=[[UITextField alloc] init];
        _userNameField.translatesAutoresizingMaskIntoConstraints=false;
        _userNameField.layer.borderWidth=1.0;
        _userNameField.layer.borderColor=[UIColor blackColor].CGColor;
        [_userNameField.layer setCornerRadius:5.0f];
        _userNameField.placeholder=@"请输入用户名";
        _userNameField.text=@"admin";
    }
    return _userNameField;
}
-(UITextField *)passwordField{
    if (!_passwordField) {
        _passwordField=[[UITextField alloc] init];
        _passwordField.translatesAutoresizingMaskIntoConstraints=false;
        _passwordField.layer.borderWidth=1.0;
        _passwordField.layer.borderColor=[UIColor blackColor].CGColor;
        [_passwordField.layer setCornerRadius:5.0f];
        _passwordField.placeholder=@"请输入密码";
        _passwordField.text=@"admin";
    }
    return _passwordField;
}
-(UITextField *)ipField{
    if (!_ipField) {
        _ipField=[[UITextField alloc] init];
        _ipField.translatesAutoresizingMaskIntoConstraints=false;
        _ipField.layer.borderWidth=1.0;
        _ipField.layer.borderColor=[UIColor blackColor].CGColor;
        [_ipField.layer setCornerRadius:5.0f];
        _ipField.placeholder=@"请输入IP地址";
        _ipField.text=@"10.4.145.67";
    }
    return _ipField;
}
-(UITextField *)portField{
    if (!_portField) {
        _portField=[[UITextField alloc] init];
        _portField.translatesAutoresizingMaskIntoConstraints=false;
        _portField.layer.borderWidth=1.0;
        _portField.layer.borderColor=[UIColor blackColor].CGColor;
        [_portField.layer setCornerRadius:5.0f];
        _portField.placeholder=@"请输入端口号";
        _portField.text=@"1883";
    }
    return _portField;
}
-(UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn=[[UIButton alloc] init];
        _loginBtn.translatesAutoresizingMaskIntoConstraints=false;
        [_loginBtn setTitle:@"登 录 订 阅" forState:UIControlStateNormal];
        [_loginBtn setBackgroundColor:[UIColor colorWithRed:104/255.0 green:200/255.0 blue:250/255.0 alpha:1]];
        [_loginBtn.layer setCornerRadius:8.0f];
        [_loginBtn addTarget:self action:@selector(connectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}
-(MBProgressHUD *)hud{
    if (!_hud) {
        _hud=[[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:_hud];
        //如果设置此属性则当前的view置于后台
        _hud.dimBackground = YES;
        _hud.labelText=@"登录中请稍后";
    }
    return _hud;
}
#pragma  mark viewLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.userNameField];
    [self.scrollView addSubview:self.passwordField];
    [self.scrollView addSubview:self.ipField];
    [self.scrollView addSubview:self.portField];
    [self.scrollView addSubview:self.loginBtn];
    
    [self layoutVFL];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[MQTTClientManager shareInstance] registerDelegate:self];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[MQTTClientManager shareInstance] unRegisterDelegate:self];
}
-(void)layoutVFL{
    /*最底部或最旁边一个视图要确定与_scrollView的位置关系，这样_scrollView才能确定contenSize是否滑动*/
    /*滚动视图水平约束*/
    NSArray *scrollViewHorizotal=[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_scrollView]-0-|" options:0 metrics:nil views:@{@"_scrollView":_scrollView}];
    [self.view addConstraints:scrollViewHorizotal];
    /*滚动视图垂直约束*/
    NSArray *scrollViewViertical=[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_scrollView]-0-|" options:0 metrics:nil views:@{@"_scrollView":_scrollView}];
    [self.view addConstraints:scrollViewViertical];
    
    
    
    
    /*用户名宽度约束，_userNameField宽度=_scrollView的1.0倍-60*/
    NSLayoutConstraint *fieldWidth=[NSLayoutConstraint constraintWithItem:_userNameField attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_scrollView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:-60];
    [self.scrollView addConstraint:fieldWidth];
    
    //添加_userNameField距离父控件右边的距离固定为20  宽度
    NSLayoutConstraint *rightCos=[NSLayoutConstraint constraintWithItem:_userNameField attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_scrollView attribute:NSLayoutAttributeRight multiplier:1.0f constant:-30];
    [self.scrollView addConstraint:rightCos];
    
    //_userNameField的左边等于父控件的左边乘以1加20
    NSLayoutConstraint *leftCos=[NSLayoutConstraint constraintWithItem:_userNameField attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_scrollView attribute:NSLayoutAttributeLeft multiplier:1.0f constant:30];
    [self.scrollView addConstraint:leftCos];

    /*用户名垂直方向约束*/
    NSArray *userNameFieldViertical=[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[_userNameField(45)]" options:0 metrics:nil views:@{@"_userNameField":_userNameField}];
    [self.scrollView addConstraints:userNameFieldViertical];
   
    

    /*密码输入框水平约束*/
    NSArray *passwordFieldHorizotal=[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[_passwordField(==_userNameField)]" options:0 metrics:nil views:@{@"_passwordField":_passwordField,@"_userNameField":_userNameField}];
    [self.scrollView addConstraints:passwordFieldHorizotal];
    /*密码输入框垂直约束*/
    NSArray *passwordFieldViertical=[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_userNameField]-30-[_passwordField(==_userNameField)]" options:0 metrics:nil views:@{@"_passwordField":_passwordField,@"_userNameField":_userNameField}];
    [self.scrollView addConstraints:passwordFieldViertical];
    
    
    
    /*ip输入框水平约束*/
    NSArray *ipFieldHorizotal=[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[_ipField(==_passwordField)]" options:0 metrics:nil views:@{@"_passwordField":_passwordField,@"_ipField":_ipField}];
    [self.scrollView addConstraints:ipFieldHorizotal];
    /*ip输入框垂直约束*/
    NSArray *ipFieldViertical=[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_passwordField]-30-[_ipField(==_passwordField)]" options:0 metrics:nil views:@{@"_passwordField":_passwordField,@"_ipField":_ipField}];
    [self.scrollView addConstraints:ipFieldViertical];
    
    /*端口输入框水平约束*/
    NSArray *portFieldHorizotal=[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[_portField(==_ipField)]" options:0 metrics:nil views:@{@"_ipField":_ipField,@"_portField":_portField}];
    [self.scrollView addConstraints:portFieldHorizotal];
    /*端口输入框垂直约束*/
    NSArray *portFieldViertical=[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_ipField]-30-[_portField(==_ipField)]" options:0 metrics:nil views:@{@"_ipField":_ipField,@"_portField":_portField}];
    [self.scrollView addConstraints:portFieldViertical];
    
    
    /*登录按钮水平约束*/
    NSArray *loginBtnHorizotal=[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[_loginBtn(==_portField)]" options:0 metrics:nil views:@{@"_loginBtn":_loginBtn,@"_portField":_portField}];
    [self.scrollView addConstraints:loginBtnHorizotal];
    /*登录按钮垂直约束*/
    NSArray *loginBtnViertical=[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_portField]-30-[_loginBtn(==_portField)]-230-|" options:0 metrics:nil views:@{@"_loginBtn":_loginBtn,@"_portField":_portField}];
    [self.scrollView addConstraints:loginBtnViertical];
}


//连接Socket服务
-(void)connectAction:(UIButton *)sender{
    
    NSLog(@"连接MQTT服务器登陆验证");
    [self.hud show:YES];
    [[MQTTClientManager shareInstance] loginWithIp:self.ipField.text port:[self.portField.text intValue] userName:self.userNameField.text password:self.passwordField.text topic:@"mqtt/test" isAutoConnect:false isAutoConnectCount:19] ;
   
}


//断开Socket连接
-(void)closeAction:(UIButton *)sender{
    NSLog(@"断开Socket连接");
    [[MQTTClientManager shareInstance] close];
}

#pragma mark MQTTClientManagerDelegate
-(void)didMQTTReceiveServerStatus:(MQTTStatus *)status{
    [self.hud hide:YES];
    switch (status.statusCode) {
        case MQTTSessionEventConnected:
        {
            ShowMessageViewController *view=[[ShowMessageViewController alloc] init];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        default:
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"登录失败" message:status.statusInfo delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
            break;
    }
    
}






@end
