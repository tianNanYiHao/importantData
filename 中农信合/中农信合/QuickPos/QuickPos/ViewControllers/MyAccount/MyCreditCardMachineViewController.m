//
//  MyCreditCardMachineViewController.m
//  QuickPos
//
//  Created by Leona on 15/3/18.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "MyCreditCardMachineViewController.h"
#import "CardMachineTableViewCell.h"
#import "Common.h"

@interface MyCreditCardMachineViewController ()<UITableViewDataSource,UITableViewDelegate,ResponseData>{
    
    NSArray *tableViewArray;//列表数组
    
    NSDictionary *dic;//请求返回取值字典
    
    int posDevice;//刷卡器的型号取值
    
    NSString * aichuangIC;     //艾创IC 刷卡头
    
    NSString * aichuangBlueTooth;  //艾创蓝 ⽛牙vpos,
    
    NSString * aichuangICvPos;          //艾创IC vPos,
    
    NSString * aichuangIC4000;  //艾创 4000磁条刷卡 头
    
    NSString * newLand;    //新⼤大陆 IC刷卡头,
    
    NSString * MagneticStripe;        //艾创磁条vpos或磁条⾳音 频pos
    
    NSTimer *timer;//延迟显示
    
}

@property (weak, nonatomic) IBOutlet UITableView *myCreditCardMachineTableView;

@end

@implementation MyCreditCardMachineViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.myCreditCardMachineTableView.scrollEnabled = NO;
    
    self.title = L(@"MyCreditCardMachine");
    
    self.navigationController.navigationBarHidden = NO;
    
    tableViewArray = [NSArray array];
    
    self.myCreditCardMachineTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    Request *requst = [[Request alloc]initWithDelegate:self];
       
    [requst myCreditCardMachine];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:L(@"MBPLoading")];
    [hud hide:YES afterDelay:1];
    
    [Common setExtraCellLineHidden:self.myCreditCardMachineTableView];
   
}

- (void)showMBP{
    
    
    [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"NoMachine")];
    
    [timer invalidate];
    
    self.myCreditCardMachineTableView.scrollEnabled = YES;
}

- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    
    //无记录返回取值
    NSDictionary *resultDic = [[dict objectForKey:@"data"] objectForKey:@"result"];
    
    if([resultDic[@"resultCode"] isEqual:@"8895"]){
        
        timer = [NSTimer scheduledTimerWithTimeInterval:1.2 target:self selector:@selector(showMBP) userInfo:nil repeats:NO];
        
        
    }else if([dict[@"respCode"] isEqual:@"0000"]){
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        self.myCreditCardMachineTableView.scrollEnabled = YES;
    
        tableViewArray = [[dict objectForKey:@"data"] objectForKey:@"resultBean"];
        
        
        [self.myCreditCardMachineTableView reloadData];
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
    
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *MachineCellCellIdentifier = @"CardMachineTableViewCell";
    
    CardMachineTableViewCell *MachineCell = (CardMachineTableViewCell *) [tableView dequeueReusableCellWithIdentifier:MachineCellCellIdentifier];
    
    MachineCell.CardMachineLabel.text = tableViewArray[indexPath.row][@"psam"];
    
    
    NSString *device = tableViewArray[indexPath.row][@"posDevice"];
    
    posDevice = [device intValue];
    
    if(posDevice == 1){
    
        MachineCell.CardMachineImageView.image = [UIImage imageNamed:@"itron_ic"];
    
    
    }else if (posDevice == 10){
    
        MachineCell.CardMachineImageView.image = [UIImage imageNamed:@"itron_bt_vpos"];
    
    }else if (posDevice == 100){
        
        MachineCell.CardMachineImageView.image = [UIImage imageNamed:@"itron_audio_vpos"];
        
    }else if (posDevice == 1000){
        
        MachineCell.CardMachineImageView.image = [UIImage imageNamed:@"itron_4k"];
        
    }else if (posDevice == 10000){
        
        MachineCell.CardMachineImageView.image = [UIImage imageNamed:@"newland_ic"];
        
    }else if (posDevice == 100000){
        
        MachineCell.CardMachineImageView.image = [UIImage imageNamed:@"itron_audio"];
        
    }

    
    return MachineCell;

    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

//  十进制转二进制
- (NSString *)toBinarySystemWithDecimalSystem:(NSString *)decimal
{
    int num = [decimal intValue];
    int remainder = 0;      //余数
    int divisor = 0;        //除数
    
    NSString * prepare = @"";
    
    while (true)
    {
        remainder = num%2;
        divisor = num/2;
        num = divisor;
        prepare = [prepare stringByAppendingFormat:@"%d",remainder];
        
        if (divisor == 0)
        {
            break;
        }
    }
    
    NSString * result = @"";
    for (int i = prepare.length - 1; i >= 0; i --)
    {
        result = [result stringByAppendingFormat:@"%@",
                  [prepare substringWithRange:NSMakeRange(i , 1)]];
    }
    
    return result;
}







@end
