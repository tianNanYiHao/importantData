//
//  mallViewController.m
//  QuickPos
//
//  Created by 张倡榕 on 15/3/9.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import "MallViewController.h"
#import "ShoppingCartViewController.h"
#import "MallCollectionViewCell.h"
#import "Request.h"
#import "MJRefresh.h"
#import "MallData.h"
#import "UIImageView+WebCache.h"
#import "DDMenuController.h"
#import "QuickPosTabBarController.h"
#import "OrderViewController.h"
#import "EditMallViewController.h"
#import "ShopCartTableViewCell.h"
#import "MyBankListViewController.h"
#import "PayType.h"
#import "OrderData.h"
#import "Common.h"
#import "BoRefreshHeader.h"
#import "BoRefreshAutoStateFooter.h"
#import "SDCycleScrollView.h"
#import "DetailOriginOfGoodsViewController.h"

#define tableCellHeight 30

@interface MallViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIImagePickerControllerDelegate,ResponseData,UISearchBarDelegate,getOrderTypeProtocol,UITableViewDataSource,UITableViewDelegate,getOrderTypeProtocol,SDCycleScrollViewDelegate>
{
    AVCaptureSession * _AVSession;

    BOOL state;                         //是否处于编辑状态
    BOOL addType;
    BOOL
    
    
    mobileType;                    //判断商城是否不一致
    BOOL photoType;                     //判断图片是否改变
    BOOL mallOrderType;                     //订单上是否完成
    Request *request;
    int HintCount;                      //购物车提示计数；
    int deleteIndex;                    //删除索引
    int getDataType;                    //刷新或删除索引  0 = 初始  1 = 加载新   2 = 加载旧
    NSString *mobileNO;
    NSString *FristId ;
    NSString *LastId ;
    NSInteger indexRow;                 //记录点击的cell的row；
    NSString *collectionCellID;
    UIImage *takePhoneImg;
    NSMutableArray *MerchandiseArr;     //商城数据源
    NSMutableArray *shopCartArr;        //购物车商品数组
/********************************************************************************/
    MallItem *mallItem;
    MallData *mallData;
    NSArray *titleArray;//
    NSMutableArray *titleArr;//cell分区标题名称
    NSMutableArray *productListArray;
    NSMutableArray *productDicArray;//接受溯源商城和跨境电商的数据源
    NSMutableArray *productDicArr;//接受溯源商城和跨境电商列表数据
    NSString *refeshcardId;
    NSMutableArray *orderListArray;
    NSDictionary *detailDic;
    int prodetailNum;
    
    NSMutableArray *todayKillArr;//今日秒杀数据源
    NSString *modulesOrgId;
    
    
    NSMutableArray *commodityIDArr;
    NSString *orderDesc;
    NSString *payTool;
    OrderData *orderData;
    NSUInteger payType;
    NSString *commodityIDs;
    NSString *merchantId;
    NSString *productId;
    NSString *fromType;
    NSMutableArray *cartArray;
    NSMutableArray *CartArr;
    long long  Sumprice;
    NSDictionary *oneProductDic;//产品详情数据源
    NSDictionary *oneProductMoneyDic;
    NSDictionary *productlistDic;
    NSMutableArray *buttonArray;
    NSString *cartTotalMount;
    NSMutableArray *cateIdArr;
    
    UISegmentedControl *_segmentedCtrl;//segmented 分段按钮


}
@property (weak, nonatomic) IBOutlet UIButton *editAction;
@property (weak, nonatomic) IBOutlet UILabel *shopHint;                     //购物车计数label
@property (weak, nonatomic) IBOutlet UICollectionView *mallCollectionView;

@property (weak, nonatomic) IBOutlet UICollectionView *mallCollectionView1;//溯源商城和跨境电商中间跳转的collection


@property (weak, nonatomic) IBOutlet UIView *seachingView;
@property (weak, nonatomic) IBOutlet UIView *navView;           //
@property (weak, nonatomic) IBOutlet UISearchBar *SearchMall;
@property (weak, nonatomic) IBOutlet UIView *segview1;
@property (weak, nonatomic) IBOutlet UIView *segview2;
@property (weak, nonatomic) IBOutlet UIView *segview3;
@property (weak, nonatomic) IBOutlet UITableView *table;

@property (weak, nonatomic) IBOutlet UIView *Segview4;//产品分类
@property (weak, nonatomic) IBOutlet UITableView *categoriesTable;//产品分类table

@property (weak, nonatomic) IBOutlet UIView *segview5;//跨境电商

@property (weak, nonatomic) IBOutlet UITableView *CrossBorderTableview;//跨境电商tableview


@property (weak, nonatomic) IBOutlet UITableView *shopcarttable;
@property (weak, nonatomic) IBOutlet UIView *shopcarttableFootView;
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIView *shoplist1;//mallCollectionView
@property (weak, nonatomic) IBOutlet UIView *shoplist2;//mallCollectionView1

@property (weak, nonatomic) IBOutlet UIView *line;

@property (weak, nonatomic) IBOutlet UIView *mallDetailView;
@property (weak, nonatomic) IBOutlet UIView *shopCateView;
@property (weak, nonatomic) IBOutlet UIView *sureCateView;
@property (weak, nonatomic) IBOutlet UIView *consigneeView;  //
@property (weak, nonatomic) IBOutlet UIButton *historyAddressBtn;  //历史地址按钮


@property (weak, nonatomic) IBOutlet UIView *payView;
@property (weak, nonatomic) IBOutlet UIView *choiceView;

@property (weak, nonatomic) IBOutlet UITableView *surecarttable;
@property (weak, nonatomic) IBOutlet UIView *surecarttableFootView;


@property (weak, nonatomic) IBOutlet UITableView *shopCateTable;


@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;
@property (weak, nonatomic) IBOutlet UIImageView *smallImageView1;
@property (weak, nonatomic) IBOutlet UIImageView *smallImageView2;
@property (weak, nonatomic) IBOutlet UIImageView *smallImageView3;
@property (weak, nonatomic) IBOutlet UIImageView *smallImageView4;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *discount;//促销价
@property (weak, nonatomic) IBOutlet UILabel *original;//原价

@property (weak, nonatomic) IBOutlet UILabel *inventory;//库存量

@property (weak, nonatomic) IBOutlet UILabel *express;//快递方式
@property (weak, nonatomic) IBOutlet UILabel *detailattribute;
@property (weak, nonatomic) IBOutlet UILabel *detailNum;

@property (weak, nonatomic) IBOutlet UIView *prodetailView;

@property (weak, nonatomic) IBOutlet UITextField *nametext;
@property (weak, nonatomic) IBOutlet UITextField *phonetext;
@property (weak, nonatomic) IBOutlet UITextView *addresstext;
@property (strong, nonatomic) IBOutlet UILabel *totalMoneyLabel;
@property (strong, nonatomic) IBOutlet UILabel *lasttotalMoneyLabel;
@property (weak, nonatomic) IBOutlet UIButton *button1;

@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;

@property (nonatomic, assign)BOOL isMall;       //判断是否从商城点击
@property (nonatomic,assign) BOOL isMallCollection;//判断是否collectionView点击
@property (nonatomic,assign) BOOL isCardPay;//判断是否刷卡支付
@property (nonatomic,strong) NSString *orderStatus;

@property (nonatomic,strong) NSString *productId;



@end

@implementation MallViewController
@synthesize editAction;
@synthesize seachingView;
@synthesize shopHint;
@synthesize SearchMall;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self createSegmented];
    [self creatRightBtn];
    
    self.title = @"溯源商城";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
    
    self.navigationController.navigationBar.tintColor = [Common hexStringToColor:@"#0778f8"];//返回键颜色
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor ];//导航栏颜色
    
    
    self.navigationController.navigationBar.contentMode = UIViewContentModeScaleAspectFit;
    //设置标题颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:  [UIColor blackColor], UITextAttributeTextColor,
                                                                     [UIFont systemFontOfSize:17], UITextAttributeFont,
                                                                     nil]];
    
    
    
    
    if (iOS7) {
        self.automaticallyAdjustsScrollViewInsets = NO;//解决向下偏移
    }
    SearchMall.layer.masksToBounds = YES;
    SearchMall.layer.cornerRadius = 5.0;
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getOrderFinish:) name:@"ClearShoppingCartNotification" object:nil];
    [self.segview1 setHidden:YES];
    [self.segview2 setHidden:NO];
    [self.segview3 setHidden:YES];
    [self.Segview4 setHidden:YES];
    [self.segview5 setHidden:YES];
    [self.mainView bringSubviewToFront:self.segview2];
    
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"正在加载商品数据."];
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"正在加载商品数据."];
    [request sendInfo];
 
    
    NSLog(@"%@",request);
    
    
    
    self.mallCollectionView.tag = 60001;
    self.mallCollectionView1.tag = 60002;
    
    self.mallCollectionView1.delegate = self;//新增加的collectionView
    self.mallCollectionView1.dataSource = self;//新增加的collectionView
    
    
    self.mallCollectionView.delegate = self;//原来的collectionView
    self.mallCollectionView.dataSource = self;//原来的collectionView

    self.table.delegate = self;
    self.table.dataSource = self;
    
    self.categoriesTable.delegate = self;
    self.categoriesTable.dataSource = self;
    
    self.table.tag = 50001;
    self.categoriesTable.tag = 50005;
    
    self.table.header = [BoRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    titleArray =[[NSArray alloc] init];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    self.categoriesTable.header = [BoRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.categoriesTable.separatorStyle = UITableViewCellSeparatorStyleNone;


    self.table.scrollEnabled = YES;
    self.table.sectionFooterHeight = 0;
    self.table.sectionHeaderHeight = 0;
    
    self.categoriesTable.scrollEnabled = YES;
    self.categoriesTable.sectionFooterHeight = 0;
    self.categoriesTable.sectionHeaderHeight = 0;

    
    self.shopcarttable.sectionHeaderHeight = 0;
    self.shopcarttable.sectionFooterHeight = 120;
    self.shopcarttable.delegate = self;
    self.shopcarttable.dataSource = self;
    self.shopcarttable.tag = 50002;
    self.shopcarttable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.shopcarttable.tableFooterView = self.shopcarttableFootView;
    [self.mainView bringSubviewToFront:self.segview1];
    [self.view sendSubviewToBack:self.choiceView];
    
    
    self.surecarttable.sectionHeaderHeight = 0;
    self.surecarttable.sectionFooterHeight = 120;
    self.surecarttable.delegate = self;
    self.surecarttable.dataSource = self;
    self.surecarttable.tag = 50003;
    self.surecarttable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.surecarttable.tableFooterView = self.surecarttableFootView;
    
    self.shopCateTable.sectionHeaderHeight = 0;
    self.shopCateTable.sectionFooterHeight = 120;
    self.shopCateTable.delegate = self;
    self.shopCateTable.dataSource = self;
    self.shopCateTable.tag = 50004;
    self.shopCateTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    self.totalMoneyLabel.text = @"合计（不含运费）：60";
    self.totalMoneyLabel.text = @"";
    buttonArray =[[NSMutableArray alloc] init];
    
    [self.button1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.button2 setTitleColor:[UIColor lightGrayColor]  forState:UIControlStateNormal];
    [self.button3 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
}

//自定义segmented
#pragma mark --自定义segmented
- (void)createSegmented
{
    _segmentedCtrl = [[UISegmentedControl alloc]init];
    _segmentedCtrl.layer.cornerRadius = 20;
    _segmentedCtrl.clipsToBounds = YES;
    _segmentedCtrl = [[UISegmentedControl alloc]initWithItems:@[@"商城首页",@"订单查询",@"购物车"]];
    _segmentedCtrl.frame = CGRectMake(10, 5, self.view.frame.size.width-20, 30);
    //修改颜色
    [_segmentedCtrl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    _segmentedCtrl.selectedSegmentIndex = 0;
    [_segmentedCtrl addTarget:self action:@selector(segmentACT:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:_segmentedCtrl];
}
//navgantion  rightbtn
- (void)creatRightBtn
{
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightBtn setImage:[UIImage imageNamed:@"serve_more"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    //    [rightBtn release];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)rightBtn:(UIButton *)btn
{
    [(DDMenuController*)[(QuickPosTabBarController*)self.tabBarController parentCtrl] showRightController:YES];

}

- (void)loadNewData{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.table reloadData];
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.table.header endRefreshing];
    });
}
//初始化数据
-(void)initData
{
    mobileNO = [AppDelegate getUserBaseData].mobileNo;
    HintCount = 0;
    getDataType = 0;
    shopCartArr = [NSMutableArray array];
    MerchandiseArr = [NSMutableArray array];
    request = [[Request alloc]initWithDelegate:self];
    state = NO;
    mobileType = YES;
    addType = NO;
    seachingView.hidden = YES;
    shopHint.hidden = YES;
    shopHint.layer.masksToBounds = YES;
    shopHint.layer.cornerRadius = 10;
    collectionCellID = @"MallCollectionViewCellID";
    
    //下拉,上拉
    self.mallCollectionView.header = [BoRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
//    [self.mallCollectionView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    [self cancelFristResponder]; //取消第一响应者
    
}
//半透明遮罩按钮隐藏
-(IBAction)tapBackToHide:(id)sender{
    UIButton *button = (id)sender;
    [button setHidden: YES];
}

#pragma 立即购买按钮Btn
//立即购买
- (IBAction)mallDetailToconsigneeView:(id)sender{
    [self.mainView bringSubviewToFront:self.consigneeView];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"正在计算商品价格."];
   
    productlistDic = @{@"productId":[detailDic objectForKey:@"productId"],
            @"discount":[NSString stringWithFormat:@"%li",[[[[detailDic objectForKey:@"MODEL"] objectAtIndex:0] objectForKey:@"discount"] longValue]],
            @"count":[NSString stringWithFormat:@"%d",prodetailNum],
            @"expressId":[[[detailDic objectForKey:@"express"] objectAtIndex:0] objectForKey:@"expressId"],
            @"expressprice":[[[detailDic objectForKey:@"express"] objectAtIndex:0] objectForKey:@"amount"],
            @"productAttributeId":[[[detailDic objectForKey:@"MODEL"] objectAtIndex:0] objectForKey:@"productAttributeId"]
            };
    NSLog(@"%@",productlistDic);
    
    fromType = @"detail";
    
    //MALL0007 接口
    [request getMoneyInfoWithProductId:[oneProductDic objectForKey:@"productId"] productList:[NSArray arrayWithObjects:productlistDic, nil]];
}

#pragma mark 加入购物车
//加入购物车
- (IBAction)mallDetailToChoiceView:(id)sender{
    [self.view bringSubviewToFront:self.choiceView];
    productlistDic = @{@"productId":[detailDic objectForKey:@"productId"],
                       @"discount":[NSString stringWithFormat:@"%li",[[[[detailDic objectForKey:@"MODEL"] objectAtIndex:0] objectForKey:@"discount"] longValue]],
                       @"count":[NSString stringWithFormat:@"%d",prodetailNum],
                       @"expressId":[[[detailDic objectForKey:@"express"] objectAtIndex:0] objectForKey:@"expressId"],
                       @"expressprice":[[[detailDic objectForKey:@"express"] objectAtIndex:0] objectForKey:@"amount"],
                       @"productAttributeId":[[[detailDic objectForKey:@"MODEL"] objectAtIndex:0] objectForKey:@"productAttributeId"]
                       };
    
    
    
    HintCount++;
    shopHint.hidden = NO;
    shopHint.text = [NSString stringWithFormat:@"%d",HintCount];
    
    NSMutableArray *copyShopArr = [NSMutableArray arrayWithArray:shopCartArr];
    
    int index = 0;
    BOOL yno = NO;
    //拷贝数组用于循环取值。
    //不为空。进入判断。
    if (shopCartArr.count != 0) {
        //取标示用于for循环比较。
        NSString *Tag = [(MallItem*)mallData.mallArr[indexRow] commodityID] ;
        //进入循环。。dic循环copy数组。
        for (MallItem *dic in copyShopArr) {
            NSString *TagT = dic.commodityID;
            //判断是标示，如相同，再次进入循环。
            if ([Tag isEqualToString:TagT]) {
                //取出计数
                NSString *sum = dic.sum;
                int temp = [sum intValue];
                //计数+1
                temp=temp +prodetailNum;
                //写入计数
                [(MallItem*)shopCartArr[index] setSum:[NSString stringWithFormat:@"%d",temp]];
                //修改判断为YES
                yno = YES;
                //跳出循环
                break;
            }
            index ++;
        }
        //判断是否修改如，如果修改判断为NO。则点击item数据在原有数据中没有存在。则
        if (yno == NO) {
            [(MallItem*)mallData.mallArr[indexRow] setSum:[NSString stringWithFormat:@"%d",prodetailNum]];
            [(MallItem*)mallData.mallArr[indexRow] setDic:productlistDic];
            [shopCartArr addObject:mallData.mallArr[indexRow]];
        }
    }
    //如果为空则直接加入。
    else if (shopCartArr.count == 0) {
        [(MallItem*)mallData.mallArr[indexRow] setSum:[NSString stringWithFormat:@"%d",prodetailNum]];
        [(MallItem*)mallData.mallArr[indexRow] setDic:productlistDic];
        [shopCartArr addObject:mallData.mallArr[indexRow]];
    }

}
//隐藏购物车选择view
- (IBAction)controlTap:(id)sender{
    [self.view sendSubviewToBack:self.choiceView];
}

#pragma mark 点击继续购物Btn 进入shoplist1 (商品展示页)
- (IBAction)choiceViewToShopList:(id)sender{
    [self.view sendSubviewToBack:self.choiceView];
    [self.mainView bringSubviewToFront:self.shoplist1];
}

#pragma mark 点击 去购物车结算 按钮 进入 购物车结算页
- (IBAction)choiceViewToShopCartView:(id)sender{
    [self.view sendSubviewToBack:self.choiceView];
    [self.segview3 setHidden:NO];
    [self.mainView bringSubviewToFront:self.segview3];
    float total =0.0;
    for (MallItem * item  in shopCartArr) {
        total = total + [item.price floatValue]*[item.sum intValue];
    }
    self.totalMoneyLabel.text = [NSString stringWithFormat: @"合计（不含运费）：%.2f",total/100.0f];
    [self.shopcarttable reloadData];
}
#pragma mark 点击结算按钮 进入(结算)确认页
- (IBAction)shopCartToSureView:(id)sender{
    [self.mainView bringSubviewToFront:self.sureCateView];
    NSMutableArray *array =[[NSMutableArray alloc] init];
    for (MallItem * a in shopCartArr) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:a.dic];
        [dic setObject:a.sum forKey:@"count"];
        [array addObject: dic];
    }
    [self.surecarttable reloadData];
    fromType = @"cart";
    
    //MALL0007接口
    [request getMoneyInfoWithProductId:nil productList:array];
}

//再次点击计算 进入 地址页consignview
- (IBAction)sureCartToconsigneeView:(id)sender {
    [self.mainView bringSubviewToFront:self.consigneeView];
    
}

#pragma mark  判断输入收货信息,并跳转支付方式页面
//判断输入收货信息,并跳转支付方式页面
- (IBAction)consigneeViewTopayView:(id)sender {
    if ([self.nametext.text length] ==0) {
        [MBProgressHUD showHUDAddedTo:self.view WithString:@"请输入姓名"];
    }else{
        if ([self.phonetext.text length] ==0) {
            [MBProgressHUD showHUDAddedTo:self.view WithString:@"请输入手机号码"];
        }else{
            if ([self.addresstext.text length] ==0) {
                [MBProgressHUD showHUDAddedTo:self.view WithString:@"请输入收货地址"];
            }else{
                
                [self.mainView bringSubviewToFront:self.payView];
            }
        }
    }
    
    [request gettotalMoneyWithProductLists:[NSArray arrayWithObjects:productlistDic, nil] withMobile:self.phonetext.text withTotal:[NSString stringWithFormat:@"%li",[[oneProductMoneyDic objectForKey:@"totalAmount"] longValue]]];
}
#pragma mark 计算价格
//计算价格
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
    
    orderDesc = self.phonetext.text;
    commodityIDs = [temp substringToIndex:temp.length-1];
    
//    finalPrice.text = [NSString stringWithFormat:@"%.2f",Sumprice / 100.0];
//    totalPrice.text = [NSString stringWithFormat:@"%.2f",Sumprice / 100.0];
    
    
}

#pragma mark 在线支付
//在线支付
- (IBAction)onlinePay:(id)sender{
    
    payType = QuickPayType;
    commodityIDArr = [NSMutableArray array];
    orderDesc = [NSMutableString string];
    payTool = @"01";
    
    merchantId = @"0008000004";
    productId = @"0000000001";
    
    if ([fromType isEqualToString:@"detail"]) {
        
        [request applyOrderMobileNo:[AppDelegate getUserBaseData].mobileNo
                          MerchanId:merchantId
                          productId:productId
                           orderAmt:orderData.orderAmt
                          orderDesc:@"18516032822" //填写的充值账户
                        orderRemark:@""
                       commodityIDs:@""
                            payTool:payTool];
    }else{
        NSMutableArray *array =[[NSMutableArray alloc] init];
        for (MallItem * a in shopCartArr) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:a.dic];
            [dic setObject:a.sum forKey:@"count"];
            [array addObject: dic];
        }

        [request gettotalMoneyWithProductLists:array withMobile:self.phonetext.text withTotal:cartTotalMount];
    }
    
}

#pragma mark 刷卡支付
//刷卡支付
- (IBAction)userCardToPay:(id)sender{
    _isCardPay = YES;
    payType = CardPayType;
    commodityIDArr = [NSMutableArray array];
    orderDesc = [NSMutableString string];
    payTool = @"01";
    merchantId = @"0008000001";
    productId = @"0000000000";
    if ([fromType isEqualToString:@"detail"]) {
    
        [request applyOrderMobileNo:[AppDelegate getUserBaseData].mobileNo
                          MerchanId:merchantId
                          productId:productId
                           orderAmt:orderData.orderAmt
                          orderDesc:@"18516032822" //填写的充值账户
                        orderRemark:@""
                       commodityIDs:@""
                            payTool:payTool];

        NSLog(@"%@  %@",merchantId,productId);
        
    }else{
        NSMutableArray *array =[[NSMutableArray alloc] init];
        for (MallItem * a in shopCartArr) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:a.dic];
            [dic setObject:a.sum forKey:@"count"];
            [array addObject: dic];
        }

        [request gettotalMoneyWithProductLists:array withMobile:self.phonetext.text withTotal:cartTotalMount];
    }
    
}
#pragma mark - 跳转订单信息
- (void)toordViewwith:(OrderData *)orderData{
    
    OrderViewController *shopVc = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderViewController"];
    shopVc.orderData = orderData;
    NSLog(@"%@",shopVc.orderData);
    
    for (UIViewController *v in self.navigationController.viewControllers) {
        if ([v isKindOfClass:[MallViewController class]]) {
            shopVc.delegate = v;

        }
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self.navigationController pushViewController:shopVc animated:YES];
}

#pragma mark seg分段

- (void)segmentACT:(UISegmentedControl *)Seg
{
    //线动画
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.line.frame;
        frame.origin.x = Seg.frame.origin.x;
        self.line.frame = frame;
    }];
    
    NSInteger index = Seg.selectedSegmentIndex;
    
    switch (index) {
        case 0:
        {
            [self.button1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [self.button2 setTitleColor:[UIColor lightGrayColor]  forState:UIControlStateNormal];
            [self.button3 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [self.segview1 setHidden:YES];
            [self.segview2 setHidden:NO];
            [self.segview3 setHidden:YES];
            [self.Segview4 setHidden:YES];
            [self.segview5 setHidden:YES];
            [self.mainView bringSubviewToFront:self.segview2];
            
            [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"正在加载商品数据."];
            [request sendInfo];
        }
            break;
//        case 1:
//        {
//            
//
//            [self.segview1 setHidden:YES];
//            [self.segview2 setHidden:YES];
//            [self.segview3 setHidden:YES];
//            [self.Segview4 setHidden:NO];
//            [self.segview5 setHidden:YES];
//            [self.mainView bringSubviewToFront:self.Segview4];
//            
//            [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"正在加载商品数据."];
//
//            [request sendInfo];
//
//            
//        }
//            break;
        case 1:
        {
            [self.button1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [self.button2 setTitleColor:[UIColor lightGrayColor]  forState:UIControlStateNormal];
            [self.button3 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                        [self.segview1 setHidden:YES];
                        [self.segview2 setHidden:YES];
                        [self.segview3 setHidden:YES];
                        [self.Segview4 setHidden:YES];
                        [self.segview5 setHidden:YES];
                        [self.shopCateView setHidden:NO];
            
            [self.mainView bringSubviewToFront:self.shopCateView];
//            [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"正在加载订单信息."];
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"正在加载订单信息."];
            [hud hide:YES afterDelay:1];
            [request getInfoWithMobile:@"18516032822"];

           
        }
            break;
        case 2:
        {
            [self.button1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [self.button2 setTitleColor:[UIColor redColor]  forState:UIControlStateNormal];
            [self.button3 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            
            
            [self.segview1 setHidden:YES];
            [self.segview2 setHidden:YES];
            [self.segview3 setHidden:NO];
            [self.Segview4 setHidden:YES];
            [self.segview5 setHidden:YES];
            [self.mainView bringSubviewToFront:self.segview3];
            [self.shopcarttable reloadData];
            float total =0.0;
            for (MallItem * item  in shopCartArr) {
                total = total + [item.price floatValue]*[item.sum intValue];
            }
            self.totalMoneyLabel.text = [NSString stringWithFormat: @"合计（不含运费）：%.2f",total/100.0f];
        }
            break;
        default:
            break;
    }
}



- (void)orderSearch{
    [self.mainView bringSubviewToFront:self.shopCateView];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"正在加载订单信息."];
    [request getInfoWithMobile:@"18516032822"];
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    
//    if (mallData.mallArr.count != 0) {
//        FristId = [mallData.mallArr[0] commodityID];
//        LastId = [mallData.mallArr[mallData.mallArr.count-1] commodityID];
//    }
    self.navigationController.navigationBarHidden = NO;
//    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
//    self.title = @"捷丰商城";

    
    UIButton *rightbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 65, 45)];
    [rightbtn setTitle:@"订单查询" forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(orderSearch) forControlEvents:UIControlEventTouchUpInside];
    rightbtn.titleLabel.font = [UIFont systemFontOfSize:14];
//    UIBarButtonItem *rightbar = [[UIBarButtonItem alloc]initWithCustomView:rightbtn];
//    self.navigationItem.rightBarButtonItem = rightbar;
//    self.navigationItem.rightBarButtonItem = nil;
    
//    if (!mallData.mallArr.count) {
//        [self setUpCollection];
//    }
//    else
//    {
//        [self.mallCollectionView headerBeginRefreshing];
//    }
}

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}
- (IBAction)showSetup:(UIBarButtonItem *)sender {
    
    [(DDMenuController*)[(QuickPosTabBarController*)self.tabBarController parentCtrl] showRightController:YES];
}


-(void)cancelFristResponder
{
    UIControl *backGroundControl = [[UIControl alloc] initWithFrame:
                                    CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    backGroundControl.backgroundColor = [UIColor clearColor];
    [backGroundControl addTarget:self
                          action:@selector(backgroundTab)
                forControlEvents:UIControlEventTouchUpInside];
    UIControl *backGroundControl1 = [[UIControl alloc] initWithFrame:
                                    CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    backGroundControl1.backgroundColor = [UIColor clearColor];
    [backGroundControl1 addTarget:self
                          action:@selector(backgroundTab)
                forControlEvents:UIControlEventTouchUpInside];
    [self.seachingView addSubview:backGroundControl1];
}
//取消第一响应者事件
- (void)backgroundTab
{
    [SearchMall resignFirstResponder];
    seachingView.hidden = YES;
}
//图片data转成字符串
- (NSString *)stringWithData:(NSData *)data
{
       //获取到之后要去掉尖括号和中间的空格
    NSString *strdata = [NSString stringWithFormat:@"%@",data];
    NSMutableString *st = [NSMutableString stringWithString:strdata];
    [st deleteCharactersInRange:NSMakeRange(0, 1)];
    [st deleteCharactersInRange:NSMakeRange(st.length-1, 1)];
    NSString *imageStr = [st stringByReplacingOccurrencesOfString:@" " withString:@""];
    return imageStr;
}
//下拉
-(void)headerRereshing
{
    getDataType = 1;
//    [request getMallListmobile:mobileNO firstData:FristId lastData:@"0" dataSize:@"20" requestType:@"02"];
    
    [request getProductWithCardId:refeshcardId];
}
//上拉
- (void)footerRereshing
{
    getDataType = 2;
    [request getMallListmobile:mobileNO firstData:@"0" lastData:LastId dataSize:@"20" requestType:@"01"]; 
}
//网络接口加载collection数据。
- (void)setUpCollection
{
    getDataType = 0;
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"正在加载商品数据."];
//    [hud hide:YES afterDelay:10];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"正在加载商品数据."];
    [request getMallListmobile:mobileNO firstData:@"0" lastData:@"0" dataSize:@"20" requestType:@"02"];
    
}
//网络数据返回
#pragma mark 网络数据返回
- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type
{

    if (type == REQUSET_AD) {


        if([[[dict objectForKey:@"REP_HEAD"] objectForKey:@"TRAN_CODE"] isEqualToString:@"000000"]){
            NSLog(@"data:%@",[[dict objectForKey:@"REP_BODY"] objectForKey:@"mallAdvs"]);
            NSArray *array = [[dict objectForKey:@"REP_BODY"] objectForKey:@"mallAdvs"];
            NSMutableArray *mutableArray =[[NSMutableArray alloc] init];
            for (int i = 0; i < [array count]; i++) {
                NSDictionary * dic = [array objectAtIndex:i];
                [mutableArray addObject:[dic objectForKey:@"image"]];
                
            }
            
        }
        else
        {
            [MBProgressHUD showHUDAddedTo:self.view WithString:@"查询失败！"];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
    else if (type == REQUSET_PRODUCTLIST) {//商城产品列表

        NSLog(@"%@",dict);
        [self.mallCollectionView.header endRefreshing];
        
        if([[[dict objectForKey:@"REP_HEAD"] objectForKey:@"TRAN_CODE"] isEqualToString:@"000000"]){
            productListArray = [[NSMutableArray alloc] initWithArray:[[dict objectForKey:@"REP_BODY"] objectForKey:@"mallProducts"]];
            mallData = [[MallData alloc]initWithData:productListArray];
            [self.mallCollectionView reloadData];
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        }else{
            [MBProgressHUD showHUDAddedTo:self.view WithString:@"查询失败！"];
        }
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
    else if (type == REQUSET_PRODUCTIDLIST) {//溯源商城和跨境电商产品列表
        _isMallCollection = NO;

        NSLog(@"%@",dict);
        [self.mallCollectionView1.header endRefreshing];
        self.mallCollectionView1.hidden = NO;
        if([[[dict objectForKey:@"REP_HEAD"] objectForKey:@"TRAN_CODE"] isEqualToString:@"000000"]){
            productDicArray = nil;
            productDicArray = [[NSMutableArray alloc] initWithArray:[[dict objectForKey:@"REP_BODY"] objectForKey:@"mallProducts"]];
            NSLog(@"%@",productDicArray);
            mallData = [[MallData alloc]initWithData:productDicArray];
            [self.mallCollectionView1 reloadData];
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            
        }else{

            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"商品信息不存在!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                self.mallCollectionView1.hidden = YES;
            }];
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
    else if (type == REQUSET_ORDER_INQUIRY) {

        NSLog(@"%@",dict);
        if([[[dict objectForKey:@"REP_HEAD"] objectForKey:@"TRAN_CODE"] isEqualToString:@"000000"]){
            orderListArray = [[NSMutableArray alloc] initWithArray:[[dict objectForKey:@"REP_BODY"] objectForKey:@"termPrdOrders"]];
            //            [self.shopCateTable reloadData];//订单去掉，不要显示出来
            
        }else{
            [MBProgressHUD showHUDAddedTo:self.view WithString:@"查询失败！"];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
    else if(type == REQUSET_FIRST){//产品类别

        if([[[dict objectForKey:@"REP_HEAD"] objectForKey:@"TRAN_CODE"] isEqualToString:@"000000"]){
            
            titleArray = [[NSMutableArray alloc] initWithArray:[[dict objectForKey:@"REP_BODY"] objectForKey:@"MainCateInfs"]];
     
             mallData = [[MallData alloc]initWithData:productListArray];
            [self.mallCollectionView1 reloadData];
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        }
        else
        {
            [MBProgressHUD showHUDAddedTo:self.view WithString:@"查询失败！"];
        }
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
    else if(type == REQUSET_PRODUCTDETAIL){//详情页面

        if([[[dict objectForKey:@"REP_HEAD"] objectForKey:@"TRAN_CODE"] isEqualToString:@"000000"]){
            detailDic = [[NSDictionary alloc] initWithDictionary:[dict objectForKey:@"REP_BODY"]];
            self.productId = [detailDic objectForKey:@"productId"];
            [self loadDetail];
            
            [self.table reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        }
        else
        {
            [MBProgressHUD showHUDAddedTo:self.view WithString:@"查询失败！"];
        }
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
    else if(type == REQUSET_GETORIGIN){//溯源查询
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        DetailOriginOfGoodsViewController *DetailOriginVc = [mainStoryboard instantiateViewControllerWithIdentifier:@"DetailOriginOfGoodsViewController"];
        //        if([[[dict objectForKey:@"REQ_HEAD"] objectForKey:@"TransCode"] isEqualToString:@"Tx000001"]){
        //            detailDic = [[[NSDictionary alloc] initWithDictionary:[dict objectForKey:@"REQ_BODY"]]objectForKey:@"data"];
        
        DetailOriginVc.titleName = [dict  objectForKey:@"name"];
        DetailOriginVc.producerName = [dict  objectForKey:@"producerName"];
        DetailOriginVc.thumbnailUrl = [dict objectForKey:@"thumbnailUrl"];
        DetailOriginVc.pictureUrl = [dict objectForKey:@"pictureUrl"];
        DetailOriginVc.guaranteeDays = [dict objectForKey:@"guaranteeDays"];
        DetailOriginVc.standard = [dict objectForKey:@"standard"];
        DetailOriginVc.productDescriptions = [dict objectForKey:@"description"];
        
        NSLog(@"%@  %@  %@  %@  %@  %@  %@",DetailOriginVc.titleName,DetailOriginVc.producerName,DetailOriginVc.thumbnailUrl, DetailOriginVc.pictureUrl,DetailOriginVc.guaranteeDays,DetailOriginVc.standard,DetailOriginVc.productDescriptions);
        
        if ([[dict objectForKey:@"data"]objectForKey:@"name"] == nil) {
            [Common showMsgBox:@"" msg:@"此商品不可溯源" parentCtrl:self];
        }else
        {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.navigationController pushViewController:DetailOriginVc animated:YES];
            
        }
      
    }
    else if (type == REQUEST_GETMASTMALL){//百步商城
        _isMallCollection = YES;

        if([[[dict objectForKey:@"REP_HEAD"] objectForKey:@"TRAN_CODE"] isEqualToString:@"000000"]){
            productDicArray = [[NSMutableArray alloc] initWithArray:[[dict objectForKey:@"REP_BODY"] objectForKey:@"MainCateInfs"]];
            mallData = [[MallData alloc]initWithData:productDicArray];
            NSLog(@"%@  %@",productDicArray,productListArray);
            
            [self.mallCollectionView1 reloadData];
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        }
                
        else{
            [MBProgressHUD showHUDAddedTo:self.view WithString:@"查询失败！"];
        }
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
    else if (type == REQUSET_GETTODAYKILL){//今日秒杀

        if ([[[dict objectForKey:@"REP_HEAD"] objectForKey:@"TRAN_CODE"]isEqualToString:@"000000"]) {
            productListArray = [[NSMutableArray alloc]initWithArray:[[dict objectForKey:@"REP_BODY"]objectForKey:@"mallProducts"]];
            NSLog(@"%@",productListArray[0]);
            refeshcardId = [productListArray[0] objectForKey:@"categoryId"];
            [self.mallCollectionView reloadData];
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        }else{
            [MBProgressHUD showHUDAddedTo:self.view WithString:@"查询失败！"];
        }
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
    else if (type == REQUEST_GETCROSSBORDER){//跨境电商
        _isMallCollection = YES;

        if([[[dict objectForKey:@"REP_HEAD"] objectForKey:@"TRAN_CODE"] isEqualToString:@"000000"]){
            productDicArray = [[NSMutableArray alloc] initWithArray:[[dict objectForKey:@"REP_BODY"] objectForKey:@"MainCateInfs"]];
                        mallData = [[MallData alloc]initWithData:productDicArray];
            
            
//                        refeshcardId = [productDicArray[0] objectForKey:@"cateId"];
            [self.mallCollectionView1 reloadData];
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        }else{
            [MBProgressHUD showHUDAddedTo:self.view WithString:@"查询失败！"];
        }
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
    
    //合计
    else if (type == REQUSET_GETMONEY) {

        NSLog(@"%@",dict);
        [self.mallCollectionView.header endRefreshing];
        if([[[dict objectForKey:@"REP_HEAD"] objectForKey:@"TRAN_CODE"] isEqualToString:@"000000"]){
             if ([fromType isEqualToString:@"detail"]) {
                 oneProductMoneyDic = [[NSDictionary alloc] initWithDictionary:[dict objectForKey:@"REP_BODY"]];
             }else{
                 cartTotalMount = [NSString stringWithFormat:@"%f", [[[dict objectForKey:@"REP_BODY"] objectForKey:@"totalAmount"] floatValue]];
                 self.lasttotalMoneyLabel.text = [NSString stringWithFormat:@"合计：%.2f", [[[dict objectForKey:@"REP_BODY"] objectForKey:@"totalAmount"] floatValue]/100.0f];
             }
            
            
        }else{
            [MBProgressHUD showHUDAddedTo:self.view WithString:@"查询失败！"];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }//申请订单
    else if (type == REQUSET_ORDER) {
        if([[dict objectForKey:@"respCode"]isEqualToString:@"0000"]){
            self.orderStatus = @"00";
            NSLog(@"%@>>>>>>>>>>>>>>>>>",self.orderStatus);
            OrderViewController *shopVc = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderViewController"];
            orderData = [[OrderData alloc]initWithData:dict];
            orderData.orderAccount = [AppDelegate getUserBaseData].mobileNo;
            orderData.orderPayType = payType;
            if (_isCardPay) {
                _isCardPay = NO;
                orderData.merchantId = merchantId;
                orderData.productId = productId;
            }else
            {
                orderData.merchantId = merchantId;
                orderData.productId = productId;
            }
            
            //                orderData.mallOrder = YES;
            shopVc.orderData = orderData;
            shopVc.receiverName = self.nametext.text;
            shopVc.receiverPhone = self.phonetext.text;
            shopVc.receiverAddress = self.addresstext.text;
            shopVc.orderStatus = self.orderStatus;
            NSLog(@"%@  %@  %@<<<<<<<<<<<<<<<",shopVc.receiverName,shopVc.receiverPhone,shopVc.orderStatus);
            
            for (UIViewController *v in self.navigationController.viewControllers) {
                if ([v isKindOfClass:[MallViewController class]]) {
                    shopVc.delegate = v;
                }
            }
            
            [self.navigationController pushViewController:shopVc animated:YES];
            //            [self.navigationController presentViewController:shopVc animated:YES completion:nil];
        }else
        {
            self.orderStatus = @"02";
        }
          [MBProgressHUD hideHUDForView:self.view animated:YES];
    }//商城订单
    else  if (type == REQUSET_GETORDER) {
      
        if([[[dict objectForKey:@"REP_HEAD"] objectForKey:@"TRAN_CODE"] isEqualToString:@"000000"]){
            if ([fromType isEqualToString:@"detail"]) {
                NSDictionary *dic = [[NSDictionary alloc] initWithDictionary:[dict objectForKey:@"REP_BODY"]];
                //                OrderData *orderData = [[OrderData alloc] init];
                orderData = [[OrderData alloc]init];
                orderData.orderId = [dic objectForKey:@"orderid"];//订单编号
                NSLog(@"%@",orderData.orderId);
                orderData.orderAmt = [NSString stringWithFormat:@"%li",[[oneProductMoneyDic objectForKey:@"totalAmount"] longValue]];//订单金额
                orderData.orderDesc = [dic objectForKey:@"mercId"] ;//订单详情
                orderData.realAmt = [dic objectForKey:@"totalAmount"];//实际交易金额
                
                
                orderData.orderAccount = mobileNO;
                orderData.orderPayType = payType;
                
                orderData.merchantId = merchantId;
                orderData.productId = productId;
                
                //                [self toordViewwith:orderData];
            }else{
                NSDictionary *dic = [[NSDictionary alloc] initWithDictionary:[dict objectForKey:@"REP_BODY"]];
                //                OrderData *orderData = [[OrderData alloc] init];
                orderData = [[OrderData alloc]init];
                orderData.orderId = [dic objectForKey:@"orderid"];//订单编号
                orderData.orderAmt = cartTotalMount;//订单金额
                orderData.orderDesc = [dic objectForKey:@"mercId"] ;//订单详情
                orderData.realAmt = [dic objectForKey:@"totalAmount"];//实际交易金额
                orderData.orderAccount = mobileNO;
                orderData.orderPayType = payType;
                orderData.merchantId = merchantId;
                orderData.productId = productId;
                //                [self toordViewwith:orderData];
            }
        
            
        
            
            
            
        }else{
            
            [MBProgressHUD showHUDAddedTo:self.view WithString:@"提交失败！"];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }

    else{
        
        if([[dict objectForKey:@"respCode"] isEqualToString:@"0000"]){
            
            if (mobileType == NO) {
                [MerchandiseArr removeAllObjects];
                mobileType = YES;
            }
            //获取数据
            if (type == REQUEST_COMMODITYLIST)
            {
                if (getDataType == 0) {
                    //            正常获取
                    MerchandiseArr = [[dict objectForKey:@"data"] objectForKey:@"list"];
                    mallData = [[MallData alloc]initWithData:MerchandiseArr];
                    
                }
                else if (getDataType == 1) {
                    int index = 0;
                    for (NSDictionary *DI in [[dict objectForKey:@"data"] objectForKey:@"list"]) {
                        [MerchandiseArr insertObject:DI atIndex:index];
                        index++;
                    }
                    NSMutableArray *arr = [NSMutableArray arrayWithArray:MerchandiseArr];
                    for (int i = 0 ; i < arr.count - 1; i ++) {
                        for (int j = i + 1; j < arr.count; j ++) {
                            if ([[arr[i]  objectForKey:@"commodityID"] isEqualToString:[arr[j] objectForKey: @"commodityID"]])
                            {
                                [MerchandiseArr removeObjectAtIndex:j];
                            }
                            //                        NSLog(@"%@",[MerchandiseArr[i]  objectForKey:@"commodityID"]);
                        }
                    }
                    mallData = [[MallData alloc]initWithData:MerchandiseArr];
                }
                else if (getDataType == 2)
                {
                    [MerchandiseArr addObjectsFromArray:[[dict objectForKey:@"data"] objectForKey:@"list"]];
                    mallData = [[MallData alloc]initWithData:MerchandiseArr];
                }
                [self.mallCollectionView.header endRefreshing];
                [self.mallCollectionView.footer endRefreshing];
                NSLog(@"获取数据回调");
                
            }
            if (mallData.mallArr.count != 0) {
                FristId = [mallData.mallArr[0] commodityID];
                LastId = [mallData.mallArr[mallData.mallArr.count-1] commodityID];
            }
            [self.mallCollectionView reloadData];
        }
        else
        {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
      [MBProgressHUD hideHUDForView:self.view animated:YES];
}

#pragma mark 详情页面中 商品溯源点击按钮

- (IBAction)OriginOfGoods:(id)sender {
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"正在加载溯源查询信息."];
    [request getproductId:self.productId];
}

#pragma mark ------详情界面数据

- (void)loadDetail{
    self.prodetailView.layer.borderColor = [[UIColor blackColor] CGColor];
    self.prodetailView.layer.borderWidth = 0.5f;
    [self.bigImageView sd_setImageWithURL:[[[detailDic objectForKey:@"images"] objectAtIndex:0] objectForKey:@"smallImage"] placeholderImage:[UIImage imageNamed:@"banner_default_image"]];
    [self.smallImageView1 sd_setImageWithURL:[[[detailDic objectForKey:@"images"] objectAtIndex:0] objectForKey:@"bigImage"] placeholderImage:[UIImage imageNamed:@"banner_default_image"]];
    [self.smallImageView2 sd_setImageWithURL:[[[detailDic objectForKey:@"images"] objectAtIndex:0] objectForKey:@"bigImage"] placeholderImage:[UIImage imageNamed:@"banner_default_image"]];
    [self.smallImageView3 sd_setImageWithURL:[[[detailDic objectForKey:@"images"] objectAtIndex:0] objectForKey:@"bigImage"] placeholderImage:[UIImage imageNamed:@"banner_default_image"]];
    [self.smallImageView4 sd_setImageWithURL:[[[detailDic objectForKey:@"images"] objectAtIndex:0] objectForKey:@"bigImage"] placeholderImage:[UIImage imageNamed:@"banner_default_image"]];
    self.productName.text = [detailDic objectForKey:@"productName"];
    self.discount.text = [NSString stringWithFormat:@"促销价：%.2f", [[[[detailDic objectForKey:@"MODEL"] objectAtIndex:0] objectForKey:@"discount"] intValue]/100.0f];
    self.original.text = [NSString stringWithFormat:@"原价：%.2f", [[[[detailDic objectForKey:@"MODEL"] objectAtIndex:0] objectForKey:@"original"] intValue]/100.0f];
    self.inventory.text = [NSString stringWithFormat:@"库存量：%@", [[[detailDic objectForKey:@"MODEL"] objectAtIndex:0] objectForKey:@"inventory"]];
    
    self.express.text = [NSString stringWithFormat:@"快递方式：%@  %@  ",[[[detailDic objectForKey:@"express"] objectAtIndex:0] objectForKey:@"expressName"],[[[detailDic objectForKey:@"express"] objectAtIndex:0] objectForKey:@"areaName"]];
    
    
    
//    int width =0;
//    for (int i = 0; i < [[detailDic objectForKey:@"express"] count]; i++) {
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        [button setTitle:[[[detailDic objectForKey:@"express"] objectAtIndex:0] objectForKey:@"expressName"] forState:UIControlStateNormal];
//        
//        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
//        [button.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
//        CGSize size = [[[[detailDic objectForKey:@"express"] objectAtIndex:0] objectForKey:@"expressName"] boundingRectWithSize:CGSizeMake(MAXFLOAT, button.frame.size.height) options:NSStringDrawingTruncatesLastVisibleLine attributes:attribute context:nil].size;
//        button.frame = CGRectMake(self.express.frame.origin.x + self.express.frame.size.width +5 +width /1.0f  , self.express.frame.origin.y , size.width +10 , self.express.frame.size.height);
//        
//        width = button.frame.size.width;
//        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//        button.layer.borderWidth = 0.5;
//        button.layer.borderColor =[[UIColor redColor] CGColor];
//        button.layer.cornerRadius = 3.0f;
//        [self.prodetailView addSubview:button];
//        [buttonArray addObject:button];
//    }
    
    {
        int width = 0;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:[[[detailDic objectForKey:@"MODEL"] objectAtIndex:0] objectForKey:@"attribute2"] forState:UIControlStateNormal];
        
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
        [button.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
        CGSize size = [[[[detailDic objectForKey:@"MODEL"] objectAtIndex:0] objectForKey:@"attribute2"] boundingRectWithSize:CGSizeMake(MAXFLOAT, button.frame.size.height) options:NSStringDrawingTruncatesLastVisibleLine attributes:attribute context:nil].size;
        button.frame = CGRectMake(self.detailattribute.frame.origin.x + self.detailattribute.frame.size.width +5 +width /1.0f  , self.detailattribute.frame.origin.y , size.width +10 , self.detailattribute.frame.size.height);
        
        width = button.frame.size.width;
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        button.layer.borderWidth = 0.5;
        button.layer.borderColor =[[UIColor redColor] CGColor];
        button.layer.cornerRadius = 3.0f;
        [self.prodetailView addSubview:button];
        [buttonArray addObject:button];
    }
}

- (IBAction)tapAdd{
    prodetailNum++;
    self.detailNum.text =[NSString stringWithFormat:@"%i",prodetailNum];
}

- (IBAction)tapDelete{
    if (prodetailNum >1) {
        prodetailNum--;
    }else{
        prodetailNum = 1;
    }
    self.detailNum.text =[NSString stringWithFormat:@"%i",prodetailNum];
}


- (IBAction)callTelephone:(id)sender{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"4006787575"];
    //            NSLog(@"str======%@",str);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}


//购物车按钮
- (IBAction)shoppingCartAction:(id)sender {

    shopHint.hidden = YES;
    HintCount = 0;
    ShoppingCartViewController *shopVc = [self.storyboard instantiateViewControllerWithIdentifier:@"ShoppingCartViewController"];
    
    if (shopCartArr) {
            shopVc.CartArr = [NSMutableArray arrayWithArray:shopCartArr];
    }
    
    shopVc.mobileNo = mobileNO;
    
    if (shopVc.CartArr.count == 0) {
        [MBProgressHUD showHUDAddedTo:self.view WithString:@"你的购物车没有商品"];
    }
    else
    {
        shopVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:shopVc animated:YES];
    }
}
//编辑商城按钮事件
- (IBAction)EditMall:(id)sender {
    if ([mobileNO isEqualToString:[AppDelegate getUserBaseData].mobileNo]) {
//        self.navView.hidden = YES;
//        self.editNavView.hidden = NO;
        state = YES;
        [shopCartArr removeAllObjects];
        //初始化商品计数
        for (int i = 0; i < mallData.mallArr.count; i++) {
            [mallData.mallArr[i] setSum:@"1"];
        }
        HintCount = 0;
        shopHint.hidden = YES;
//        [self.mallCollectionView reloadData];
        EditMallViewController *editVC = [self.storyboard instantiateViewControllerWithIdentifier:@"EditMallViewController"];
        editVC.mallData = mallData;
        editVC.editMerchandiseArr = MerchandiseArr;
        [self.navigationController pushViewController:editVC animated:YES];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - collection

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    return mallData.mallArr.count;
    if (collectionView.tag == 60001) {
        return [productListArray count];
    }else if (collectionView.tag == 60002){
        return [productDicArray count];
    }
    return [productListArray count];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
     MallCollectionViewCell *cell = (MallCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    if (collectionView.tag == 60001) {
       
        if ([[[productListArray objectAtIndex:indexPath.row] objectForKey:@"image"] isKindOfClass:[NSString class]]) {
            [cell.MerchandiseImage  sd_setImageWithURL:[NSURL URLWithString:[[productListArray objectAtIndex:indexPath.row] objectForKey:@"image"]]];
            
            
        }
        if ([[[productListArray objectAtIndex:indexPath.row] objectForKey:@"name"] isKindOfClass:[NSString class]]) {
            cell.MerchandiseNameLbl.text = [[productListArray objectAtIndex:indexPath.row] objectForKey:@"name"];
            cell.MerchandiseNameLbl.textAlignment = 0;
            NSLog(@"%@",cell.MerchandiseNameLbl.text);
            
        }
        if ([[[productListArray objectAtIndex:indexPath.row]objectForKey:@"discount"]isKindOfClass:[NSString class]]) {
            cell.MerchandisePrice.text = [[productListArray objectAtIndex:indexPath.row]objectForKey:@"discount"];
            NSLog(@"%@",cell.MerchandisePrice.text);
        }
    }
    else if (collectionView.tag == 60002){
        
        cell.MerchandisePrice.hidden = _isMallCollection;

        MallCollectionViewCell *cell = (MallCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
        if ([[[productDicArray objectAtIndex:indexPath.row] objectForKey:@"image"] isKindOfClass:[NSString class]]) {
            [cell.MerchandiseImage  sd_setImageWithURL:[NSURL URLWithString:[[productDicArray objectAtIndex:indexPath.row] objectForKey:@"image"]]];
            
        }
        if ([[[productDicArray objectAtIndex:indexPath.row] objectForKey:@"name"] isKindOfClass:[NSString class]]) {
            cell.MerchandiseNameLbl.text = [[productDicArray objectAtIndex:indexPath.row] objectForKey:@"name"];
            cell.MerchandiseNameLbl.textAlignment = 0;
        }
        if ([[[productDicArray objectAtIndex:indexPath.row]objectForKey:@"discount"]isKindOfClass:[NSString class]]) {
            cell.MerchandisePrice.text = [[productDicArray objectAtIndex:indexPath.row]objectForKey:@"discount"];
        }
    }
    
    if (!mallData.mallArr || !mallData.mallArr.count) {
        return cell;
    }
    
    
    MallItem *dic = mallData.mallArr[indexPath.row];
    NSLog(@"%@",dic);
    cell.MerchandisePrice.text = [NSString stringWithFormat:@"¥%.2f",[dic.amount floatValue] *[dic.sum integerValue]/100.0f];
    [cell.MerchandiseImage sd_setImageWithURL:[NSURL URLWithString:dic.iconurl] placeholderImage:[UIImage imageNamed:@"tick"]];
    
    
//    cell.MerchandiseNameLbl.text = dic.title;
//    if (_isMall) {
//        _isMall = NO;
//        cell.MerchandisePrice.hidden = YES;
//    }else
//    {
//        cell.MerchandisePrice.hidden = NO;
//    }
    
    if (state == NO)
    {
        cell.deleteBtn.hidden = YES;
    }
    else if (state == YES)
    {
        cell.deleteBtn.hidden = NO;
    }
    return cell;
}

////根据机型改变cell大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    return CGSizeMake([UIScreen mainScreen].bounds.size.width/2-20, 210);
    CGFloat width =  CGRectGetWidth(collectionView.frame)/2.0f;
    CGFloat height = width*19/15;
    return CGSizeMake(width, height);
    
}

//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

//定义每个collectionCell 的边缘
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
//    return UIEdgeInsetsMake(5, 15, 15, 15);//上 左 下 右
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    indexRow = indexPath.row;
    
    
    if (collectionView.tag == 60001) {
        [self.mainView bringSubviewToFront:self.mallDetailView];
        for (id v in buttonArray) {
            if ([v isKindOfClass:[UIButton class]]) {
                [(UIButton *)v removeFromSuperview];
            }
        }
        [buttonArray removeAllObjects];
        prodetailNum = 1;
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"正在加载商品数据."];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"正在加载商品数据."];
        
        oneProductDic = [[NSDictionary alloc] initWithDictionary:[productListArray objectAtIndex:indexPath.row]];
        
        NSLog(@"%@",productListArray);
        
        
        [request getDetailInfoWithProductId:[[productListArray objectAtIndex:indexPath.row] objectForKey:@"productId"] withTraceabilityId:[[productListArray objectAtIndex:indexPath.row] objectForKey:@"traceability"]];

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }else if (collectionView.tag == 60002){
        
        for (id v in buttonArray) {
            if ([v isKindOfClass:[UIButton class]]) {
                [(UIButton *)v removeFromSuperview];
            }
        }
        [buttonArray removeAllObjects];
        prodetailNum = 1;

        [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"正在加载商品数据."];
        
//        self.mallCollectionView1.hidden = NO;
        if (_isMall) {
            _isMall = NO;
            [request getProductIdWithCardId:[[productDicArray objectAtIndex:indexPath.row] objectForKey:@"cateId"]];
            NSLog(@"%@",request);
//            [self.mainView bringSubviewToFront:self.mallCollectionView];


            
            [self.mainView bringSubviewToFront:self.mallCollectionView1];
        }else{
            
            [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"正在加载商品数据."];
            [request getDetailInfoWithProductId:[[productDicArray objectAtIndex:indexPath.row] objectForKey:@"productId"] withTraceabilityId:[[productDicArray objectAtIndex:indexPath.row] objectForKey:@"traceability"]];
            
            NSLog(@"%@  %@",productDicArray,productListArray);
            
            [self.mainView bringSubviewToFront:self.mallDetailView];
            
            
        }
//        [hud hide:YES afterDelay:1];
//        [MBProgressHUD hideHUDForView:self.view animated:YES];

    }
    
}

- (void)tongzhi:(NSNotification *)noti {
    NSLog(@"%@",noti);
    if ([noti.userInfo[@"ruquest"] isEqualToString:@"success"]) {
        _isMall = NO;
    }
}

//- (void)UesrClicked:(UIGestureRecognizer *)tap
//{
//    NSLog(@"21314215461");
//}



#pragma mark - searchBar

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (![SearchMall.text isEqualToString:mobileNO]) {
        mobileNO = SearchMall.text;
        mobileType = NO;
        editAction.highlighted = YES;
        editAction.userInteractionEnabled = NO;
    }
    if ([[AppDelegate getUserBaseData].mobileNo isEqualToString:mobileNO])
    {
        editAction.highlighted = NO;
        editAction.userInteractionEnabled = YES;
    }
    [shopCartArr removeAllObjects];
    seachingView.hidden = YES;
    [SearchMall resignFirstResponder];
    [self setUpCollection];
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    seachingView.hidden = NO;
}


#pragma mark - 正则判断
- (BOOL)matchStringFormat:(NSString *)matchedStr withRegex:(NSString *)regex
{
    //SELF MATCHES一定是大写
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    return [predicate evaluateWithObject:matchedStr];
}

#pragma mark - 获取订单是否完成协议
-(void)getOrderType:(BOOL)orderType
{
    mallOrderType = orderType;
    if (mallOrderType == YES)
    {
        [shopCartArr removeAllObjects];
        mallOrderType = NO;
        //订单完成后将数据模型里的商品计数全初始化为1，用于重新计数
        for (int i = 0; i < mallData.mallArr.count; i++) {
            [mallData.mallArr[i] setSum:@"1"];
        }
    }
    
}


-(void)getOrderFinish:(NSNotification*)n
{
    BOOL isFinish = [(NSString*)n.object boolValue];
    mallOrderType = isFinish;
    if (mallOrderType == YES)
    {
        [shopCartArr removeAllObjects];
        mallOrderType = NO;
        //订单完成后将数据模型里的商品计数全初始化为1，用于重新计数
        for (int i = 0; i < mallData.mallArr.count; i++) {
            [mallData.mallArr[i] setSum:@"1"];
        }
    }
    
}

#pragma table
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 50001) {
        
        if (indexPath.row == 0) {
            return 220;
        }else if (indexPath.row == 1){
            return 30;
        }else if (indexPath.row == 2){
            return 45;
        }else if (indexPath.row == 3){
            return 45;
        }else if (indexPath.row == 4){
            return 45;
        }else if (indexPath.row == 5){
            return 45;
        }else if (indexPath.row == 6){
            return 45;
        }
        else if (indexPath.row == 7){
            return 45;
        }else if (indexPath.row == 8){
            return 45;
        }else if (indexPath.row == 9){
            return 45;
        }else if (indexPath.row == 10){
            return 45;
        }else if (indexPath.row == 11){
            return 45;
        }else if (indexPath.row == 12){
            return 45;
        }else if (indexPath.row == 13){
            return 45;
        }else if (indexPath.row == 14){
            return 110;
        }
        else{
            return 45;
        }
        
        
    }else if (tableView.tag == 50002) {
        return 140;
    }
    else if (tableView.tag == 50003) {
        return 140;
    }
    else if (tableView.tag == 50004) {
        return 140;
    }
    //    else if (tableView.tag == 50005){
    //        if (indexPath.row == 0) {
    //            return 100;
    //        }else if (indexPath.row == 1){
    //            return 100;
    //        }else if (indexPath.row == 2){
    //            return 100;
    //        }else if (indexPath.row == 3){
    //            return 100;
    //        }else if (indexPath.row == 4){
    //            return 100;
    //        }else if (indexPath.row == 5){
    //            return 100;
    //        }else if (indexPath.row == 6){
    //            return 100;
    //        }
    //        else{
    //            return 110;
    //        }
    //    }
    else{
        return tableCellHeight;
    }
    return 45;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 50001) {
        
        return 15;
        
    }else if (tableView.tag == 50002) {
        return [shopCartArr count];
    }else if (tableView.tag == 50003) {
        return [shopCartArr count];
    }else if (tableView.tag == 50004) {
        return [orderListArray count];
    }
    //    else if (tableView.tag == 50005){
    //        return 7;
    //    }
    else{
        return [titleArray count];
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = @"cell";
    
    CGFloat width = CGRectGetWidth(self.view.frame);
    
    if (tableView.tag == 50001) {
        
        UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        //        switch (indexPath.section) {
        //            case 0:
        if (indexPath.row == 0) {
            //广告图
            NSArray *imageArrays = @[[UIImage imageNamed:@"banner1"],[UIImage imageNamed:@"banner2"]];
            
            SDCycleScrollView * sdcycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, width, 120) imagesGroup:imageArrays];
            sdcycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
            sdcycleScrollView.delegate = self;
            sdcycleScrollView.placeholderImage = [UIImage imageNamed:@"placeholder"];
            [cell addSubview:sdcycleScrollView];
            
            //百步商城
            UIButton *MastmallBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 125, 95, 95)];
            [MastmallBtn setImage:[UIImage imageNamed:@"Mast_mall"] forState:UIControlStateNormal];
            MastmallBtn.tag = 0;
            [MastmallBtn addTarget:self action:@selector(selectMastmallButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell  addSubview:MastmallBtn];
            
            //今日秒杀
            UIButton *TodaySpikeBtn = [[UIButton alloc]initWithFrame:CGRectMake(width/3+5, 125, 95, 95)];
            [TodaySpikeBtn setImage:[UIImage imageNamed:@"Today_spike"] forState:UIControlStateNormal];
            TodaySpikeBtn.tag = 1;
            [TodaySpikeBtn addTarget:self action:@selector(selectTodaySpikeButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:TodaySpikeBtn];
            
            //跨境电商
            UIButton *CrossBorderBtn = [[UIButton alloc]initWithFrame:CGRectMake(width/3*2, 125, 95, 95)];
            [CrossBorderBtn setImage:[UIImage imageNamed:@"Cross_border"] forState:UIControlStateNormal];
            CrossBorderBtn.tag = 2;
            [CrossBorderBtn addTarget:self action:@selector(CrossBorderButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:CrossBorderBtn];
            
            
            
            
            //
            //            UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            //            if(cell == nil){
            //                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            //            }
            
        }
        if (indexPath.row == 1) {
            
            UIImageView *iamgeView1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 120, 1)];
            iamgeView1.backgroundColor = [Common hexStringToColor:@"46a7ec"];
            [cell addSubview:iamgeView1];
            
            UILabel *lable1 = [[UILabel alloc]initWithFrame:CGRectMake(140, 10, 45, 20)];
            lable1.text = @"产品分类";
            lable1.font = [UIFont systemFontOfSize:11];
            lable1.textColor = [Common hexStringToColor:@"46a7ec"];
            //            lable1.textAlignment = UITextAlignmentCenter;
            [cell addSubview:lable1];
            
            UIImageView *iamgeView2 = [[UIImageView alloc]initWithFrame:CGRectMake(190, 20, 120, 1)];
            iamgeView2.backgroundColor = [Common hexStringToColor:@"46a7ec"];
            [cell addSubview:iamgeView2];
            
            
            
        }
        if (indexPath.row == 2) {
            UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, 145, 40)];
            [btn1 setBackgroundImage:[UIImage imageNamed:@"qianlan"] forState:UIControlStateNormal];
            [btn1 setTitle:@"粮油米面" forState:UIControlStateNormal];
            btn1.tag = 0;
            [btn1 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btn1];
            
            UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(width/2+5, 5, 145, 40)];
            [btn2 setBackgroundImage:[UIImage imageNamed:@"fenhong"] forState:UIControlStateNormal];
            [btn2 setTitle:@"酒水饮料" forState:UIControlStateNormal];
            btn2.tag = 1;
            [btn2 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btn2];
        }
        if (indexPath.row == 3) {
            UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, 145, 40)];
            [btn1 setBackgroundImage:[UIImage imageNamed:@"zonglan"] forState:UIControlStateNormal];
            [btn1 setTitle:@"家用电器" forState:UIControlStateNormal];
            btn1.tag = 2;
            [btn1 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btn1];
            
            UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(width/2+5, 5, 145, 40)];
            [btn2 setBackgroundImage:[UIImage imageNamed:@"qianlan"] forState:UIControlStateNormal];
            [btn2 setTitle:@"休闲食品" forState:UIControlStateNormal];
            btn2.tag = 3;
            [btn2 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btn2];
            
        }
        if (indexPath.row == 4) {
            UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, 145, 40)];
            [btn1 setBackgroundImage:[UIImage imageNamed:@"fenhong"] forState:UIControlStateNormal];
            [btn1 setTitle:@"品牌男装" forState:UIControlStateNormal];
            btn1.tag = 2;
            [btn1 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btn1];
            
            UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(width/2+5, 5, 145, 40)];
            [btn2 setBackgroundImage:[UIImage imageNamed:@"qianlv"] forState:UIControlStateNormal];
            [btn2 setTitle:@"内衣配饰" forState:UIControlStateNormal];
            btn2.tag = 3;
            [btn2 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btn2];
        }if (indexPath.row == 5) {
            UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, 145, 40)];
            [btn1 setBackgroundImage:[UIImage imageNamed:@"qianlan"] forState:UIControlStateNormal];
            [btn1 setTitle:@"电脑办公" forState:UIControlStateNormal];
            btn1.tag = 2;
            [btn1 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btn1];
            
            UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(width/2+5, 5, 145, 40)];
            [btn2 setBackgroundImage:[UIImage imageNamed:@"fenhong"] forState:UIControlStateNormal];
            [btn2 setTitle:@"个护化妆" forState:UIControlStateNormal];
            btn2.tag = 3;
            [btn2 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btn2];
        }if (indexPath.row == 6) {
            UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, 145, 40)];
            [btn1 setBackgroundImage:[UIImage imageNamed:@"zonglan"] forState:UIControlStateNormal];
            [btn1 setTitle:@"母婴频道" forState:UIControlStateNormal];
            btn1.tag = 2;
            [btn1 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btn1];
            
            UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(width/2+5, 5, 145, 40)];
            [btn2 setBackgroundImage:[UIImage imageNamed:@"qianlan"] forState:UIControlStateNormal];
            [btn2 setTitle:@"家居家纺" forState:UIControlStateNormal];
            btn2.tag = 3;
            [btn2 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btn2];
        }if (indexPath.row == 7) {
            UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, 145, 40)];
            [btn1 setBackgroundImage:[UIImage imageNamed:@"fenhong"] forState:UIControlStateNormal];
            [btn1 setTitle:@"整车车品" forState:UIControlStateNormal];
            btn1.tag = 2;
            [btn1 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btn1];
            
            UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(width/2+5, 5, 145, 40)];
            [btn2 setBackgroundImage:[UIImage imageNamed:@"qianlan"] forState:UIControlStateNormal];
            [btn2 setTitle:@"音像制品" forState:UIControlStateNormal];
            btn2.tag = 3;
            [btn2 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btn2];
        }if (indexPath.row == 8) {
            UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, 145, 40)];
            [btn1 setBackgroundImage:[UIImage imageNamed:@"zonglan"] forState:UIControlStateNormal];
            [btn1 setTitle:@"营养保健" forState:UIControlStateNormal];
            btn1.tag = 2;
            [btn1 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btn1];
            
            UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(width/2+5, 5, 145, 40)];
            [btn2 setBackgroundImage:[UIImage imageNamed:@"qianlan"] forState:UIControlStateNormal];
            [btn2 setTitle:@"活动" forState:UIControlStateNormal];
            btn2.tag = 3;
            [btn2 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btn2];
        }if (indexPath.row == 9) {
            UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, 145, 40)];
            [btn1 setBackgroundImage:[UIImage imageNamed:@"fenhong"] forState:UIControlStateNormal];
            [btn1 setTitle:@"农资" forState:UIControlStateNormal];
            btn1.tag = 2;
            [btn1 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btn1];
            
            UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(width/2+5, 5, 145, 40)];
            [btn2 setBackgroundImage:[UIImage imageNamed:@"zonglan"] forState:UIControlStateNormal];
            [btn2 setTitle:@"农产品" forState:UIControlStateNormal];
            btn2.tag = 3;
            [btn2 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btn2];
        }if (indexPath.row == 10) {
            UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, 145, 40)];
            [btn1 setBackgroundImage:[UIImage imageNamed:@"qianlan"] forState:UIControlStateNormal];
            [btn1 setTitle:@"农机具" forState:UIControlStateNormal];
            btn1.tag = 2;
            [btn1 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btn1];
            
            UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(width/2+5, 5, 145, 40)];
            [btn2 setBackgroundImage:[UIImage imageNamed:@"qianlv"] forState:UIControlStateNormal];
            [btn2 setTitle:@"大礼包" forState:UIControlStateNormal];
            btn2.tag = 3;
            [btn2 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btn2];
        }if (indexPath.row == 11) {
            UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, 145, 40)];
            [btn1 setBackgroundImage:[UIImage imageNamed:@"zonglan"] forState:UIControlStateNormal];
            [btn1 setTitle:@"中农书店" forState:UIControlStateNormal];
            btn1.tag = 2;
            [btn1 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btn1];
            
            UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(width/2+5, 5, 145, 40)];
            [btn2 setBackgroundImage:[UIImage imageNamed:@"qianlan"] forState:UIControlStateNormal];
            [btn2 setTitle:@"中农信合健康商城" forState:UIControlStateNormal];
            btn2.titleLabel.adjustsFontSizeToFitWidth = YES;
            btn2.tag = 3;
            [btn2 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btn2];
        }if (indexPath.row == 12) {
            UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, 145, 40)];
            [btn1 setBackgroundImage:[UIImage imageNamed:@"zonglan"] forState:UIControlStateNormal];
            [btn1 setTitle:@"文教用品" forState:UIControlStateNormal];
            btn1.tag = 2;
            [btn1 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btn1];
            
            UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(width/2+5, 5, 145, 40)];
            [btn2 setBackgroundImage:[UIImage imageNamed:@"qianlv"] forState:UIControlStateNormal];
            [btn2 setTitle:@"厨具" forState:UIControlStateNormal];
            btn2.tag = 3;
            [btn2 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btn2];
        }
        
        //                if (indexPath.row == 12) {
        //
        //                    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, 145, 40)];
        //                    [btn1 setBackgroundImage:[UIImage imageNamed:@"zonghong"] forState:UIControlStateNormal];
        //                    [btn1 setTitle:@"超市" forState:UIControlStateNormal];
        //                    btn1.tag = 18;
        //                    [btn1 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
        //                    [cell.contentView addSubview:btn1];
        //
        //                }
        
        
        
        
        //        cell.textLabel.text = [NSString stringWithFormat:@"%i、%@", [indexPath row]+1,[[titleArray objectAtIndex:indexPath.row] objectForKey:@"cateName"]];
        //
        //        if (indexPath.row % 2 ==0 ) {
        //            cell.backgroundColor = [UIColor colorWithRed:210/255.0f green:210/255.0f blue:210/255.0f alpha:1.0f];
        //        }else{
        //            cell.backgroundColor = [UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1.0f];
        //        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        //
        
    }
    else if (tableView.tag == 50002) {
        ShopCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopCartTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        MallItem *item = shopCartArr[indexPath.row];
        cell.indexLabel.text = [NSString stringWithFormat:@"%li、",[indexPath row] + 1];
        
        [cell.actor sd_setImageWithURL:[NSURL URLWithString:item.iconurl] placeholderImage:[UIImage imageNamed:@"banner_default_image"]];
        cell.name.text = item.title;
        cell.price2.text =[NSString stringWithFormat:@"%.2f", [item.price floatValue]/100.0f];
        cell.num.text = [NSString stringWithFormat:@"%ld",[item.sum integerValue]];
        cell.totalprice.text = [NSString stringWithFormat:@"%.2f",[item.price floatValue] *[item.sum integerValue]/100.0f];
        return cell;
    }
    else if (tableView.tag == 50003) {
        ShopCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopCartTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        MallItem *item = shopCartArr[indexPath.row];
        cell.indexLabel.text = [NSString stringWithFormat:@"%li、",[indexPath row] + 1];
        
        [cell.actor sd_setImageWithURL:[NSURL URLWithString:item.iconurl] placeholderImage:[UIImage imageNamed:@"banner_default_image"]];
        cell.name.text = item.title;
        cell.price2.text =[NSString stringWithFormat:@"%.2f", [item.price floatValue]/100.0f];
        cell.num.text = [NSString stringWithFormat:@"%ld",[item.sum integerValue]];
        cell.totalprice.text = [NSString stringWithFormat:@"%.2f",[item.price floatValue] *[item.sum integerValue]/100.0f];
        return cell;
    }
    else if (tableView.tag == 50004) {
        ShopCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopCartTableViewCell" forIndexPath:indexPath];
        cell.indexLabel.text = [NSString stringWithFormat:@"%li、",[indexPath row] + 1];
        NSDictionary *mallOrders = [[[[[orderListArray objectAtIndex:indexPath.row] objectForKey:@"mallOrders"] objectAtIndex:0] objectForKey:@"mallOrderItem"] objectAtIndex:0];
        [cell.actor sd_setImageWithURL:[NSURL URLWithString:[mallOrders objectForKey:@"productImage"]] placeholderImage:[UIImage imageNamed:@"banner_default_image"]];
        cell.name.text = [mallOrders objectForKey:@"productName"];
        cell.price2.text =[NSString stringWithFormat:@"%.2f", [[mallOrders objectForKey:@"price"] floatValue]];
        cell.num.text = [NSString stringWithFormat:@"%ld",[[mallOrders objectForKey:@"num"] integerValue]];
        cell.totalprice.text = [[[[orderListArray objectAtIndex:indexPath.row] objectForKey:@"mallOrders"] objectAtIndex:0] objectForKey:@"amount"];
        if (indexPath.row % 2 ==0 ) {
            cell.backgroundColor = [UIColor colorWithRed:210/255.0f green:210/255.0f blue:210/255.0f alpha:1.0f];
        }else{
            cell.backgroundColor = [UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1.0f];
        }
        
        return cell;
    }
    //    else if (tableView.tag == 50005){//产品分类
    //
    //        NSString *CellIdentifier1 = @"cell";
    //
    //        UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
    //        if(cell == nil){
    //            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
    //        }
    //        if (indexPath.row == 0) {
    //            UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 120, 120)];
    //            [btn1 setBackgroundImage:[UIImage imageNamed:@"qianlan"] forState:UIControlStateNormal];
    //            [btn1 setTitle:@"粮油米面" forState:UIControlStateNormal];
    //            btn1.tag = 0;
    //            [btn1 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    //            [cell.contentView addSubview:btn1];
    //
    //            UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(width/2+5, 10, 120, 120)];
    //            [btn2 setBackgroundImage:[UIImage imageNamed:@"fenhong"] forState:UIControlStateNormal];
    //            [btn2 setTitle:@"健身器材" forState:UIControlStateNormal];
    //            btn2.tag = 1;
    //            [btn2 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    //            [cell addSubview:btn2];
    //        }
    //        if (indexPath.row == 1) {
    //            UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 45, 120, 120)];
    //            [btn1 setBackgroundImage:[UIImage imageNamed:@"zonglan"] forState:UIControlStateNormal];
    //            [btn1 setTitle:@"家用电器" forState:UIControlStateNormal];
    //            btn1.tag = 2;
    //            [btn1 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    //            [cell.contentView addSubview:btn1];
    //
    //            UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(width/2+5, 45, 120, 120)];
    //            [btn2 setBackgroundImage:[UIImage imageNamed:@"qianlv"] forState:UIControlStateNormal];
    //            [btn2 setTitle:@"商城测试" forState:UIControlStateNormal];
    //            btn2.tag = 3;
    //            [btn2 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    //            [cell addSubview:btn2];
    //
    //        }
    
    //               cell.textLabel.text = [NSString stringWithFormat:@"%i、%@", [indexPath row]+1,[[titleArray objectAtIndex:indexPath.row] objectForKey:@"cateName"]];
    //
    //        if (indexPath.row % 2 ==0 ) {
    //            cell.backgroundColor = [UIColor colorWithRed:210/255.0f green:210/255.0f blue:210/255.0f alpha:1.0f];
    //        }else{
    //            cell.backgroundColor = [UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1.0f];
    //        }
    //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //        return cell;
    //        //
    //
    //
    //    }
    else{
        UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.textLabel.text=[titleArray objectAtIndex:indexPath.row];
        if (indexPath.row % 2 ==0 ) {
            cell.backgroundColor = [UIColor colorWithRed:210/255.0f green:210/255.0f blue:210/255.0f alpha:1.0f];
        }else{
            cell.backgroundColor = [UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1.0f];
        }
        return cell;
        
        
    }
}

//百步商城点击Btn
-(void)selectMastmallButton:(UIButton *)Btn
{
    self.mallCollectionView1.hidden = NO;
    _isMall = YES;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"正在加载商品数据."];
    
    refeshcardId = [[titleArray objectAtIndex:Btn.tag] objectForKey:@"cateId"];
    
    [request getMastmallProductWithCardId:[[titleArray objectAtIndex:Btn.tag]objectForKey:@"cateId"]];
    self.segview2.hidden = YES;
    self.shopCateView.hidden = YES;
    [self.mallCollectionView1 reloadData];
    [self.mainView bringSubviewToFront:self.shoplist2];
    
    _segmentedCtrl.selectedSegmentIndex = 0;
    
}

//今日秒杀点击Btn
- (void)selectTodaySpikeButton:(UIButton *)Btn
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"正在加载商品数据."];

    refeshcardId = [[titleArray objectAtIndex:Btn.tag] objectForKey:@"cateId"];
    [request getTodyKillProductWithCardId:[[titleArray objectAtIndex:Btn.tag] objectForKey:@"cateId"]];


    NSLog(@"%@-----------------------------++++++++++++",request);

    self.shopCateView.hidden = YES;
    
    self.segview2.hidden = YES;
    [self.mainView bringSubviewToFront:self.shoplist1];
    
}

//跨境电商点击Btn
- (void)CrossBorderButton:(UIButton *)Btn
{
    
    
//    [Common showMsgBox:nil msg:@"查询商品不存在" parentCtrl:self];
    
    self.mallCollectionView1.hidden = NO;
    _isMall = YES;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"正在加载商品数据."];
    refeshcardId = [[titleArray objectAtIndex:Btn.tag] objectForKey:@"cateId"];
    
    [request getCrossBorderProductWithCardId:[[titleArray objectAtIndex:Btn.tag]objectForKey:@"cateId"]];
    NSLog(@"%@++++++",request);
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
    self.segview2.hidden = YES;
    self.shopCateView.hidden = YES;
    [self.mainView bringSubviewToFront:self.shoplist2];
    _segmentedCtrl.selectedSegmentIndex = 0;
    
    self.mallCollectionView1.hidden = NO;
    _isMall = YES;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"正在加载商品数据."];
    
    refeshcardId = [[titleArray objectAtIndex:Btn.tag] objectForKey:@"cateId"];
    
    [request getCrossBorderProductWithCardId:[[titleArray objectAtIndex:Btn.tag]objectForKey:@"cateId"]];
//    [request getMastmallProductWithCardId:[[titleArray objectAtIndex:Btn.tag]objectForKey:@"cateId"]];
    self.segview2.hidden = YES;
    self.shopCateView.hidden = YES;
    [self.mallCollectionView1 reloadData];
    [self.mainView bringSubviewToFront:self.shoplist2];
    
    _segmentedCtrl.selectedSegmentIndex = 0;
    
}

- (void)selectButton:(UIButton *)btn{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"正在加载商品数据."];
    refeshcardId = [[titleArray objectAtIndex:btn.tag] objectForKey:@"cateId"];
    [request getProductWithCardId:[[titleArray objectAtIndex:btn.tag] objectForKey:@"cateId"]];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    self.segview2.hidden = YES;
    self.shopCateView.hidden = YES;
    [self.mainView bringSubviewToFront:self.shoplist1];
}

- (void)clickButton:(UIButton *)btn
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"正在加载商品数据."];
    refeshcardId = [[titleArray objectAtIndex:btn.tag] objectForKey:@"cateId"];
    [request getProductWithCardId:[[titleArray objectAtIndex:btn.tag] objectForKey:@"cateId"]];
    self.segview2.hidden = YES;
    self.shopCateView.hidden = YES;
    [self.mallCollectionView reloadData];
    [self.mainView bringSubviewToFront:self.shoplist1];
    
}


//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (tableView.tag == 50001) {
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"正在加载商品数据."];
//        [hud hide:YES afterDelay:1];
//        refeshcardId = [[titleArray objectAtIndex:indexPath.row] objectForKey:@"cateId"];
//        [request getProductWithCardId:[[titleArray objectAtIndex:indexPath.row] objectForKey:@"cateId"]];
//        self.segview2.hidden = YES;
//        [self.mainView bringSubviewToFront:self.shoplist1];
//       
//    }
//}



- (IBAction)seg1tap:(id)sender{
    [self.mainView bringSubviewToFront:self.shoplist1];
    if (!mallData.mallArr.count) {
        [self setUpCollection];
    }
    else
    {
        [self.mallCollectionView.header endRefreshing];
    }

    UIButton *button = (UIButton*)sender;
    switch (button.tag) {
        case 201:
        {
            
        }
            break;
        case 202:
        {
            
        }
            break;
        case 203:
        {
            
        }
            break;
        case 204:
        {
            
        }
            break;
        case 205:
        {
            
        }
            break;
        case 206:
        {
            
        }
            break;
        case 207:
        {
            
        }
            break;
        case 208:
        {
            
        }
            break;
        case 209:
        {
            
        }
            break;
        
        default:
            break;
    }
}
- (IBAction)saveHistroyAddress:(UIButton *)sender {
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
