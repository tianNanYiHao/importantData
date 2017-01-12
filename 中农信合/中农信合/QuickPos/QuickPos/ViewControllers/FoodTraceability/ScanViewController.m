//
//  ScanViewController.m
//  QuickPos
//
//  Created by feng Jie on 16/7/4.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "ScanViewController.h"

#import "Common.h"

@interface ScanViewController ()
{
    UIWebView *QRCodeView;
}




@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"扫一扫";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
        QRCodeView = [[UIWebView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];

    
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.scanCode]];
    
        [self.view addSubview:QRCodeView];
        [QRCodeView loadRequest:request];
        
        
   
}

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
