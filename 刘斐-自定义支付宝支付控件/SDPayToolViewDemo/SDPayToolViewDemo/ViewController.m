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
    SDPayView *payView;
    NSMutableArray *payToolsArrayUsableM;  //可用支付工具
    NSMutableArray *payToolsArrayUnusableM; //不可用支付工具
}
@property (nonatomic, strong) NSMutableArray *payModeArray;
@end

@implementation ViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    payToolsArrayUsableM = [NSMutableArray arrayWithCapacity:0];
    payToolsArrayUnusableM = [NSMutableArray arrayWithCapacity:0];
    _payModeArray = [NSMutableArray arrayWithCapacity:0];
    
    

    payView = [SDPayView getPayView];
    payView.delegate = self;
    [self.view addSubview:payView];

    
    
}
- (IBAction)pay:(id)sender {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"format2" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
    
    payToolsArrayUsableM = [NSMutableArray arrayWithCapacity:0];
    payToolsArrayUnusableM = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i<arr.count; i++) {
        if ([@"0" isEqualToString:[NSString stringWithFormat:@"%@",[[arr[i] objectForKey:@"account"] objectForKey:@"useableBalance"]]] || [[arr[i] objectForKey:@"available"] boolValue]== NO) {
            //不可用支付工具集
            [payToolsArrayUnusableM addObject:arr[i]];
        }else{
            //可用支付工具集
            [payToolsArrayUsableM addObject:arr[i]];
        }
    }
    
    
    //设置支付方式列表
    [self initPayMode:arr];

    
    
    [payView setPayInfo:(NSArray*)_payModeArray moneyStr:@"¥100.00" orderTypeStr:@"提现"];
    
    [payView showPayTool];
}

- (void)initPayMode:(NSArray *)paramArray
{
    
    NSMutableDictionary *bankDic = [[NSMutableDictionary alloc] init];
//    [bankDic setValue:PAYTOOL_PAYPASS forKey:@"type"];
//    [bankDic setValue:@"添加银行卡提现" forKey:@"title"];
//    [bankDic setValue:@"list_yinlian_AddCard" forKey:@"img"];
//    [bankDic setValue:@"" forKey:@"limit"];
//    [bankDic setValue:@"2" forKey:@"state"];
//    [bankDic setValue:@"true" forKey:@"available"];
//    
    [bankDic setValue:PAYTOOL_ACCPASS forKey:@"type"];
    [bankDic setValue:@"添加杉德卡支付" forKey:@"title"];
    [bankDic setValue:@"list_sand_AddCard" forKey:@"img"];
    [bankDic setValue:@"" forKey:@"limit"];
    [bankDic setValue:@"2" forKey:@"state"];
    [bankDic setValue:@"true" forKey:@"available"];
    
    [payToolsArrayUsableM addObject:bankDic];
    
    NSInteger unavailableArrayCount = [payToolsArrayUnusableM count];
    for (int i = 0; i < unavailableArrayCount; i++) {
        [payToolsArrayUsableM addObject:payToolsArrayUnusableM[i]];
    }
    _payModeArray = payToolsArrayUsableM;
}


#pragma - mark SDPayViewDelegate

- (void)payViewPwd:(NSString *)pwdStr paySuccessView:(SDPaySuccessAnimationView *)successView{
    
    NSLog(@"您输入的支付密码为:%@",pwdStr);
    //过五秒
    
    //支付动画开始
    [successView animationStart];
    
    //支付成功
    [successView animationSuccess];
    
    //支付失败
    
}

- (void)payViewForgetPwd:(NSString *)type{
    
    ForgetPwdViewController *f = [[ForgetPwdViewController alloc] init];
    f.titles = [NSString stringWithFormat:@"%@忘记密码?",type];
    [self.navigationController pushViewController:f animated:YES];
    NSLog(@"点击了忘记密码 密码类型: %@",type);
    
}

- (void)payViewAddPayToolCard:(NSString *)type{
    ForgetPwdViewController *f = [[ForgetPwdViewController alloc] init];
    f.titles = [NSString stringWithFormat:@"%@添加新卡",type];
    [self.navigationController pushViewController:f animated:YES];
    NSLog(@"你要添加的新卡类型为:%@",type);
}


@end
