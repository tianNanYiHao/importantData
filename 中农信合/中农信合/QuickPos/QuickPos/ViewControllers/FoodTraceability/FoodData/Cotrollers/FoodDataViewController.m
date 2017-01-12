//
//  FoodDataViewController.m
//  QuickPos
//
//  Created by caiyi on 16/1/11.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "FoodDataViewController.h"
#import "Common.h"
#import "CertificationGoodsViewController.h"
#import "AuthenticationDeviceViewController.h"
#import "AuthenticationEnterpriseViewController.h"
#import "DataReportViewController.h"


//重用标志符
#define kCellReuseId @"cellId"

@interface FoodDataViewController ()

@end

@implementation FoodDataViewController
@synthesize item;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = L(@"FoodData");
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (IBAction)Commodity:(id)sender {
    CertificationGoodsViewController *vc1 = [[CertificationGoodsViewController alloc]init];
    [self.navigationController pushViewController:vc1 animated:YES];
}

- (IBAction)Enterprise:(id)sender {
    AuthenticationEnterpriseViewController *vc2 = [[AuthenticationEnterpriseViewController alloc]init];
    [self.navigationController pushViewController:vc2 animated:YES];
}

- (IBAction)Equipment:(id)sender {
    AuthenticationDeviceViewController *vc3 = [[AuthenticationDeviceViewController alloc]init];
    [self.navigationController pushViewController:vc3 animated:YES];
}

- (IBAction)DataList:(id)sender {
    DataReportViewController *vc4 = [[DataReportViewController alloc]init];
    [self.navigationController pushViewController:vc4 animated:YES];
}

#pragma mark ------UICollectionViewDelegate------





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
