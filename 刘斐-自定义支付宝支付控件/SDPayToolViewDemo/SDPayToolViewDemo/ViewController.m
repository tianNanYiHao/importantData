//
//  ViewController.m
//  SDPayToolViewDemo
//
//  Created by tianNanYiHao on 2017/9/7.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"
#import "ForgetPwdViewController.h"

#import "SDPayView.h"

@interface ViewController ()<SDPayViewDelegate>
{
    
}
@property (nonatomic, strong) SDPayView *payView;
@property (nonatomic, strong) NSMutableArray *payModeArray;
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //1.常规模式
    self.payView = [SDPayView getPayView];
    self.payView.addCardType = SDPayView_ADDBANKCARD;
    self.payView.delegate = self;
//    [self.view addSubview:self.payView];
    [[UIApplication sharedApplication].keyWindow addSubview:self.payView];
    
    
    //2.仅支付密码键盘模式
//    payView = [SDPayView getPayView];
//    payView.delegate = self;
//    payView.style = SDPayViewOnlyPwd;
//    [self.view addSubview:payView];
    
}
- (IBAction)pay:(id)sender {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"format2" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];

    [self.payView setPayTools:arr];
    [self.payView setPayInfo: @{
                                @"desTitle":@"订单信息如下",
                                @"money":@"¥90",
                                @"orderTitle":@"订单信息",
                                @"orderDes":@"充值",
                                @"payTitle":@"支付方式",
                                @"payBtnTitle":@"确认支付"
                                }];
    [self.payView showPayTool];
}




#pragma - mark SDPayViewDelegate

- (void)payViewReturnDefulePayToolDic:(NSMutableDictionary *)defulePayToolDic{
    NSLog(@"返回的默认支付工具 打印: %@",defulePayToolDic);
}

- (void)payViewSelectPayToolDic:(NSMutableDictionary *)selectPayToolDict{
    
    NSLog(@"所选择的支付工具 打印: %@",selectPayToolDict);
    //*****根据所选择的支付工具,刷新页面/替换支付工具值等操作*********
}

- (void)payViewPwd:(NSString *)pwdStr paySuccessView:(SDPaySuccessAnimationView *)successView{

    NSLog(@"您输入的支付密码为:%@",pwdStr);
    //过五秒
    //1.支付动画开始
    [successView animationStart];

    if (YES) {
        //支付成功
        [successView animationSuccess];
    }
    else{
        //支付失败
        //支付控件复位 - 不删除
        [self.payView payPwdResetToPayOrderView];
        
        //支付控件复位 - 后删除
//        [payView resetPayToolHidden];
    }

}

- (void)payViewForgetPwd:(NSString *)type{
    
    //1.
    //点击忘记密码 - 隐藏支付控件
    [self.payView hidPayToolInPayPwdView];
//
//    ForgetPwdViewController *f = [[ForgetPwdViewController alloc] init];
//
//    f.titles = [NSString stringWithFormat:@"%@忘记密码?",type];
//
//    [self.navigationController pushViewController:f animated:YES];
//
//    NSLog(@"点击了忘记密码 密码类型: %@",type);
    
    
}



- (void)payViewAddPayToolCard:(NSString *)type{
    
    ForgetPwdViewController *f = [[ForgetPwdViewController alloc] init];
    
    f.titles = [NSString stringWithFormat:@"%@添加新卡",type];
    
    [self.navigationController pushViewController:f animated:YES];
    
    NSLog(@"你要添加的新卡类型为:%@",type);
    
}

/**
 按钮关闭事件回调
 */
- (void)payViewClickCloseBtn{
    
}

@end
