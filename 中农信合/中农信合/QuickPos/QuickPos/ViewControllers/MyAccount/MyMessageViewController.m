//
//  MyMessageViewController.m
//  QuickPos
//
//  Created by Leona on 15/4/12.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "MyMessageViewController.h"
#import "MessageCell.h"
#import "Common.h"
#import "MJRefresh.h"
#import "BoRefreshHeader.h"
#import "BoRefreshAutoStateFooter.h"

#define FONT_SIZE 13.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f

@interface MyMessageViewController ()<UITableViewDataSource,UITableViewDelegate,ResponseData>{
    
    NSMutableArray *tableViewArray;//tableView数据源
    
    NSUserDefaults *userDefaults;//储存
    
    NSString *firstMsgId;//第一条ID
    
    NSString *lastMsgId;//最后条ID
    
    //NSMutableArray *reloadArray; //接受刷新的数据
    
    NSString *oldMsgId;//旧ID
    
    int loadType; // 0 = 初始  1 = 加载新   2 = 加载旧
    
    Request *request;
    
    NSTimer *timer;//延迟显示

}

@property (weak, nonatomic) IBOutlet UITableView *messageTableView;//tableview


@end


@implementation MyMessageViewController


- (void)viewDidLoad {
    
    self.messageTableView.scrollEnabled = NO;
    
    [super viewDidLoad];
    
    self.title = L(@"MyMessage");
    
    [Common setExtraCellLineHidden:self.messageTableView];
    
    tableViewArray = [NSMutableArray array];
    
   NSString *s = [[NSUserDefaults standardUserDefaults] objectForKey:@"MsgList"]; //获取推送信息 暂未使用
    
    self.messageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    request = [[Request alloc]initWithDelegate:self];
    
    [self loadData];
    
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:L(@"ListLoading")];
    [hud hide:YES afterDelay:1];

    
    self.messageTableView.header = [BoRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(dropDown)];
    self.messageTableView.footer = [BoRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(OnPull)];
    
    oldMsgId = [NSString stringWithFormat:@"%@oldMsgId",[AppDelegate getUserBaseData].mobileNo];
       
}

- (void)promptData:(BOOL)hiddenValue{
    UIImageView *smallBell = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-52)/2,150,52,69)];
    smallBell.image = [UIImage imageNamed:@"no_message"];
    [self.messageTableView addSubview:smallBell];
    //    smallBell.hidden = YES;
    smallBell.hidden = hiddenValue;
    
    UILabel *smallLanguage = [[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(smallBell.frame)+24,SCREEN_WIDTH,15)];
    smallLanguage.font = [UIFont systemFontOfSize:15];
    smallLanguage.text = @"你还没有消息哦！";
    smallLanguage.textColor = RGB(153, 153, 153);;
    smallLanguage.textAlignment = NSTextAlignmentCenter;
    [self.messageTableView addSubview:smallLanguage];
    //    smallLanguage.hidden = YES;
    smallLanguage.hidden = hiddenValue;
}

- (void)showMBP{
    
    [self.messageTableView.header endRefreshing];
    [self.messageTableView.footer endRefreshing];
    
    [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"NOmessage")];
    
    [timer invalidate];
    self.messageTableView.scrollEnabled = YES;
}


//请求
- (void)loadData{
    
    loadType = 0;
    
    [request msgList:@"0" andLastMsgID:@"0" andRequestType:@"02"];
}

- (void)dropDown//下拉刷新
{
    loadType = 1;
    //空消息判断
    if (firstMsgId == nil) {
      [request msgList:@"0" andLastMsgID:@"0" andRequestType:@"02"];
    }
    else
    {
      [request msgList:firstMsgId andLastMsgID:@"0" andRequestType:@"02"];
    }
}

- (void)OnPull//上拉刷新
{
    loadType = 2;
    //空消息判断
    if (lastMsgId == nil) {
        
        [request msgList:@"0" andLastMsgID:@"0" andRequestType:@"02"];
    }
    else
    {
        [request msgList:@"0" andLastMsgID:lastMsgId andRequestType:@"01"];
    }
}



- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    
    
    
    //列表数组
    NSArray *msgArr = [[dict objectForKey:@"data"] objectForKey:@"msgList"];
    //无记录返回取值
    NSDictionary *resultDic = [[dict objectForKey:@"data"] objectForKey:@"result"];
    
    if([resultDic[@"resultCode"] isEqual:@"8895"]){
        
        timer = [NSTimer scheduledTimerWithTimeInterval:1.2 target:self selector:@selector(showMBP) userInfo:nil repeats:NO];
        [self promptData:NO];
        
    }else if([dict[@"respCode"] isEqual:@"0000"]){
    
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        self.messageTableView.scrollEnabled = YES;
        [self promptData:YES];
        
    //初始返回
       if(loadType == 0){
        
        [tableViewArray addObjectsFromArray:msgArr];
           
        }
    //下拉
        else if (loadType == 1)
        {
        int index = 0;
        
        for (NSDictionary *DI in msgArr) {
            [tableViewArray insertObject:DI atIndex:index];
            index++;
        }
            
        [self.messageTableView.header endRefreshing];
            
        }
    //上拉
       else if (loadType == 2)
           
       {
        [tableViewArray addObjectsFromArray:msgArr];
        
           [self.messageTableView.footer endRefreshing];
        
        lastMsgId = [[tableViewArray lastObject] objectForKey:@"msgID"];
           
       }
        
       if (tableViewArray.count != 0) {
        
        firstMsgId = [[tableViewArray firstObject] objectForKey:@"msgID"];
        
        lastMsgId = [[tableViewArray lastObject] objectForKey:@"msgID"];
        
        [userDefaults setObject:firstMsgId forKey:oldMsgId];
           
       }
        [self.messageTableView reloadData];
        
        
  }
    
}



#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return tableViewArray.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    CGSize size = [[tableViewArray objectAtIndex:indexPath.row][@"msgDetial"] sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(290, 20000)];
    CGFloat height = size.height;
    
    if (height<30) //评论年内容的高度
    {
        height = 60;
    }else{
        height += 30;
    }
    
    // NSIndexPath *indexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
    
    if(indexPath.row == 0||indexPath.row == 1){
        height += 10;
    }
    
    height += 10; //加上“评论人”和“时间”Label的高度；
    
    
    
  return height;

    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //列表cell绑定
    static NSString *CellIdentifier = @"messagecell";
    MessageCell *cell = (MessageCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSDictionary *dic = tableViewArray[indexPath.row];
        
    if([dic[@"msgTitle"] isEqual:@""]){
        
        cell.messageTitleLabel.text = L(@"NoTitle");
        
        
    }else{
        
        cell.messageTitleLabel.text = dic[@"msgTitle"];
    
    }

    
    
    if([dic[@"msgDetial"] isEqual:@""]){
        
        cell.messageTextLabel.text = L(@"NoTitle");
        
        
    }else{
        
        cell.messageTextLabel.text = dic[@"msgDetial"];
        
        
    }
 
  //修改时间的现实格式
    NSMutableString *dateStr = [[NSMutableString alloc]initWithString:dic[@"sendTime"]];
    [dateStr insertString:@"-" atIndex:4];
    [dateStr insertString:@"-" atIndex:7];
    [dateStr insertString:@"-" atIndex:10];
    [dateStr insertString:@":" atIndex:13];
    NSString *date = [dateStr substringToIndex:16];
    
    cell.dateLabel.text = date;
    
    
    
    
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
   
    
}






@end
