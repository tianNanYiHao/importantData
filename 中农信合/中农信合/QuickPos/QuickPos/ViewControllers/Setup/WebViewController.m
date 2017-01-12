//
//  WebViewController.m
//  QuickPos
//
//  Created by 胡丹 on 15/4/28.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "WebViewController.h"
#import "MBProgressHUD+Add.h"

@interface WebViewController ()<UIWebViewDelegate>{
    MBProgressHUD *hud;
}
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end

@implementation NSURLRequest (NSURLRequestWithIgnoreSSL)

+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host
{
    return YES;
}

@end

@implementation WebViewController

@synthesize title;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
    [self setTitle:title];
//    [self.parentViewController.tabBarController setHidesBottomBarWhenPushed:YES];
    NSURLRequest *Urlrequest = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    self.webview.delegate = self;
    self.webview.scalesPageToFit = YES;
    [self.webview loadRequest:Urlrequest];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//
//}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    if (!hud) {
        hud = [MBProgressHUD showMessag:L(@"Loading") toView:self.view];
    }
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [hud hide:YES];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{

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
