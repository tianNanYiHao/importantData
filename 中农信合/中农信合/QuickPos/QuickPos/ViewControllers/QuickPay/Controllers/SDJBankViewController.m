//
//  SDJBankViewController.m
//  QuickPos
//
//  Created by Leona on 15/3/13.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "SDJBankViewController.h"
#import "BankListTableViewCell.h"
#import "Common.h"
#import "SDJBankTableViewCell.h"

@interface SDJBankViewController ()<UITableViewDataSource,UITableViewDelegate,ResponseData>{
    
    NSMutableArray *bankArray;//银行的数组
    
    NSMutableArray *bankIDArray;//银行ID数组
    
    NSMutableArray *bankCodeArray;//联行号数组
    
    NSMutableArray *bankLogo;//银行logo
    
    NSDictionary *dataDic;//请求返回字典
    
    NSString *bankNameStr;
    
    NSString *bankCodeStr;
    
    Request *request;
    
}
@property (weak, nonatomic) IBOutlet UITableView *bankListTableView;//tableview

@end

@implementation SDJBankViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = L(@"BankList");
    
    
    bankArray = [NSMutableArray array];
    bankIDArray = [NSMutableArray array];
    bankLogo = [NSMutableArray array];
    dataDic = [NSDictionary dictionary];
    bankCodeArray = [NSMutableArray array];
    
    for (NSDictionary *item in self.resultBeanArray) {
        bankNameStr = [item objectForKey:@"bankName"];
        bankCodeStr = [item objectForKey:@"bankCode"];
        NSLog(@"%@  %@  %@  %@",bankNameStr,[item objectForKey:@"bankName"],bankCodeStr,
        [item objectForKey:@"bankCode"]);
        
        [bankArray addObject:bankNameStr];
        [bankCodeArray addObject:bankCodeStr];
        
        NSLog(@"%@  %@",bankArray,bankCodeArray);
    }
    
//    [self.bankListTableView reloadData];
    [Common setExtraCellLineHidden:self.bankListTableView];
    
    self.bankListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    request = [[Request alloc]initWithDelegate:self];
    
    
//    [request GetBankHeadQuarter];
    
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"加载中，请稍等"];
//    
//    [hud hide:YES afterDelay:2];

}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
 
}



- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    
//    if(type == REQUSET_BANK && [dict[@"respCode"]isEqual:@"0000"]){
//        
//      [MBProgressHUD hideHUDForView:self.view animated:YES];
//        
//      dataDic = dict;
//    
//      NSDictionary *getDic = dataDic[@"data"];
//    
//      NSArray*resultBeanrray = getDic[@"resultBean"];
//    
//      for (NSDictionary *dic in resultBeanrray) {
//          
//        [bankArray addObject:dic[@"bankName"]];
//        [bankIDArray addObject:dic[@"bankCode"]];
//        [bankLogo addObject:dic[@"iconUrl"]];
//          
//      }
//
//        [_bankListTableView reloadData];
//    }
}



#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return bankArray.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *SDJBankCellCellIdentifier = @"SDJBankListCell";
    
    SDJBankTableViewCell *SDJBankCell = (SDJBankTableViewCell*) [tableView dequeueReusableCellWithIdentifier:SDJBankCellCellIdentifier];
    
    SDJBankCell.bankNameLabel.text = bankArray[indexPath.row];
    NSLog(@"%@",SDJBankCell.bankNameLabel.text);
    SDJBankCell.bankLogoImageView.layer.masksToBounds = YES;
    SDJBankCell.bankLogoImageView.layer.cornerRadius = 20;
    
//    [SDJBankCell.bankLogoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",bankLogo[indexPath.row]]]];
    
    
    return SDJBankCell;
    
 
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
    
    //取到所选银行
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //存储时，除NSNumber类型使用对应的类型意外，其他的都是使用setObject:forKey:
    [userDefaults setObject:bankArray[indexPath.row] forKey:KFbank];
    [userDefaults setObject:bankCodeArray[indexPath.row] forKey:BankCode];
    
    NSLog(@"%@ %@ %@",userDefaults,BankCode,KFbank);
    
    [userDefaults synchronize];

    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:bankCodeArray[indexPath.row],@"bankCode",bankArray[indexPath.row],@"bankName", nil];
    
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"banktongzhi" object:dic];

    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
