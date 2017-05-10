//
//  ViewController.m
//  wkwebviewATS
//
//  Created by tianNanYiHao on 2017/5/8.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "SandMajlet.h"

@interface ViewController ()<UIWebViewDelegate,SandMajletDelete>
{
    UIWebView *wk;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
    wk = [[UIWebView alloc] initWithFrame:CGRectMake(0, 200, 300, 200)];
    
    NSURL *URL= [NSURL URLWithString:@"http://172.28.250.242:17892/html/ot/jnl-trans-flow-mobile.html?type=01"];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:URL];
    wk.delegate = self;
    
    [wk loadRequest:req];
    
    [self.view addSubview:wk];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}




-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    SandMajlet *sanmajlet = [[SandMajlet alloc] init];
    sanmajlet.delegate = self;
    context[@"SandMajlet"] = sanmajlet;
    
    return YES;

}


-(void)webViewDidStartLoad:(UIWebView *)webView{
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    SandMajlet *sanmajlet = [[SandMajlet alloc] init];
    sanmajlet.delegate = self;
    context[@"SandMajlet"] = sanmajlet;
    
}


-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    SandMajlet *sanmajlet = [[SandMajlet alloc] init];
    sanmajlet.delegate = self;
    context[@"SandMajlet"] = sanmajlet;
    
    
}

- (void)SandMajletIndex:(NSInteger)paramInt paramString:(NSString *)paramString{
    
    if (paramInt == 3) {
        
        NSLog(@"%@",paramString);
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
