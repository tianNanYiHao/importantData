//
//  ViewController.m
//  SDpopViewDemo
//
//  Created by tianNanYiHao on 2017/11/2.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"

#import "SDSearchPop.h"
#import "SDRechargePopView.h"
#import "SDBottomPop.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    
}

- (IBAction)searchPopClick:(id)sender {
    
    [SDSearchPop showSearchPopViewPlaceholder:@"这里输入文字" textBlock:^(NSString *text) {
        
    }];
    
}
- (IBAction)rechargePopClick:(id)sender {
    
    SDRechargePopView *pop = [SDRechargePopView showRechargePopView:@"" rechargeChooseBlock:^(NSString *cellName) {
        
    }];
    
    pop.chooseBtnTitleArr = @[@"按钮一",@"按钮二"];
    
}
- (IBAction)bottomPopClick:(id)sender {
    
    [SDBottomPop showBottomPopView:@"这里是我们的温馨提示" cellNameList:@[@"添加杉德卡",@"删除"] suerBlock:^(NSString *cellName) {
        NSLog(@"%@",cellName);
    } cancleBlock:^{
        NSLog(@"-=-=--= 取消 -=-=-=-=");
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
