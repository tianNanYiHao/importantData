//
//  CreditCardPayViewController.m
//  QuickPos
//
//  Created by 张倡榕 on 15/3/6.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "CreditCardPayViewController.h"
#import "MBProgressHUD+Add.h"
#import "Request.h"
#import "BankCardData.h"
#import "CreditCardPayDetailViewController.h"
#import "UIImage+wiRoundedRectImage.h"
#import "Common.h"
#import "AddBankcardViewController.h"
#import "PayType.h"
#import "ROllLabel.h"
#import "AddCreditCardViewController.h"
#import "UserInfo.h"

@interface CreditCardPayViewController ()<UITableViewDataSource,UITableViewDelegate,ResponseData>{
    BankCardData *bankData;
    BankCardItem *bankItem;
    NSIndexPath *indexpath;
    MBProgressHUD *hud;

}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *bankArr;
@property(nonatomic,strong)NSMutableArray *bankNumArr;
@property(nonatomic,strong)NSMutableArray *bankTypeArr;

@property (nonatomic, strong) UIImageView *noBankCark;//没有银行卡的图片
@property (nonatomic, strong) UILabel *noBankCarktip;//没有银行卡的提示
@end

@implementation CreditCardPayViewController
@synthesize name;
@synthesize destinationType;
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
        _noBankCarktip.text = @"请点击右上角绑定要还款的信用卡";
        _noBankCarktip.font = [UIFont systemFontOfSize:13];
        _noBankCarktip.textColor = [UIColor redColor];
        _noBankCarktip.textAlignment = NSTextAlignmentCenter;;
    }
    return _noBankCarktip;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"信用卡还款";
//    self.view.backgroundColor = [UIColor whiteColor];
    
//    if (!self.item) {
//        self.notes.text = @"信用卡还款";
//    }
//    [ROllLabel rollLabelTitle:[self.item objectForKey:@"announce"] color:[UIColor whiteColor] backgroundColor:[UIColor clearColor] font:[UIFont systemFontOfSize:17.0] superView:self.notes fram:CGRectMake(0, 0, self.notes.frame.size.width, self.notes.frame.size.height)];
//    
//    
//    self.navigationItem.title = [self.item objectForKey:@"title"];

    // Do any additional setup after loading the view.
//    self.bankArr = [NSMutableArray arrayWithObjects:@"招商银行",@"招商银行",@"招商银行",nil];
//    self.bankNumArr = [NSMutableArray arrayWithObjects:@"7372139194312943",@"3124432112444",@"3412421441243",nil];
//    self.bankTypeArr = [NSMutableArray arrayWithObjects:@"信用卡",@"信用卡",@"信用卡",nil];
//    Request *req = [[Request alloc]initWithDelegate:self];
//    for (BankCardItem *item in bankData.bankCardArr) {
//        
//    }
    self.view.backgroundColor = [Common hexStringToColor:@"eeeeee"];
    self.tableView.backgroundColor = [Common hexStringToColor:@"eeeeee"];
    
    //没有绑定过银行卡时添加提示
    [self.view addSubview:self.noBankCark];
    [self.view addSubview:self.noBankCarktip];
    self.noBankCark.frame = CGRectMake(CGRectGetWidth(self.view.frame)/2 - 45, 200, 85, 55);
    self.noBankCarktip.frame = CGRectMake(0, 255, CGRectGetWidth(self.view.frame), 55);
    //导航栏右边按钮
    UIButton *addbank = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [addbank setImage:[UIImage imageNamed:@"serve_more"] forState:UIControlStateNormal];
    
    [addbank addTarget:self action:@selector(addBankCard:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:addbank];

}

//添加新的信用卡
- (void)addBankCard:(UIButton *)sender {
    
    AddCreditCardViewController *addBankcardVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AddCreditCardVC"];
    
    addBankcardVC.hidesBottomBarWhenPushed = YES;
    addBankcardVC.name = name;
    addBankcardVC.destinationType = self.destinationType;
    
    [self.navigationController pushViewController:addBankcardVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    hud = [MBProgressHUD showMessag:@"正在加载列表。。" toView:self.view];
    Request *req = [[Request alloc]initWithDelegate:self];
    [req bankListAndbindType:@"04"];

}

#pragma mark - TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return bankData.bankCardArr.count>0? bankData.bankCardArr.count:0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BankCardItem *bankCardItem = [bankData.bankCardArr objectAtIndex:indexPath.row];
    
    static NSString *cellIdentifier = @"CreditCardCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    UIView *view = (UIView*)[cell.contentView viewWithTag:5];
    if (indexPath.row%2 == 0) {
        
        view.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:169/255.0 alpha:1.0];
    }else{
        view.backgroundColor = [UIColor colorWithRed:187/255.0 green:95/255.0 blue:95/255.0 alpha:1.0];

    }
    UIImageView *iconImg = (UIImageView*)[cell.contentView viewWithTag:1];
    iconImg.layer.masksToBounds = YES;
    iconImg.layer.cornerRadius = 10.0;
    [iconImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",bankCardItem.iconUrl]]];
//    [(SDImag*)[cell.contentView viewWithTag:1] setImage:[UIImage im];
    [(UILabel*)[cell.contentView viewWithTag:2] setText:bankCardItem.bankName];//银行名称
//    [(UILabel*)[cell.contentView viewWithTag:3] setText:self.bankTypeArr[indexPath.row]];
    [(UILabel*)[cell.contentView viewWithTag:4] setText:[Common bankCardNumSecret:bankCardItem.accountNo]];//银行卡账号
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 135.0;
}

#pragma mark - TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    
    CreditCardPayDetailViewController *creditCardDetailVc = [mainStoryboard instantiateViewControllerWithIdentifier:@"CreditCardPayDetailViewController"];
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    bankItem = bankData.bankCardArr[indexPath.row];
    
    creditCardDetailVc.BeneficiaryAccount = bankItem.accountNo;
    creditCardDetailVc.BeneficiaryPhoneField = bankItem.remark;
    creditCardDetailVc.BeneficiaryName = [AppDelegate getUserBaseData].userName;
    NSLog(@"%@  %@  %@",creditCardDetailVc.BeneficiaryAccount,creditCardDetailVc.BeneficiaryName,creditCardDetailVc.BeneficiaryPhoneField);
    
    [self.navigationController pushViewController:creditCardDetailVc animated:YES];
//    [self performSegueWithIdentifier:@"CreditPayDetailSegue" sender:cell];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        indexpath = indexPath;
        bankItem = bankData.bankCardArr[indexPath.row];
        //        [self.arrayValue removeObjectAtIndex:[indexPath row]];  //删除数组里的数据
        //        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];  //删除对应数据的cell
        [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"请稍后"];
        Request *req = [[Request alloc]initWithDelegate:self];
        [req BankCardUnBind:bankItem.cardIdx];
    }
    
}



- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if([identifier isEqualToString:@"AddCreditCardSegue"]){
        return YES;
    }else{
        return NO;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"CreditPayDetailSegue"]) {
        [(CreditCardPayDetailViewController*)segue.destinationViewController setBankCardItem:bankItem];
    }else if ([segue.identifier isEqualToString:@"AddCreditCardSegue"]) {
        [(AddBankcardViewController*)segue.destinationViewController setDestinationType:CREDIT];
    }
    

}


//添加新的信用卡
- (IBAction)addNewCreditCard:(UIButton *)sender {
}


- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    
    //有数据返回
    
    
    
    [hud hide:YES];
    if ([[dict objectForKey:@"respCode"]isEqualToString:@"0000"]){
        if (type == REQUSET_BANKLIST) {
            
            if ([[[dict objectForKey:@"data"] objectForKey:@"resultBean"] count] >0) {
                self.noBankCark.hidden = YES;
                self.noBankCarktip.hidden = YES;
            }else{
                self.noBankCark.hidden = NO;
                self.noBankCarktip.hidden = NO;
            }
            bankData = [[BankCardData alloc]initWithData:dict];
            [self.tableView reloadData];
        }else if(type == REQUSET_BankCardUnBind){
            
            [bankData.bankCardArr removeObjectAtIndex:indexpath.row];
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexpath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tableView reloadData];
        }

    }else{
        [Common showMsgBox:nil msg:[dict objectForKey:@"respDesc"] parentCtrl:self];
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


- (void)showDetailViewController:(UIViewController *)vc sender:(id)sender{

}






@end
