//
//  WeChatBankListViewController.m
//  QuickPos
//
//  Created by 胡丹 on 15/4/8.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "WeChatBankListViewController.h"
#import "Request.h"
#import "OrderData.h"
#import "QuickPayOrderViewController.h"
#import "QuickBankData.h"
#import "BankCardBindViewController.h"
#import "Common.h"
#import "AddWeChatBankcardViewController.h"
#import "CheckCardInfoViewController.h"
#import "QuickPayOrderViewController.h"
#import "MBProgressHUD+Add.h"
#import "MBProgressHUD.h"
#import "ObtainScanViewController.h"
#import "MyCardCell.h"
#import "BankCardData.h"
#import "TSTWechatViewController.h"

@interface WeChatBankListViewController ()<UITableViewDataSource,UITableViewDelegate,ResponseData>{
    QuickBankData *bankData;
    QuickBankItem *bankItem;
    NSIndexPath *indexpath;
    OrderData *orderData;
    Request *request;
    BankCardData *bankCardData;//类为属性
}
@property (weak, nonatomic) IBOutlet UITableView *bankTableView;
@property (nonatomic,strong) UIImageView *noBankCark;//没有银行卡的图片
@property (nonatomic,strong) UILabel *noBankCarktip;//没有银行卡的提示
@property (nonatomic,strong) UIImageView *WechatNoBankCark;//注册微信背景图片提示
@property (nonatomic,strong) UILabel *WechatNoBankCarktip;//注册微信文字提示

@property (nonatomic,strong) NSString *newbindid;
@property (nonatomic,strong) NSString *customerId;
@property (nonatomic,strong) NSString *bindID;
@property (nonatomic,strong) NSString *bankId;
@property (nonatomic,strong) NSString *cardNo;
@property (nonatomic,strong) NSString *cardType;
@property (nonatomic,strong) NSString *customerName;
@property (nonatomic,strong) NSString *bankName;
@property (nonatomic,strong) UIButton *WecahtBtn;
@property (nonatomic,strong) NSString *respCode;
@property (nonatomic,strong) NSString *states;
@property (nonatomic,strong) NSString *accountNo;




//@property (weak, nonatomic) IBOutlet UIButton *weChatBtn;



@end

@implementation WeChatBankListViewController
@synthesize name;
@synthesize destinationType;
@synthesize item;
//@synthesize newbindid;


#pragma mark ViewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"微信收款";
    
    
    [self creatBankCardPrompt];
    
    request = [[Request alloc]initWithDelegate:self];

    [request queryBindWeixinOrderStatephone:[AppDelegate getUserBaseData].mobileNo];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"加载数据中"];

    _bankTableView.delegate = self;
    _bankTableView.dataSource = self;
    
//    [request setAuthenticationScheme:@"http"];//设置验证方式
//    
//    [request setValidatesSecureCertificate:NO];//设置验证证书

    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [Common hexStringToColor:@"eeeeee"];
    self.bankTableView.backgroundColor = [Common hexStringToColor:@"eeeeee"];
    self.bankTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    
    //导航栏右边按钮
    UIButton *addbank = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [addbank setImage:[UIImage imageNamed:@"serve_more"] forState:UIControlStateNormal];
    

    
    [addbank addTarget:self action:@selector(addBankCard:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:addbank];
    
   
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
   
    

}

- (void)creatWeahatBtn{
    _WecahtBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 300, 300, 40)];
    _WecahtBtn.backgroundColor = [Common hexStringToColor:@"#4fb756"];
    _WecahtBtn.layer.cornerRadius = 5;
    [_WecahtBtn setTitle:@"注册微信" forState:UIControlStateNormal];
    [_WecahtBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_WecahtBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_WecahtBtn];
}

- (void)click:(UIButton *)btn
{
    NSLog(@"点击查询");
    [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"正在注册微信商户"];
    
    [request registerWeixinPayphone:[AppDelegate getUserBaseData].mobileNo];
    
    
}

#pragma mark 背景图片
- (void)creatBankCardPrompt{

    self.noBankCark = [[UIImageView alloc]initWithFrame:CGRectZero];
    self.noBankCark.frame = CGRectMake(CGRectGetWidth(self.view.frame)/2 - 45, 150, 85, 55);
    self.noBankCark.image = [UIImage imageNamed:@"bankcard_card"];
    
    self.noBankCarktip = [[UILabel alloc]initWithFrame:CGRectZero];
    self.noBankCarktip.frame = CGRectMake(0, 205, CGRectGetWidth(self.view.frame), 55);
    _noBankCarktip.text = @"请点击右上角添加银行卡";
    _noBankCarktip.textColor = [UIColor redColor];
    self.noBankCarktip.font = [UIFont systemFontOfSize:13];
    self.noBankCarktip.textAlignment = NSTextAlignmentCenter;
    
    
    [self.view addSubview:self.noBankCark];
    [self.view addSubview:self.noBankCarktip];

    
}

- (void)creatWechatPrompt{

    self.WechatNoBankCark = [[UIImageView alloc]initWithFrame:CGRectZero];
    self.WechatNoBankCark.frame = CGRectMake(CGRectGetWidth(self.view.frame)/2 - 45, 150, 85, 55);
    self.WechatNoBankCark.image = [UIImage imageNamed:@"bankcard_card"];

    self.WechatNoBankCarktip = [[UILabel alloc]initWithFrame:CGRectZero];
    self.WechatNoBankCarktip.frame = CGRectMake(0, 205, CGRectGetWidth(self.view.frame), 55);
    self.WechatNoBankCarktip.text = @"你还没有注册微信,请点击注册按钮进行注册";
    self.WechatNoBankCarktip.font = [UIFont systemFontOfSize:13];
    self.WechatNoBankCarktip.textColor = [UIColor lightGrayColor];
    self.WechatNoBankCarktip.textAlignment = NSTextAlignmentCenter;
    
    
    [self.view addSubview:self.WechatNoBankCark];
    [self.view addSubview:self.WechatNoBankCarktip];

}

#pragma mark 添加银行卡
- (void)addBankCard:(UIButton *)sender {
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    AddWeChatBankcardViewController *addWeChatBankCardVc = [mainStoryboard instantiateViewControllerWithIdentifier:@"AddWeChatBankcardVC"];
    
    
//    [addWeChatBankCardVc setOrderData:self.orderData];
    [self.navigationController pushViewController:addWeChatBankCardVc animated:YES];
    

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    
    //有数据返回
    
    
    
    if([[dict objectForKey:@"respCode"]isEqualToString:@"0000"]){
        
        if(type == REQUSET_BANKLIST){
            
            if ([[[dict objectForKey:@"data"] objectForKey:@"resultBean"] count] >0) {
                self.noBankCark.hidden = YES;
                self.noBankCarktip.hidden = YES;
            }else{
                if ([self.state integerValue] == 0) {
                    _WecahtBtn.hidden = NO;
                    self.noBankCark.hidden = YES;
                    self.noBankCarktip.hidden = YES;
                    self.WechatNoBankCarktip.hidden = NO;
                    self.WechatNoBankCark.hidden = NO;

                    
                }else {
                    _WecahtBtn.hidden = YES;
                    self.WechatNoBankCarktip.hidden = YES;
                    self.WechatNoBankCark.hidden = YES;
                    self.noBankCarktip.hidden = NO;
                    self.noBankCark.hidden = NO;
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                }

            }
            NSArray *resultBeanArr = [[dict objectForKey:@"data"]objectForKey:@"resultBean"];
            
            if (resultBeanArr.count == 0) {
                bankData = [[QuickBankData alloc]initWithData:dict];
                
            }
            else{
                bankData = [[QuickBankData alloc]initWithData:dict];
                
                for (NSDictionary *items in resultBeanArr) {
                    self.accountNo = [items objectForKey:@"accountNo"];
                    NSLog(@"%@",self.accountNo);
                }
                
                
                NSLog(@"%@",bankData);
                
                
                
                NSLog(@"%@  %@  %@  %@",self.newbindid,self.customerId,self.bankId,self.bindID);
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self.bankTableView reloadData];
            }
            
        }else if(type == REQUEST_UNBINDQUICKBANKCARD){//解绑无卡支付银行卡
            [bankData.bankCardArr removeObjectAtIndex:indexpath.row];
            [self.bankTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexpath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.bankTableView reloadData];
            
        }
        else if (type == REQUSET_QUERYBINDWEIXINORDERSTATE) {//查询注册微信状态
            self.state = [[dict objectForKey:@"data"]objectForKey:@"state"];
            NSLog(@"%@",self.state);
            
            [self creatWeahatBtn];
            
            if ([self.state integerValue] == 0) {
                [self creatWechatPrompt];
                _WecahtBtn.hidden = NO;
                self.noBankCark.hidden = YES;
                self.noBankCarktip.hidden = YES;
                self.WechatNoBankCarktip.hidden = NO;
                self.WechatNoBankCark.hidden = NO;
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }else {
                _WecahtBtn.hidden = YES;
                self.WechatNoBankCarktip.hidden = YES;
                self.WechatNoBankCark.hidden = YES;
                self.noBankCarktip.hidden = NO;
                self.noBankCark.hidden = NO;
            }
            [request bankListAndbindType:@"05"];
         
        }
        else if (type == REQUSET_REGISTERWEIXINPAY){//注册微信商户
            
            self.respCode = [dict objectForKey:@"respCode"];
            if ([self.respCode integerValue] == 0000) {
               
                
                [Common showMsgBox:nil msg:@"注册成功" parentCtrl:self];
                
                _WecahtBtn.hidden = YES;
                self.WechatNoBankCarktip.hidden = YES;
                self.WechatNoBankCark.hidden = YES;
                self.noBankCarktip.hidden = NO;
                self.noBankCark.hidden = NO;
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }else{
                [Common showMsgBox:nil msg:@"注册失败" parentCtrl:self];
            }
        }
    }else{
        
        [Common showMsgBox:nil msg:[dict objectForKey:@"respDesc"] parentCtrl:self];
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

#pragma mark - TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return bankData.bankCardArr.count>0? bankData.bankCardArr.count:0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    indexpath = indexPath;
    bankItem = [bankData.bankCardArr objectAtIndex:indexPath.row];
    
    static NSString *cellIdentifier = @"MyCardCell";
    MyCardCell *headerCell =(MyCardCell *) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];


    [headerCell.bankLogoImageView sd_setImageWithURL:[NSURL URLWithString:bankItem.iconUrl]];
    
    headerCell.bankLogoImageView.layer.masksToBounds = YES;
    headerCell.bankLogoImageView.layer.cornerRadius = 10.0;

    headerCell.bankNameLabel.text = bankItem.bankName;
    headerCell.cardNumberLabel.text =[Common bankCardNumSecret:bankItem.accountNo];
    
    
    return headerCell;
}

#pragma mark - TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    bankItem = bankData.bankCardArr[indexPath.row];
    bankItem.isBind = YES;
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ObtainScanViewController *ObtainScanVc = [mainStoryboard instantiateViewControllerWithIdentifier:@"ObtainScanVc"];
    
//    [ObtainScanVc setOrderData:self.orderData];
//    ObtainScanVc.newbindid = self.newbindid;
//    ObtainScanVc.bankName = bankItem.bankName;

    ObtainScanVc.acctNo2 = self.accountNo;
    [self.navigationController pushViewController:ObtainScanVc animated:YES];
    
//    TSTWechatViewController *ystWechat = [[TSTWechatViewController alloc] initWithNibName:@"TSTWechatViewController" bundle:nil];
//    ystWechat.WeChatBankCardNum = _accountNo;
//    [self.navigationController pushViewController:ystWechat animated:YES];
    

    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (editingStyle == UITableViewCellEditingStyleDelete)
//    {
//        indexpath = indexPath;
//        bankItem = [bankData.bankCardArr objectAtIndex:indexPath.row];
////        [self.arrayValue removeObjectAtIndex:[indexPath row]];  //删除数组里的数据
////        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];  //删除对应数据的cell
//        Request *req = [[Request alloc]initWithDelegate:self];
////        [req quickPayBankCardUnbind:bankItem.bindID newbindid:self.newbindid];
//        [req quickPayBankCardUnbind:self.bindID
//                          newBindId:self.newbindid
//                            orderId:self.orderData.orderId
//         ];
//    }
//}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  UITableViewCellEditingStyleDelete;
}


//- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
//    if ([identifier isEqualToString:@"NoCardPaySegue"]) {
//        return NO;
//    }
//    
//    return YES;
//}



#pragma mark - Navigation

//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//    if ([segue.identifier isEqualToString:@"NoCardPaySegue"]) {
//        if([segue.destinationViewController isKindOfClass:[QuickPayOrderViewController class]]){
//            [(QuickPayOrderViewController*)segue.destinationViewController setOrderData:self.orderData];
//            [(QuickPayOrderViewController*)segue.destinationViewController setBankCardItem:bankItem];
//        }
//    }else if([segue.identifier isEqualToString:@"AddQuickCardSegue"]){
//        if([segue.destinationViewController isKindOfClass:[BankCardBindViewController class]]){
//            [(BankCardBindViewController*)segue.destinationViewController setOrderData:self.orderData];
//        }
//
//    }
//}

 
@end
