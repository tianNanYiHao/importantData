//
//  ShoppingCartViewController.m
//  QuickPos
//
//  Created by 张倡榕 on 15/3/12.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

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

@interface ShoppingCartViewController ()<UITableViewDataSource,UITableViewDelegate,ResponseData,ChooseViewDelegate>
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

@property (weak, nonatomic) IBOutlet UITextField *finalPrice;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;

@property (weak, nonatomic) IBOutlet UITableView *sTableView;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentCl;

@end

@implementation ShoppingCartViewController
@synthesize finalPrice;
@synthesize totalPrice;
@synthesize CartArr;
@synthesize mobileNo;
@synthesize sTableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:L(@"ShoppingCart")];
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController setNavigationBarHidden:NO];
    
    [self creatRightBtn];
    
    commodityIDArr = [NSMutableArray array];
    orderDesc = [NSMutableString string];
    payTool = @"01";
    payType = CardPayType;
    request = [[Request alloc]initWithDelegate:self];
    
//    UIBarButtonItem *helpItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"help"] style:UIBarButtonItemStyleBordered target:self action:@selector(helpClick:)];
//    self.navigationItem.rightBarButtonItem = helpItem;
    [self computePrice];
    [self cancelFristResponder];
    //默认
    merchantId = @"0002000002";
    productId = @"0000000000";
    int count = ISQUICKPAY?3:2;
    float x = (self.bottomView.frame.size.width - [ChooseView chooseWidth]*count)/2.0;
    float y = self.finalPrice.frame.origin.y + self.finalPrice.frame.size.height + 12;
    [self.bottomView addSubview:[ChooseView creatChooseViewWithOriginX:x Y:y delegate:self count:count]];

    
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated
{
//    int count = ISQUICKPAY?3:2;
//    float x = (self.bottomView.frame.size.width - [ChooseView chooseWidth]*count)/2.0;
//    float y = self.finalPrice.frame.origin.y + self.finalPrice.frame.size.height + 12;
//    [self.bottomView addSubview:[ChooseView creatChooseViewWithOriginX:x Y:y delegate:self count:count]];
//    self.segmentCl.hidden = NO;
//    merchantId = @"0002000002";
//    productId = @"0000000000";
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    self.navigationController.navigationBarHidden = NO;
    NSLog(@"%@=====%@",productId,merchantId);
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
    WebViewController *web = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    [web setTitle:L(@"help")];
    [web setUrl:ShopHelp];
    [self.navigationController pushViewController:web animated:YES];
}

-(void)chooseView:(ChooseView *)chooseView chooseAtIndex:(NSUInteger)chooseIndex
{

    payType = chooseIndex;
    payTool = [NSString stringWithFormat:@"0%d",chooseIndex];
    if (payType == QuickPayType) {
        self.segmentCl.hidden = NO;
        self.segmentCl.selectedSegmentIndex = 0;
        merchantId = @"0004000001";
        productId = @"0000000001";
    }else if (payType == AccountPayType) {
        self.segmentCl.hidden = YES;
        merchantId = @"0002000002";
        productId = @"0000000004";
    }else if (payType == CardPayType){
        self.segmentCl.hidden = NO;
        self.segmentCl.selectedSegmentIndex = 0;
        merchantId = @"0002000002";
        productId = @"0000000000";
    }
    UIView *v = chooseView.superview;
    for (UIView *c in v.subviews) {
        if ([c isKindOfClass:[ChooseView class]]) {
            if (c.tag != chooseIndex) {
                for (UIView *sv in c.subviews) {
                    if ([sv isKindOfClass:[UIButton class]]) {
                        [(UIButton*)sv setSelected:NO];
                    }
                    
                }
            }
        }
    }

}
//计算价格//拼装商品订单号（订单ID集合）
- (void)computePrice
{
    for (MallItem *dic  in CartArr) {
        int sum = [dic.sum intValue];
        NSString *pr = [NSString stringWithFormat:@"%.2f",[dic.price doubleValue]];
        long long price = [[pr stringByReplacingOccurrencesOfString:@"." withString:@""] integerValue];
        Sumprice += sum * price;
    
        [commodityIDArr addObject:dic.commodityID];
    }
    
    NSMutableString *temp = [NSMutableString string];
    for (NSMutableString *str in commodityIDArr) {
        [temp appendFormat:@"%@,",str];
    }
    
    orderDesc = mobileNo;
    commodityIDs = [temp substringToIndex:temp.length-1];
    
    finalPrice.text = [NSString stringWithFormat:@"%.2f",Sumprice / 100.0];
    totalPrice.text = [NSString stringWithFormat:@"%.2f",Sumprice / 100.0];

    
}
//图片解析。从string拼接后转成data
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getBuyType:(id)sender {
    switch ([sender selectedSegmentIndex]) {
        case 0://批发
            if ([payTool isEqualToString:@"03"]) {
                merchantId = @"0004000001";
                productId = @"0000000001";
            }
            else
            {
                merchantId = @"0002000002";
                productId = @"0000000000";
            }
            break;
        case 1://零售
            if ([payTool isEqualToString:@"03"]) {
                merchantId = @"0004000001";
                productId = @"0000000002";
            }
            else
            {
                merchantId = @"0005000001";
                productId = @"0000000000";
            }
            break;
        case 2://团购
            if ([payTool isEqualToString:@"03"]) {
                merchantId = @"0004000001";
                productId = @"0000000003";
            }
            else
            {
                merchantId = @"0002000002";
                productId = @"0000000002";
            }
        default:
            break;
    }
     NSLog(@"%@,%@",merchantId,productId);
}

//发送订单信息。得到回调信息才push
- (IBAction)pushToOrder:(id)sender {
    
    NSString *priceVer = finalPrice.text;
    priceVer = [NSString stringWithFormat:@"%.2f",[priceVer doubleValue]];
    NSString *priceVerde = finalPrice.text;
    if ([priceVer length] > 9 || [priceVerde isEqualToString:@""] || ![self matchStringFormat:priceVer withRegex:@"^([0-9]+\\.[0-9]{2})|([0-9]+\\.[0-9]{1})|[0-9]*$"]  || [priceVer isEqualToString:@"0.00"]) {
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"CorrectPrice")];
    }
    else if (![self matchStringFormat:priceVerde withRegex:@"^([0-9]+\\.[0-9]{2})|([0-9]+\\.[0-9]{1})|[0-9]*$"])
    {
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"CorrectPrice")];
    }
    else
    {
        NSString *price = [priceVer stringByReplacingOccurrencesOfString:@"." withString:@""];

    [request applyOrderMobileNo:[AppDelegate getUserBaseData].mobileNo
                      MerchanId:merchantId
                      productId:productId
                        orderAmt:price
                       orderDesc:orderDesc
                        orderRemark:@""
                   commodityIDs:commodityIDs
                        payTool:payTool];
    
        [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:L(@"OrderHasBeenSubmitted-PleaseLater")];

    }
}

-(void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type
{
    if ([[dict objectForKey:@"respCode"]isEqualToString:@"1001"]) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
    
    if([[dict objectForKey:@"respCode"]isEqualToString:@"0000"]){
        if (type == REQUSET_ORDER) {
            UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            OrderViewController *shopVc = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderViewController"];
            orderData = [[OrderData alloc]initWithData:dict];
            orderData.orderAccount = mobileNo;
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
        }

    }else{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showHUDAddedTo:self.view WithString:[dict objectForKey:@"respDesc"]];
    }
}

#pragma mark - tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"ShoppingCartTableViewCell";
    ShoppingCartTableViewCell *cell =(ShoppingCartTableViewCell*) [sTableView dequeueReusableCellWithIdentifier:cellID];
    MallItem *dic    = CartArr[indexPath.row];
    
    [cell.shopCartMerchandiseImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic.iconurl]]];
    cell.shopCartMerchandiseName.text = dic.title;
    cell.shopCartMerchandisePrice.text = dic.price;
    cell.shopCartMerchandiseSum.text = dic.sum;
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return CartArr.count;
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
