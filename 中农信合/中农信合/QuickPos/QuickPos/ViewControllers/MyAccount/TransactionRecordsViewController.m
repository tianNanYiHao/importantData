//
//  TransactionRecordsViewController.m
//  QuickPos
//
//  Created by Leona on 15/3/16.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "TransactionRecordsViewController.h"
#import "TransactionRecordsTableViewCell.h"
#import "TransactionDetailsViewController.h"
#import "AllTransactionViewController.h"
#import "IncomedataViewController.h"
#import "SpendingViewController.h"
#import "WithdrawalOfRecordViewController.h"
#import "HMSegmentedControl.h"
#import "Common.h"

@interface TransactionRecordsViewController ()

@property(strong,nonatomic)AllTransactionViewController *alltableView;//所有数据

@property(strong,nonatomic)IncomedataViewController *incometableView;//收入

@property(strong,nonatomic)SpendingViewController *spendingtableView;//支出

@property(strong,nonatomic)WithdrawalOfRecordViewController *withdrawaltableView;//提现
@end

@implementation TransactionRecordsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"交易记录";
    
    self.navigationController.navigationBarHidden = NO;
   
    
    //自定义segmect
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[L(@"All"),L(@"Income"), L(@"Spending"),L(@"Withdrawal")]];
    
    segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;//风格
    
    segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;//指示线上下
    
    segmentedControl.selectedTextColor = [Common hexStringToColor:@"#5ecbef"];
    
    segmentedControl.selectionIndicatorColor = [Common hexStringToColor:@"#5ecbef"];
    
    segmentedControl.selectionIndicatorHeight = 3.0;
    
    segmentedControl.selectedSegmentIndex = 0;
    
    segmentedControl.font = [UIFont systemFontOfSize:14];
    
    [segmentedControl setFrame:CGRectMake(0, 0, self.view.frame.size.width, 45)];
    
    
    [self.view addSubview:segmentedControl];
    
    //Segmented添加事件
    [segmentedControl addTarget:self action:@selector(segmentACT:) forControlEvents:UIControlEventValueChanged];
    

    
    
    
    
    //全部数据的列表
    self.alltableView = [[AllTransactionViewController alloc]init];
    
    self.alltableView.view.frame = CGRectMake(0, 46, self.view.frame.size.width, self.view.frame.size.height-64-55);
    
   
    [self.view addSubview:self.alltableView.view];
    
    [self addChildViewController:self.alltableView];
    
    self.alltableView.view.hidden = NO;
    
    
    
    //收入列表
    
    self.incometableView = [[IncomedataViewController alloc]init];
    
    self.incometableView.view.frame = CGRectMake(0, 46, self.view.frame.size.width, self.view.frame.size.height-64-55);
    
    [self addChildViewController:self.incometableView];
    
    [self.view addSubview:self.incometableView.view];
    
    self.incometableView.view.hidden = YES;
    
    
    
    //支出列表
    
    self.spendingtableView = [[SpendingViewController alloc]init];
    
    self.spendingtableView.view.frame = CGRectMake(0, 46, self.view.frame.size.width, self.view.frame.size.height-64-55);
    
    
    [self addChildViewController:self.spendingtableView];
    
    [self.view addSubview:self.spendingtableView.view];
    
    self.spendingtableView.view.hidden = YES;

    
    //提现
    
    self.withdrawaltableView = [[WithdrawalOfRecordViewController alloc]init];
    
    self.withdrawaltableView.view.frame = CGRectMake(0, 46, self.view.frame.size.width, self.view.frame.size.height-64-55);
    
    
    [self addChildViewController:self.withdrawaltableView];
    
    [self.view addSubview:self.withdrawaltableView.view];
    
    self.withdrawaltableView.view.hidden = YES;

}

- (void)segmentACT:(UISegmentedControl *)Seg{
    
    NSInteger Index = Seg.selectedSegmentIndex;
    
    
    if(Seg.selectedSegmentIndex == 2){
        
        NSLog(@"这是2--支出");
        
       self.incometableView.view.hidden = YES;
        
       self.alltableView.view.hidden = YES;
        
       self.spendingtableView.view.hidden = NO;
        
       self.withdrawaltableView.view.hidden = YES;
        
       [self.incometableView loadData];//点击才开始请求
        
       
 
        
        
    }
    if(Seg.selectedSegmentIndex == 0){
        
        NSLog(@"这是0--全部");
        
       self.incometableView.view.hidden = YES;
        
       self.alltableView.view.hidden = NO;
        
       self.spendingtableView.view.hidden = YES;
        
       self.withdrawaltableView.view.hidden = YES;
        
       [self.alltableView loadData];//点击才开始请求
        
        
        
        
    }
    if(Seg.selectedSegmentIndex == 1){
        
        NSLog(@"这是1--收入");
        
        self.incometableView.view.hidden = NO;
        
        self.alltableView.view.hidden = YES;
        
        self.spendingtableView.view.hidden = YES;
        
        self.withdrawaltableView.view.hidden = YES;
        
        [self.spendingtableView loadData];//点击才开始请求
        
        
    }
    
    if(Seg.selectedSegmentIndex == 3){
        
        NSLog(@"这是3,");
        
        self.spendingtableView.view.hidden = YES;
        
        self.incometableView.view.hidden = YES;
        
        self.alltableView.view.hidden = YES;
        
        self.withdrawaltableView.view.hidden = NO;
        
        [self.withdrawaltableView loadData];//点击才开始请求
        
        
        
    }

    

     NSLog(@"Seg.selectedSegmentIndex:%ld",(long)Index);
}




@end
