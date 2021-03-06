//
//  ViewController.m
//  LFFExcellView
//
//  Created by Lff on 16/8/18.
//  Copyright © 2016年 Lff. All rights reserved.
//

#import "ViewController.h"
#import "LFFExcel.h"
#define customBlue [UIColor colorWithRed:69/255.0 green:120/255.0 blue:245/255.0 alpha:1]
#define customGray [UIColor colorWithRed:238/255.0 green:238/255.0 blue:245/255.0 alpha:1]
#define customLineBlue [UIColor colorWithRed:151/255.0 green:170/255.0 blue:245/255.0 alpha:1]
#import "pushViewController.h"

@interface ViewController ()<LFFExcelDelegate>
{
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"表格";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    //数据初始化 及样式初始化
    LFFExcelData *ds = [[LFFExcelData alloc] init];
    //标题栏数据
    ds.titles = (NSMutableArray*)@[@"时长",@"流量",@"网络",@"地点"];
    //数据栏数据
    ds.data = [NSMutableArray arrayWithObjects:
               @[@"10:01",@"15.6M",@"31G",@"上海1"],
               @[@"10:01",@"15.6M",@"32G",@"上海2"],
               @[@"10:01",@"15.6M",@"33G",@"上海3"],
               @[@"10:01",@"15.6M",@"34G",@"上海4"],
               @[@"10:01",@"15.6M",@"35G",@"上海5"],
               @[@"10:01",@"15.6M",@"36G",@"上海6"],
               @[@"10:01",@"15.6M",@"37G",@"上海7"],
               @[@"10:01",@"15.6M",@"38G",@"上海8"],
               @[@"10:01",@"15.6M",@"39G",@"上海9"],
               @[@"10:01",@"15.6M",@"39G",@"上海9"],
               @[@"10:01",@"15.6M",@"39G",@"上海9"],
               @[@"10:01",@"15.6M",@"39G",@"上海9"],
               @[@"",@"",@"",@""],@[@"",@"",@"",@""],@[@"",@"",@"",@""],@[@"",@"",@"",@""],
               nil];
    
    //设置表格的x
    ds.excelX = 10;
    //设置表格的y
    ds.excelY = 100;
    //设置表格的单元格高度
    ds.cellHeight = 40;
    
    //设置表格标题背景色
    ds.titleColor = customBlue;
    //设置表格单元格颜色
    ds.cellColor = customGray;
    //设置单元格网格线颜色
    ds.lineColor = customLineBlue;
    //设置按钮anction
    ds.anction = YES;
    
    LFFExcelComponent *excel = [[LFFExcelComponent alloc] initWithdata:ds];
    excel.delegate = self;
    [self.view addSubview:excel];
    
}

#pragma mark LFFExcelDelegate
-(void)btnAction:(NSInteger)index{
    
    pushViewController *p = [[pushViewController alloc] init];
    [self.navigationController pushViewController:p animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
