//
//  UserAgreementViewController.m
//  QuickPos
//
//  Created by Leona on 15/3/10.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "UserAgreementViewController.h"
#import "Utils.h"
#import "UserBaseData.h"

@interface UserAgreementViewController ()<UIWebViewDelegate, NSURLConnectionDelegate, NSURLConnectionDataDelegate>
{
    NSDictionary *dataDic;//请求返回字典取值
}

@property (weak, nonatomic) IBOutlet UIWebView *UserAgreementWebView;//webView

@end

@implementation NSURLRequest (NSURLRequestWithIgnoreSSL)

+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host
{
    return YES;
}

@end

@implementation UserAgreementViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.title = L(@"UserAgreement");
    
    NSString *name = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    
    NSString *URL = [NSString stringWithFormat:@"%@name=%@&company=%@&company_short=%@", Agreement, [Utils urlEncode:name], [Utils urlEncode:[[AppDelegate getUserBaseData] company]], [Utils urlEncode:[[AppDelegate getUserBaseData] shortCompary]]];
    
    NSURLRequest *Urlrequest = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    
    [_UserAgreementWebView loadRequest:Urlrequest];
    
}

@end
