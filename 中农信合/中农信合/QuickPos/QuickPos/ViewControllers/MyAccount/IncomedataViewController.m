//
//  IncomedataViewController.m
//  QuickPos
//
//  Created by Leona on 15/4/2.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "IncomedataViewController.h"
#import "TransactionRecordsTableViewCell.h"
#import "TransactionDetailsViewController.h"
#import "Common.h"
#import "MJRefresh.h"
#import "BoRefreshHeader.h"
#import "BoRefreshAutoStateFooter.h"

@interface IncomedataViewController ()<UITableViewDelegate,UITableViewDataSource,ResponseData>{

    NSDictionary *dataDic;//请求返回数组
    
    NSMutableArray *tableViewArray;//列表最终数组
    
    NSMutableString *availableAmtStr;//交易金额
    
    NSString *firstMsgId;//用于刷新时的传参
    
    NSString *lastMsgId;//用于刷新时的传参
    
//    NSMutableArray *reloadArray;//接受刷新的数据
    
    int loadType; // 0 = 初始  1 = 加载新   2 = 加载旧
    
    Request *request;

    NSTimer *timer;//延迟显示


}
@property (strong, nonatomic) IBOutlet UITableView *incomedataTableView;//tableView

@end

@implementation IncomedataViewController

- (void)viewDidLoad {
    
    self.incomedataTableView.scrollEnabled = NO;
    
    [super viewDidLoad];
    
    //TableViewCell绑定
    
    UINib*mecell = [UINib nibWithNibName:@"TransactionRecordsTableViewCell" bundle:nil];
    
    [self.incomedataTableView registerNib:mecell forCellReuseIdentifier:@"TransactionRecordsTableViewCell"];
    ////////////////////////////////////////////////////////////////////
    
    tableViewArray = [NSMutableArray array];
    
    dataDic = [NSDictionary dictionary];
    
    loadType = 0;
    
    request = [[Request alloc]initWithDelegate:self];

        
    
    
    //刷新方法事件
    self.incomedataTableView.header = [BoRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(dropDown)];
    self.incomedataTableView.footer = [BoRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(OnPull)];
    
    
//    self.incomedataTableView.headerRefreshingText = L(@"MJRefreshing");
//    self.incomedataTableView.headerPullToRefreshText = L(@"Drop-downToRefresh");
//    self.incomedataTableView.headerReleaseToRefreshText = L(@"LoosenRefreshImmediately");
//    
//    
//    self.incomedataTableView.footerRefreshingText = L(@"MJLoading");
//    self.incomedataTableView.footerPullToRefreshText = L(@"upLoadMoreData");
//    self.incomedataTableView.footerReleaseToRefreshText = L(@"LoosenMoreDataToBeLoadedImmediately");
    
    
    
    
    [Common setExtraCellLineHidden:self.incomedataTableView];
    
    self.incomedataTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)showMBP{
    
    [self.incomedataTableView.header endRefreshing];
    [self.incomedataTableView.footer endRefreshing];
    
    [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"NoRecord")];
    
    [timer invalidate];

}

//请求
- (void)loadData{
    
    loadType = 0;
    [request recordList:@"1" andFirstMsgID:@"0" andLastMsgID:@"0" andRequestType:@"02"];
    
}

- (void)dropDown//下拉刷新
{
    loadType = 1;
    
    if(firstMsgId == nil || lastMsgId == nil){
    
       [request recordList:@"1" andFirstMsgID:@"0" andLastMsgID:@"0" andRequestType:@"02"];
        
    }else{
    
       [request recordList:@"1" andFirstMsgID:firstMsgId andLastMsgID:@"0" andRequestType:@"02"];
    }
}

- (void)OnPull//上拉刷新
{
    loadType = 2;
    if(firstMsgId == nil || lastMsgId == nil){
        
        [request recordList:@"1" andFirstMsgID:@"0" andLastMsgID:@"0" andRequestType:@"02"];
        
    }else{
        

        [request recordList:@"1" andFirstMsgID:@"0" andLastMsgID:lastMsgId andRequestType:@"01"];
    
    }
    
}


- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    
    
    //先转菊花。。。
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:L(@"ListLoading")];
    [hud hide:YES afterDelay:.8];
  
    
    self.incomedataTableView.scrollEnabled = YES;
    
    if([dict[@"respCode"] isEqual:@"8895"]){
        
        //配合菊花显示时间而显示无记录
        timer = [NSTimer scheduledTimerWithTimeInterval:0.9 target:self selector:@selector(showMBP) userInfo:nil repeats:NO];
        [self promptData:NO];
        
        
        
    }else
    if([dict[@"respCode"] isEqual:@"0000"]){
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self promptData:YES];
    //初始加载
     if(loadType == 0){
        
        dataDic = dict[@"data"];
        
        tableViewArray = dataDic[@"resultBean"];
        
        if(tableViewArray.count == 0){
            
            
            
            
        }else{
            
            firstMsgId = tableViewArray.firstObject[@"recordID"];
            
            lastMsgId = tableViewArray.lastObject[@"recordID"];
            
            
            
        }
        
        
    }else if(loadType == 1){
        
        //下拉刷新返回的数据
        dataDic = dict[@"data"];
        
        NSArray *reloadArray = dataDic[@"resultBean"];
        
        if(reloadArray.count == 0){
            
            [self.incomedataTableView.header endRefreshing];
            
            
        }else{
            
            
            
            //lastMsgId = reloadArray.lastObject[@"recordID"];
            
            for (int i = [reloadArray count]-1; i>=0; i--) {
                NSDictionary *dic = [reloadArray objectAtIndex:i];
                [tableViewArray insertObject:dic atIndex:0];
            }
            
            
            [tableViewArray addObjectsFromArray:reloadArray];
            
            firstMsgId = reloadArray.firstObject[@"recordID"];
            
            [self.incomedataTableView.header endRefreshing];
            
        }
        
        
    }else if(loadType == 2){
        
        //上拉刷新返回的数据
        
            dataDic = dict[@"data"];
        
            NSArray *reloadArray = dataDic[@"resultBean"];
        
            if(reloadArray.count == 0){
            
                [self.incomedataTableView.footer endRefreshing];
            
            }else{
            
                //firstMsgId = reloadArray.firstObject[@"recordID"];
            
                [tableViewArray addObjectsFromArray:reloadArray];
                
                lastMsgId = reloadArray.lastObject[@"recordID"];
                
                [self.incomedataTableView.footer endRefreshing];
        }
    }
    
      [self.incomedataTableView reloadData];
    }
}

- (void)promptData:(BOOL)hiddenValue{
    UIImageView *smallBell = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-42)/2,150,42,53)];
    smallBell.image = [UIImage imageNamed:@"no_tradingrecord"];
    [self.incomedataTableView addSubview:smallBell];
    //    smallBell.hidden = YES;
    smallBell.hidden = hiddenValue;
    
    UILabel *smallLanguage = [[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(smallBell.frame)+24,SCREEN_WIDTH,15)];
    smallLanguage.font = [UIFont systemFontOfSize:15];
    smallLanguage.text = @"暂无交易记录！";
    smallLanguage.textColor = RGB(153, 153, 153);
    smallLanguage.textAlignment = NSTextAlignmentCenter;
    [self.incomedataTableView addSubview:smallLanguage];
    //    smallLanguage.hidden = YES;
    smallLanguage.hidden = hiddenValue;
}


#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return tableViewArray.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"TransactionRecordsTableViewCell";
    
    TransactionRecordsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    
    NSDictionary *dic = tableViewArray[indexPath.row];
    
    
    if([dic[@"title"] isEqual:@""]){
        
        cell.titleNameLabel.text = @"无标题";
        
        
    }else{
        
        cell.titleNameLabel.text = dic[@"title"];
        
        
    }

    //修改日期的现实格式
    NSMutableString *str = [NSMutableString stringWithString:tableViewArray[indexPath.row][@"date"]];
    [str insertString:@"-" atIndex:4];
    
    NSMutableString *str2 = [NSMutableString stringWithString:str];
    [str2 insertString:@"-" atIndex:7];
    
    cell.dataLabel.text = str2;

    
    double userSum = [[dic objectForKey:@"amount"] doubleValue];
    availableAmtStr = [NSMutableString stringWithFormat:@"%0.2f",userSum/100];
    
    
    [availableAmtStr insertString:@"￥" atIndex:0];
    
    cell.amountLabel.text = availableAmtStr;

    
    
    
    
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic=tableViewArray[indexPath.row];
    
    UIStoryboard *transactiondetailsVC = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TransactionDetailsViewController *transactionDetailsVC = [transactiondetailsVC instantiateViewControllerWithIdentifier:@"detailsVC"];
    
    
    transactionDetailsVC.recordID = dic[@"recordID"];
    transactionDetailsVC.time = dic[@"time"];
    transactionDetailsVC.transactionStatus = dic[@"summary"];
    transactionDetailsVC.payStyle = dic[@"title"];
    NSLog(@"%@",transactionDetailsVC.transactionStatus);
    
    [self.navigationController pushViewController:transactionDetailsVC animated:YES];
    
}

@end
