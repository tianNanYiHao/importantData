//
//  InstructionsForUseViewController.m
//  QuickPos
//
//  Created by feng Jie on 16/8/2.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "InstructionsForUseViewController.h"
#import "InstructionsForUseTableViewCell.h"
#import "OperationManualViewController.h"
#import "DDMenuController.h"
#import "SetupViewController.h"
#import "QuickPosTabBarController.h"
#import "WebViewController.h"

#define INFORMATION_URL @"http://www.jiefengpay.com:7071/jfpay_display/image/help/"

@interface InstructionsForUseViewController ()<UITableViewDelegate,UITableViewDataSource>

{
        UITableView *_instructionsTableView;
}
@property (weak, nonatomic) IBOutlet UITableView *InstructionsForUseTableView;


@end

@implementation InstructionsForUseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
  
    self.title = @"APP使用说明";
    
    self.navigationController.navigationBar.barTintColor = [Common hexStringToColor:@"#068bf4"];//导航栏颜色
    self.navigationController.navigationBar.tintColor = [Common hexStringToColor:@"#ffffff"];//返回键颜色
    self.navigationController.navigationBar.contentMode = UIViewContentModeScaleAspectFit;
    //设置标题颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [Common hexStringToColor:@"#ffffff"], UITextAttributeTextColor,
                                                                     [UIFont systemFontOfSize:17], UITextAttributeFont,
                                                                     nil]];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"jiantou"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtn:)];
}

- (void)backBtn:(UIButton *)Btn
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//APP使用必备条件
- (IBAction)instructionsBtn:(id)sender {
    
//    OperationManualViewController *OperationManualVc = [[OperationManualViewController alloc]init];
//    OperationManualVc.str = @"app使用必备条件.png";
//    OperationManualVc.titleName = @"使用条件";
//    [self.navigationController pushViewController:OperationManualVc animated:YES];
    
        [self gotoviewstr:@"app使用必备条件.png" strname:@"使用条件"];
    
}



//激活码使用.png
- (IBAction)VerifiedBtn:(id)sender {
    
//    OperationManualViewController *OperationManualVc = [[OperationManualViewController alloc]init];
//    OperationManualVc.str = @"激活码使用.png";
//    OperationManualVc.titleName = @"激活码使用";
//    [self.navigationController pushViewController:OperationManualVc animated:YES];
    
        [self gotoviewstr:@"激活码使用.png" strname:@"激活码使用"];
}

//即时取
- (IBAction)CardPayment:(id)sender {
    
//    OperationManualViewController *OperationManualVc = [[OperationManualViewController alloc]init];
//    OperationManualVc.str = @"即时取.png";
//    OperationManualVc.titleName = @"即时取";
//    [self.navigationController pushViewController:OperationManualVc animated:YES];
    
        [self gotoviewstr:@"即时取.png" strname:@"即时取"];
}


//卡卡转账.png
- (IBAction)TransferInstructions:(id)sender {
    
//    OperationManualViewController *OperationManualVc = [[OperationManualViewController alloc]init];
//    OperationManualVc.str = @"卡卡转账.png";
//    OperationManualVc.titleName = @"卡卡转账";
//    [self.navigationController pushViewController:OperationManualVc animated:YES];
    
        [self gotoviewstr:@"卡卡转账.png" strname:@"卡卡转账"];
}

//快捷支付.png
- (IBAction)QuickPayment:(id)sender {
    
//    OperationManualViewController *OperationManualVc = [[OperationManualViewController alloc]init];
//    OperationManualVc.str = @"快捷支付.png";
//    OperationManualVc.titleName = @"快捷支付";
//    [self.navigationController pushViewController:OperationManualVc animated:YES];
    
        [self gotoviewstr:@"快捷支付.png" strname:@"快捷支付"];
}

//快捷支付认证码.png
- (IBAction)WithdrawalBtn:(id)sender {
    
//    OperationManualViewController *OperationManualVc = [[OperationManualViewController alloc]init];
//    OperationManualVc.str = @"快捷支付认证码.png";
//    OperationManualVc.titleName = @"快捷支付认证码";
//    [self.navigationController pushViewController:OperationManualVc animated:YES];
    
        [self gotoviewstr:@"快捷支付认证码.png" strname:@"快捷支付认证码"];
    
}

//实名认证.png
- (IBAction)AccountTransfer:(id)sender {
    
//    OperationManualViewController *OperationManualVc = [[OperationManualViewController alloc]init];
//    OperationManualVc.str = @"实名认证.png";
//    OperationManualVc.titleName = @"实名认证";
//    [self.navigationController pushViewController:OperationManualVc animated:YES];
    
        [self gotoviewstr:@"实名认证.png" strname:@"实名认证"];
    
}


//刷卡支付.png
- (IBAction)WechatBtn:(id)sender {
//    OperationManualViewController *OperationManualVc = [[OperationManualViewController alloc]init];
//    OperationManualVc.str = @"刷卡支付.png";
//    OperationManualVc.titleName = @"刷卡支付";
//    [self.navigationController pushViewController:OperationManualVc animated:YES];
    
        [self gotoviewstr:@"刷卡支付.png" strname:@"刷卡支付"];
}

//微信收款
- (IBAction)clickBtn:(id)sender {
    
//    OperationManualViewController *OperationManualVc = [[OperationManualViewController alloc]init];
//    OperationManualVc.str = @"微信收款.png";
//    OperationManualVc.titleName = @"微信收款";
//    [self.navigationController pushViewController:OperationManualVc animated:YES];
    
        [self gotoviewstr:@"微信收款.png" strname:@"微信收款"];
}


//账户充值
- (IBAction)clickBtn1:(id)sender {
    
//    OperationManualViewController *OperationManualVc = [[OperationManualViewController alloc]init];
//    OperationManualVc.str = @"账户转账.png";
//    OperationManualVc.titleName = @"账户充值";
//    [self.navigationController pushViewController:OperationManualVc animated:YES];
    
        [self gotoviewstr:@"账户充值.png" strname:@"账户充值"];
}

//支付宝收款
- (IBAction)clickBtn2:(id)sender {
    //
//    OperationManualViewController *OperationManualVc = [[OperationManualViewController alloc]init];
//    OperationManualVc.str = @"支付宝收款.png";
//    OperationManualVc.titleName = @"支付宝收款";
//    [self.navigationController pushViewController:OperationManualVc animated:YES];
    
        [self gotoviewstr:@"支付宝收款.png" strname:@"支付宝收款"];
    
}


- (void)gotoviewstr:(NSString*)str strname:(NSString*)strName{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",INFORMATION_URL,str];
    NSLog(@"%@",urlStr);
    WebViewController *web = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"WebViewController"];
    
    web.url = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    web.navigationItem.title = strName;
    [self.navigationController pushViewController:web animated:YES];
}



//tableview
//- (void)creatTableView{
//    _instructionsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 5, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
//    _instructionsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;//去掉cell分割线
//    _instructionsTableView.backgroundColor = [UIColor whiteColor];
//    _instructionsTableView.delegate = self;
//    _instructionsTableView.dataSource = self;
//    [self.view addSubview:_instructionsTableView];
//}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 8;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 1;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 40;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *cellIdentifier = @"InstructionsForUseTableViewCell";
//
//    InstructionsForUseTableViewCell *instructionsCell = (InstructionsForUseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//
//    return instructionsCell;
//
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}

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
