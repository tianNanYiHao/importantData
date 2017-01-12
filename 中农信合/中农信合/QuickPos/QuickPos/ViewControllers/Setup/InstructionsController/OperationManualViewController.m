//
//  OperationManualViewController.m
//  QuickPos
//
//  Created by feng Jie on 16/8/2.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "OperationManualViewController.h"

#define INFORMATION_URL @"http://www.jiefengtechnology.com/jfpay_display/image/help/"
@interface OperationManualViewController ()
{
    UIWebView *_webView;

}
@end

@implementation OperationManualViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.titleName;
    
    
    self.navigationController.navigationBar.barTintColor = [Common hexStringToColor:@"#068bf4"];//导航栏颜色
    self.navigationController.navigationBar.tintColor = [Common hexStringToColor:@"#ffffff"];//返回键颜色
    self.navigationController.navigationBar.contentMode = UIViewContentModeScaleAspectFit;
    //设置标题颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [Common hexStringToColor:@"#ffffff"], UITextAttributeTextColor,
                                                                     [UIFont systemFontOfSize:17], UITextAttributeFont,
                                                                     nil]];

    
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",INFORMATION_URL,self.str];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    _webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
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
