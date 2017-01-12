//
//  TransferAccountViewController.m
//  QuickPos
//
//  Created by Aotu on 15/11/25.
//  Copyright © 2015年 张倡榕. All rights reserved.
//

#import "TransferAccountViewController.h"
#import "RechargeFixedViewController.h"
#import "ShoppingCartViewController.h"
#import "ShoppingCartTableViewCell.h"
#import "OrderViewController.h"
#import "Request.h"
#import "UIImageView+WebCache.h"
#import "MallData.h"
#import "OrderData.h"
#import "PayType.h"
#import "ChooseView.h"
#import "MallViewController.h"
#import "Common.h"
#import "WebViewController.h"
#import "HelpViewController.h"
#import "RadioButton.h"


@interface TransferAccountViewController ()<UITableViewDataSource,UITableViewDelegate,ResponseData,ChooseViewDelegate>
{
    long long  Sumprice;
    Request *request;
    NSMutableArray *commodityIDArr;
    NSString *orderDesc;
    NSString *payTool;
    OrderData *orderData;
    NSUInteger payType;
    NSString *commodityIDs;
    NSString *merchantId;
    NSString *productId;
    
}
@property (weak, nonatomic) IBOutlet UITextField *finalPrice; //转账金额

@property (weak, nonatomic) IBOutlet UIButton *comfirt;

@property (weak, nonatomic) IBOutlet UITextField *phone; //转账ID

@property (nonatomic, strong) NSString *isAccount;//是否是账户充值的标准

@property (nonatomic,strong) NSString *availableAmtStr;//账户余额

@property (nonatomic,strong) NSString *authenFlag;

@end

@implementation TransferAccountViewController
@synthesize finalPrice;
@synthesize item;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"账户转账";
    
    
    self.comfirt.layer.cornerRadius = 5;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController setNavigationBarHidden:NO];
//    [self creatRightBtn];

    //使用账户支付 id
    merchantId = @"0002000002";
    productId = @"0000000004";
    payTool = @"02";
    self.isAccount = @"1";  //是账户支付
    payType = AccountPayType;
    
    commodityIDArr = [NSMutableArray array];
    orderDesc = [NSMutableString string];

    request = [[Request alloc]initWithDelegate:self];
    
    
    [self cancelFristResponder];

}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    //    if([UIDevice currentDevice].isIphone4){
    //
    //        self.sTableView.contentSize = CGSizeMake(0,1000);
    //
    //    }
}

-(void)viewWillAppear:(BOOL)animated
{
    //    int count = ISQUICKPAY?3:2;
    //    float x = (self.bottomView.frame.size.width - [ChooseView chooseWidth]*count)/2.0;
    //    float y = self.finalPrice.frame.origin.y + self.finalPrice.frame.size.height + 12;
    //    [self.bottomView addSubview:[ChooseView creatChooseViewWithOriginX:x Y:y delegate:self count:count]];
    //    merchantId = @"0002000002";
//    //    productId = @"0000000000";
//    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
//    }
//    self.navigationController.navigationBarHidden = NO;
//    NSLog(@"%@=====%@",productId,merchantId);

    [request userInfo:[AppDelegate getUserBaseData].mobileNo];
    [request getVirtualAccountBalance:@"00" token:[AppDelegate getUserBaseData].token];//查询虚拟账户余额
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 开启
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

//右侧点击按钮
- (void)creatRightBtn
{
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightBtn setImage:[UIImage imageNamed:@"serve_more"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(helpClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    //    [rightBtn release];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (IBAction)helpClick:(id)sender {
    
    HelpViewController *helpVc = [HelpViewController new];
    [self.navigationController pushViewController:helpVc animated:YES];
    
}

//图片解析。从string拼接后转成data
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//发送订单信息。得到回调信息才push
- (IBAction)pushToOrder:(id)sender {
    
    NSString *priceVer = finalPrice.text;
    priceVer = [NSString stringWithFormat:@"%.2f",[priceVer doubleValue]];
    NSString *priceVerde = finalPrice.text;
    NSLog(@"%@",priceVer);
    if ([priceVer length] > 9 || [priceVerde isEqualToString:@""] || ![self matchStringFormat:priceVer withRegex:@"^([0-9]+\\.[0-9]{2})|([0-9]+\\.[0-9]{1})|[0-9]*$"]  || [priceVer isEqualToString:@"0.00"]) {
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"转账金额不能为空或0，请重新输入")];
    }else if ([self.phone.text integerValue] == 0){
        [MBProgressHUD showHUDAddedTo:self.view WithString:@"请输入转账账户"];
    }
    else if ([priceVer integerValue] > [self.availableAmtStr integerValue]){
        [MBProgressHUD showHUDAddedTo:self.view WithString:@"账户余额不足"];
    }
    else if (![self matchStringFormat:priceVerde withRegex:@"^([0-9]+\\.[0-9]{2})|([0-9]+\\.[0-9]{1})|[0-9]*$"])
    {
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"CorrectPrice")];
    }
    else
    {
        NSString *price = [priceVer stringByReplacingOccurrencesOfString:@"." withString:@""];
        
        if ([self.isAccount isEqualToString:@"1"]) {
            //克拉充值直接从自己账号充值到18368580111
            //            if (self.phone.text.length == 0) {
            //                [Common showMsgBox:@"" msg:L(@"InputNumber") parentCtrl:self];
            //                return;
            //            }
            //
            //            if(![Common isPhoneNumber:self.phone.text]){
            //                [Common showMsgBox:@"" msg:L(@"MobilePhoneNumberIsWrong") parentCtrl:self];
            //                return;
            //            }
            
            //账户支付
            [request applyOrderMobileNo:[AppDelegate getUserBaseData].mobileNo
                              MerchanId:merchantId
                              productId:productId
                               orderAmt:price
                              orderDesc:self.phone.text
                            orderRemark:@""
                           commodityIDs:@""
                                payTool:payTool];
            
            [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:L(@"OrderHasBeenSubmitted-PleaseLater")];
        }
        
    }
}

-(void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type
{
    //    if ([[dict objectForKey:@"respCode"]isEqualToString:@"1001"]) {
    //        [MBProgressHUD hideHUDForView:self.view animated:YES];
    //    }
    //
    if([[dict objectForKey:@"respCode"]isEqualToString:@"0000"]){
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (type == REQUSET_ORDER) {
            OrderViewController *shopVc = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderViewController"];
            orderData = [[OrderData alloc]initWithData:dict];
            orderData.orderAccount = [AppDelegate getUserBaseData].mobileNo;
            orderData.orderPayType = payType;
            orderData.merchantId = merchantId;
            orderData.productId = productId;
            orderData.mallOrder = YES;
            shopVc.orderData = orderData;
            for (UIViewController *v in self.navigationController.viewControllers) {
                if ([v isKindOfClass:[MallViewController class]]) {
                    shopVc.delegate = v;
                }
            }
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.navigationController pushViewController:shopVc animated:YES];
            //            [self.navigationController presentViewController:shopVc animated:YES completion:nil];
        }else if (type == REQUEST_ACCTENQUIRY){
            double userSum = [[dict objectForKey:@"availableAmt"] doubleValue];
            self.availableAmtStr = [NSString stringWithFormat:@"%0.2f",userSum/100];
            NSLog(@"%@",self.availableAmtStr);
        }else if (type == REQUSET_USERINFOQUERY){
            
            self.authenFlag = [[[dict objectForKey:@"data"]objectForKey:@"resultBean"]objectForKey:@"authenFlag"];
            NSLog(@"%@",self.authenFlag);
            
            if ([self.authenFlag isEqualToString:@"3"]) {
                
            }else
            {
                [Common showMsgBox:nil msg:@"请实名认证后,再进行操作" parentCtrl:self];
                self.finalPrice.userInteractionEnabled = NO;
                self.phone.userInteractionEnabled = NO;
            }
        }
    }else{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showHUDAddedTo:self.view WithString:[dict objectForKey:@"respDesc"]];
    }
}


-(void)cancelFristResponder
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
}
//取消第一响应者事件
- (void)keyboardHide
{
    [finalPrice resignFirstResponder];
}

#pragma mark - 正则判断
- (BOOL)matchStringFormat:(NSString *)matchedStr withRegex:(NSString *)regex
{
    //SELF MATCHES一定是大写
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:matchedStr];
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
