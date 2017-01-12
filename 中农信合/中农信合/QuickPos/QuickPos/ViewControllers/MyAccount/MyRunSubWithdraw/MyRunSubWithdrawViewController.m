//
//  MyRunSubWithdrawViewController.m
//  QuickPos
//
//  Created by 张倡榕 on 15/3/6.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "MyRunSubWithdrawViewController.h"
#import "MBProgressHUD+Add.h"
#import "Request.h"
#import "BankCardData.h"
#import "CreditCardPayDetailViewController.h"
#import "UIImage+wiRoundedRectImage.h"
#import "Common.h"
#import "PayType.h"
#import "ROllLabel.h"
#import "AddCreditCardViewController.h"
#import "UserInfo.h"
#import "TakeCashViewController.h"
#import "BankcardTableViewCell.h"
#import "AddBankcardCell.h"
#import "AddRunSubBankcardViewController.h"
#import "MyRunSubTakeCashViewController.h"

#import "TakeCashViewController.h"


@interface MyRunSubWithdrawViewController ()<UITableViewDataSource,UITableViewDelegate,ResponseData>{
    
    NSDictionary *dataDic;//请求返回字典
    
    NSString *newCardNumber;//截取卡号后的赋值
    
    BankCardData *bankCardData;//类为属性
    
    NSString *cardNumber;//传值用-卡号
    
    NSString *cardIdx;//传值用-卡索引
    
    Request *requst;
    
    NSIndexPath *indexpath;//indexpath索引
    
    int Viewtype ;//复用页面标示 1=提现，2=转账。
    
}

@property (weak, nonatomic) IBOutlet UITableView *MySunWithdrawTableView;
@property(nonatomic,strong)NSMutableArray *bankArr;
@property(nonatomic,strong)NSMutableArray *bankNumArr;
@property(nonatomic,strong)NSMutableArray *bankTypeArr;

@property (nonatomic, strong) UIImageView *noBankCark;//没有银行卡的图片
@property (nonatomic, strong) UILabel *noBankCarktip;//没有银行卡的提示
@end

@implementation MyRunSubWithdrawViewController
@synthesize name;
@synthesize destinationType;
@synthesize Notes;
@synthesize item;

- (UIImageView *)noBankCark{
    if (!_noBankCark) {
        _noBankCark = [[UIImageView alloc]initWithFrame:CGRectZero];
        _noBankCark.image = [UIImage imageNamed:@"bankcard_card"];
    }
    return _noBankCark;
}

- (UILabel *)noBankCarktip{
    if (!_noBankCarktip) {
        _noBankCarktip = [[UILabel alloc]initWithFrame:CGRectZero];
        _noBankCarktip.text = @"请点击右上角添加银行卡";
        _noBankCarktip.textColor = [UIColor redColor];
        _noBankCarktip.font = [UIFont systemFontOfSize:13];
        _noBankCarktip.textAlignment = NSTextAlignmentCenter;;
    }
    return _noBankCarktip;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self creatRightBtn];
    
    [self chooseType];
    
    
    //    if (!item) {
    //
    //        Notes.text = L(@"Transfer");
    //
    //    }
    
    //        Notes.hidden = NO;
    
    
    //没有绑定过银行卡时添加提示
    [self.view addSubview:self.noBankCark];
    [self.view addSubview:self.noBankCarktip];
    self.noBankCark.frame = CGRectMake(CGRectGetWidth(self.view.frame)/2 - 45, 200, 85, 55);
    self.noBankCarktip.frame = CGRectMake(0, 255, CGRectGetWidth(self.view.frame), 55);
    
    
    
    
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [Common hexStringToColor:@"eeeeee"];
    self.MySunWithdrawTableView.backgroundColor = [Common hexStringToColor:@"eeeeee"];
    self.MySunWithdrawTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    requst = [[Request alloc]initWithDelegate:self];
    [requst userInfo:[AppDelegate getUserBaseData].mobileNo];
    
    
    
}

- (void)chooseType
{
 
        self.navigationItem.title = @"我的分润";
        //        Notes.hidden = YES;
        
        //没有绑定过银行卡时添加提示
        [self.view addSubview:self.noBankCark];
        [self.view addSubview:self.noBankCarktip];
        self.noBankCark.frame = CGRectMake(CGRectGetWidth(self.view.frame)/2 - 45, 200, 85, 55);
        self.noBankCarktip.frame = CGRectMake(0, 255, CGRectGetWidth(self.view.frame), 55);
    
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
   
    [requst bankListAndbindType:@"01"];
   
    [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"加载中,请稍后."];
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:L(@"MBPLoading")];
//    
//    [hud hide:YES afterDelay:1];
}

- (void)creatRightBtn
{
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightBtn setImage:[UIImage imageNamed:@"serve_more"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(addBankCard:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    //    [rightBtn release];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)addBankCard:(UIButton *)sender {
    
    AddRunSubBankcardViewController *AddRunSubBankcardVc = [self.storyboard instantiateViewControllerWithIdentifier:@"AddRunSubBankcardVc"];
    
    AddRunSubBankcardVc.hidesBottomBarWhenPushed = YES;
    AddRunSubBankcardVc.name = name;
    AddRunSubBankcardVc.destinationType = self.destinationType;
    
    [self.navigationController pushViewController:AddRunSubBankcardVc animated:YES];
}


- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    
    //有数据返回
    if ([dict[@"respCode"]isEqualToString:@"0000"]) {
    
        
        
        //    if ([dict[@"respCode"]isEqualToString:@"0000"]) {
        if (type == REQUSET_USERINFOQUERY) {
            name = [[[dict objectForKey:@"data"] objectForKey:@"resultBean"] objectForKey:@"customerName"];
            
        }
        
        if(type == REQUSET_BANKLIST){
            
            if ([[[dict objectForKey:@"data"] objectForKey:@"resultBean"] count] >0) {
                self.noBankCark.hidden = YES;
                self.noBankCarktip.hidden = YES;
            }else
            {
                self.noBankCark.hidden = NO;
                self.noBankCarktip.hidden = NO;
            }
            bankCardData = [[BankCardData alloc]initWithData:dict];
            [self.MySunWithdrawTableView reloadData];
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }else if(type == REQUSET_BankCardUnBind){
            
            [bankCardData.bankCardArr removeObjectAtIndex:indexpath.row];
            
            [self.MySunWithdrawTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexpath] withRowAnimation:UITableViewRowAnimationAutomatic];
            
            [self.MySunWithdrawTableView reloadData];
        }
        
    }else{
        
        [Common showMsgBox:nil msg:[dict objectForKey:@"respDesc"] parentCtrl:self];
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return bankCardData.bankCardArr.count > 0 ? bankCardData.bankCardArr.count:0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *bankcardCellCellIdentifier = @"BankcardTableViewCell";
    
    BankcardTableViewCell *bankcardCell = (BankcardTableViewCell *) [tableView dequeueReusableCellWithIdentifier:bankcardCellCellIdentifier];
    
    if (!bankcardCell) {
        bankcardCell = [[BankcardTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:bankcardCellCellIdentifier];
    }
    
    BankCardItem *bcItem = [bankCardData.bankCardArr objectAtIndex:indexPath.row];
    
    bankcardCell.bankNameLabel.text = bcItem.bankName;
    bankcardCell.cardTypeLabel.text = bcItem.remark;
    bankcardCell.cardNumberLabel.text = [Common bankCardNumSecret:bcItem.accountNo];
    
    bankcardCell.bankLogoImageView.layer.masksToBounds = YES;
    bankcardCell.bankLogoImageView.layer.cornerRadius = 20;
    [bankcardCell.bankLogoImageView sd_setImageWithURL:[NSURL URLWithString:bcItem.iconUrl]];
    bankcardCell.cellBG.layer.masksToBounds = YES;
    bankcardCell.cellBG.layer.cornerRadius = 1;
    
    if (indexPath.row%2 == 0) {
        
        //        bankcardCell.cellBG.backgroundColor = [Common hexStringToColor:@"#e0d5a9"];
        bankcardCell.cellBG.backgroundColor = [UIColor clearColor];
    }
    //    else{
    //        bankcardCell.cellBG.backgroundColor = [Common hexStringToColor:@"#bb5f5f"];
    //
    //    }
    
    return bankcardCell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BankCardItem *bcItem = [bankCardData.bankCardArr objectAtIndex:indexPath.row];
    
    cardNumber = bcItem.accountNo;
    cardIdx = bcItem.cardIdx;
    
    MyRunSubTakeCashViewController *MyRunSubTakeCashVc = [self.storyboard instantiateViewControllerWithIdentifier:@"MyRunSubTakeCashVc"];
    
    MyRunSubTakeCashVc.cardNumber = cardNumber;
    MyRunSubTakeCashVc.cardIdx = cardIdx;
    
    
    
    
    [self.navigationController pushViewController:MyRunSubTakeCashVc animated:YES];
    
    
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        indexpath = indexPath;
        
        BankCardItem *bcItem = [bankCardData.bankCardArr objectAtIndex:indexPath.row];
        
        cardNumber = bcItem.accountNo;
        cardIdx = bcItem.cardIdx;
        
        //        [self.arrayValue removeObjectAtIndex:[indexPath row]];  //删除数组里的数据
        //        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];  //删除对应数据的cell
        [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"请稍后"];
        [requst BankCardUnBind:cardIdx];
    }
    
}



@end
