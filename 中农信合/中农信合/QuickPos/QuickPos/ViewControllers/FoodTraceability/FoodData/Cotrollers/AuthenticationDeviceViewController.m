//
//  AuthenticationDeviceViewController.m
//  QuickPos
//
//  Created by caiyi on 16/2/1.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "AuthenticationDeviceViewController.h"

//#define DEVICE_URL @"http://shfda.org/data/showdatamobile.do?menu-id=device"
#define DEVICE_URL @"https://excashier.alipay.com/standard/auth.htm?payOrderId=0418ad8e1c964a9d8c15c9f02a624187.80"

@interface AuthenticationDeviceViewController ()
{
    UIWebView *_webView;
}
@end

@implementation AuthenticationDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"认证设备";
    
    _webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:DEVICE_URL]];
    _webView.scalesPageToFit = YES;
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
