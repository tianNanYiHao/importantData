//
//  MangePayViewController.m
//  QuickPos
//
//  Created by Aotu on 16/1/8.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "MangePayViewController.h"
#import "RechargeViewController.h"
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
@interface MangePayViewController ()<UITableViewDataSource,UITableViewDelegate,ResponseData,ChooseViewDelegate>
{
    long long  Sumprice;
    Request *request;
    NSMutableArray *commodityIDArr;
    NSString *orderDesc;
    NSString *payTool;
    OrderData *orderData;
    NSUInteger payType;
    NSString *commodityIDs; //商品id
    NSString *merchantId;   //商户商家id
    NSString *productId;  //
}

@property (weak, nonatomic) IBOutlet UITextField *finalPrice;  //充值金额/支付金额
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;

@property (weak, nonatomic) IBOutlet UITableView *sTableView;

@property (weak, nonatomic) IBOutlet UIView *phoneView;

@property (weak, nonatomic) IBOutlet UITextField *phone;  //充值账户 TextField

@property (weak, nonatomic) IBOutlet UIView *bottomView;



@property (weak, nonatomic) IBOutlet UILabel *moneyLab; // 充值金额/支付金额
@property (weak, nonatomic) IBOutlet UILabel *phoneNo; //充值账户

@property (weak, nonatomic) IBOutlet UIView *radioBottomView;

@property (weak, nonatomic) IBOutlet RadioButton *button4;
@property (weak, nonatomic) IBOutlet RadioButton *button5;
@property (weak, nonatomic) IBOutlet RadioButton *button6;

@property (nonatomic, strong) NSString *isAccount;//是否是账户充值的标准
@property (nonatomic,assign) BOOL isQuick; //再增加一个判断  是否是快捷支付的标准
@end

@implementation MangePayViewController


//勾选支付方式
- (IBAction)typeAction:(RadioButton *)sender {
    
    if (sender.tag == 44) {
        //理财刷卡支付
        self.radioBottomView.hidden = YES;
       
            merchantId = @"0004000008";
            productId = @"0000000000";
            payTool = @"01";
            self.phoneView.hidden = YES;
            self.isAccount = @"0";
            payType = CardPayType;  //刷卡充值/支付 0
        NSLog(@"刷卡支付");
    }else{
        //理财快捷支付
        self.radioBottomView.hidden = YES;
            merchantId = @"0004000007";
            productId = @"0000000000";
            payTool = @"03";
            self.phoneView.hidden = YES;
            self.isAccount = @"0";
            payType = QuickPayType; //快捷充值/支付 0
        NSLog(@"快捷支付");
        
        }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"理财订单";

    self.comfirt.layer.cornerRadius = 5;
    [self.comfirt setTitle:@"确认购买" forState:UIControlStateNormal];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController setNavigationBarHidden:NO];

    payTool = @"01";
    payType = CardPayType;  //支付方式 刷卡支付
    request = [[Request alloc]initWithDelegate:self];

    int count = 2;  //
    _button4.groupButtons = @[_button4,_button5];
    _button4.selected = YES;

    //vip版本直接隐藏
    self.radioBottomView.hidden = YES;
    
    self.phoneView.hidden = YES;
    self.isAccount = @"0";
    _finalPrice.text = [NSString stringWithFormat:@"%@元",_amt];
    _finalPrice.userInteractionEnabled = NO;

    
}
//每次页面出现
-(void)viewWillAppear:(BOOL)animated
{
    //    int count = ISQUICKPAY?3:2;
    //    float x = (self.bottomView.frame.size.width - [ChooseView chooseWidth]*count)/2.0;
    //    float y = self.finalPrice.frame.origin.y + self.finalPrice.frame.size.height + 12;
    //    [self.bottomView addSubview:[ChooseView creatChooseViewWithOriginX:x Y:y delegate:self count:count]];
    //    merchantId = @"0002000002";
    //    productId = @"0000000000";
    
    //添加滑动
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    self.navigationController.navigationBarHidden = NO;

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    
    // 开启
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  - 点击确认充值/支付 按钮
//发送订单信息。得到回调信息才push
- (IBAction)pushToOrder:(id)sender {

    [request getManageProductOrderWithProductID:_productID Number:_number amt:_amt tranType:payTool];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"订单生成中...."];
    NSLog(@"%@======%d",payTool,payType);
    

}
//得到返回  进入orderviewController(订单信息) 传递商品信息 支付方式
-(void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type
{

    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    if (type == REQUSET_getManageProductOrder) {
        
        OrderViewController *shopVc = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderViewController"];
        orderData = [OrderData new];
        orderData.orderAmt = [NSString stringWithFormat:@"%f",[[dict objectForKey:@"amount"] floatValue]*100];
        orderData.orderId = [dict objectForKey:@"orderid"];
        
        orderData.orderAccount = [AppDelegate getUserBaseData].mobileNo;
        orderData.orderPayType = payType;
        orderData.merchantId = merchantId;
        orderData.productId = productId;
        shopVc.orderData = orderData;
        
        [self.navigationController pushViewController:shopVc animated:YES];

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
    
}

#pragma mark - 正则判断
- (BOOL)matchStringFormat:(NSString *)matchedStr withRegex:(NSString *)regex
{
    //SELF MATCHES一定是大写
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:matchedStr];
}



@end
