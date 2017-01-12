//
//  FoodInFormationViewController.m
//  QuickPos
//
//  Created by caiyi on 16/2/1.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "FoodInFormationViewController.h"


#define INFORMATION_URL @"http://shfda.org/shfda/news/mobile/list.do"

@interface FoodInFormationViewController ()
{
    UIWebView *_webView;
}
@end

@implementation FoodInFormationViewController
@synthesize item;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = L(@"FoodInformation");
    
    _webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:INFORMATION_URL]];
    [self.view addSubview:_webView];
    [_webView loadRequest:request];
    
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
