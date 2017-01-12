//
//  TransactionDetailsViewController.m
//  QuickPos
//
//  Created by Leona on 15/3/16.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "TransactionDetailsViewController.h"
#import "TransactionDetailsData.h"

@interface TransactionDetailsViewController ()<ResponseData>{
    
    Request *request;
    
    TransactionDetailsData *detailsData;
    
    NSDictionary *dataDic;//请求返回字典取值
    
    NSMutableString *availableAmtStr;//交易金额
    
    NSMutableString *freeStr;//手续费

}
@property (weak, nonatomic) IBOutlet UILabel *tradeNameLabel;//交易名称

@property (weak, nonatomic) IBOutlet UILabel *payerNameLabel;//付款方

@property (weak, nonatomic) IBOutlet UILabel *payeeNameLabel;//收款方

@property (weak, nonatomic) IBOutlet UILabel *transactionAmountLabel;//交易金额

@property (weak, nonatomic) IBOutlet UILabel *poundageLabel;//手续费

@property (weak, nonatomic) IBOutlet UILabel *transactionStatusLabel;//交易状态

@property (weak, nonatomic) IBOutlet UILabel *methodOfPaymentLabel;//支付方式

@property (weak, nonatomic) IBOutlet UILabel *tradingTimeLabel;//交易时间


@property (nonatomic,strong) NSString *status;

@end

@implementation TransactionDetailsViewController

@synthesize recordID;
@synthesize time;


- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.title = L(@"TransactionDetails");
    
    request = [[Request alloc]initWithDelegate:self];
    
    [request recordDetail:recordID andTime:time];
  
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:L(@"MBPLoading")];
    
    [hud hide:YES afterDelay:2];
    
    
    


}


- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
   
    if([dict[@"respCode"] isEqual:@"0000"]){
        
       [MBProgressHUD hideHUDForView:self.view animated:YES];
        
       detailsData = [[TransactionDetailsData alloc]initWithData:[[dict objectForKey:@"data"] objectForKey:@"resultBean"]];
       
        //交易名称
       if([detailsData.tradeName isEqual:@""]){
        
           self.tradeNameLabel.text = L(@"NoTitle");
        
        
        }else{
        
           self.tradeNameLabel.text = detailsData.tradeName;
                
        }

        //付款人姓名
        self.payerNameLabel.text = detailsData.payerName;
        
        //收款人姓名
        if([detailsData.payeeName isEqual:@""]){
        
            self.payeeNameLabel.text = L(@"NoAccountOfThePayee");
        
        }else{
        
            self.payeeNameLabel.text = detailsData.payeeName;
        
        }
        //交易状态
        if ([self.transactionStatus isEqualToString:@""]) {
            self.transactionStatusLabel.text = @"无交易状态";
        }else{
            self.transactionStatusLabel.text = detailsData.transactionStatus;
        }
 
    
   //交易金额                                                                                                                                                                                                                                                                                                   
    
    //分转为元
    
        double userSum = [detailsData.transactionAmount doubleValue];
    
        availableAmtStr = [NSMutableString stringWithFormat:@"%0.2f",userSum/100];
    
       [availableAmtStr insertString:@"￥" atIndex:0];
    
        self.transactionAmountLabel.text = availableAmtStr;
    

 
    
   //手续费
    if([detailsData.poundage isEqual:@""]){
        
        self.poundageLabel.text = @"￥0.00";
    
    }else{
   
        float freeSum = [detailsData.poundage floatValue];
        
        freeStr = [NSMutableString stringWithFormat:@"%f",freeSum];
        [freeStr insertString:@"￥" atIndex:0];
        
        self.poundageLabel.text = [freeStr substringToIndex:5];
        
 
    
    }
    //交易方式
        self.methodOfPaymentLabel.text = self.payStyle;
    
    
    //时间
       NSMutableString *timeStr = [NSMutableString stringWithString:detailsData.tradingTime];
    
       [timeStr insertString:@":" atIndex:2];
       [timeStr insertString:@":" atIndex:5];
       [timeStr insertString:@"  " atIndex:0];
    
    //修改日期的现实格式
    
        NSMutableString *str = [NSMutableString stringWithString:detailsData.tradingDate];
        [str insertString:@"-" atIndex:4];
    
        NSMutableString *str2 = [NSMutableString stringWithString:str];
        [str2 insertString:@"-" atIndex:7];

        [str2 appendString:timeStr];
    
    
    
        self.tradingTimeLabel.text = str2;
    

    
   }

}





@end
