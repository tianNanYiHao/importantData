//
//  MangeMoneyViewController.m
//  QuickPos
//
//  Created by Aotu on 16/1/11.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "MangeMoneyViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "UMSocial.h"

#import "MangePayViewController.h"
@interface MangeMoneyViewController ()<UIWebViewDelegate,UMSocialDataDelegate,UMSocialUIDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation MangeMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    self.title = @"理财";
    
    NSURL *url = [NSURL URLWithString:@"http://148560.vhost110.boxcdn.cn/"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _webView.scrollView.bounces = NO;
    _webView.delegate = self;
    [_webView loadRequest:request];
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"jiantou"];
    
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *url = [NSString stringWithFormat:@"%@",request.URL];
    if ([url rangeOfString:@"product.html"].location != NSNotFound){
        self.title = @"产品详情";
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(gotoAction:)];
        self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"financial_share"];

    }else if([url rangeOfString:@"Finance.html"].location != NSNotFound){
        self.title = @"理财";
    }else if([url rangeOfString:@"trade.html"].location != NSNotFound){
        self.title = @"交易详情";
        
    }
    
    
    
    return YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"buy"] = ^() {
        NSArray *args = [JSContext currentArguments];
        for (JSValue *jsVal in args) {
            NSLog(@"%@", jsVal.toString);
            
        }
        UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        MangePayViewController *mangePayVC = [mainStory  instantiateViewControllerWithIdentifier:@"MangePayViewController"];
        
//        mangePayVC.productID = _productID;
//        mangePayVC.number = [NSNumber numberWithInt:_buyNumberIntt];
//        mangePayVC.amt = [NSNumber numberWithInt:_buyNumberIntt*[_qigouMoneyy intValue]];

        [self.navigationController pushViewController:mangePayVC animated:YES];
  
    };
}
- (void)backAction:(UIButton*)btn{

    if ([self.title isEqualToString:@"理财"]) {
    [self.navigationController popViewControllerAnimated:YES];
    }
    if ([self.title isEqualToString:@"产品详情"]) {
        [self.webView goBack];
        self.title = @"理财";
    }
    if ([self.title isEqualToString:@"交易详情"]) {
        [self.webView goBack];
        self.title = @"理财";
    }
    else{
      
    }
  
}

- (void)gotoAction:(UIButton *)btn
{
//    [UMSocialData openLog:YES];
    [UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskLandscape];
    
    //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
    //如果需要分享回调，请将delegate对象设置self，并实现下面的回调方法
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"57677f6be0f55a8d0a000255"
                                      shareText:@"捷丰生活,让您生活服务更方便/快捷,http://fir.im/bmjfsh"
                                     shareImage:[UIImage imageNamed:@"icon"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone,UMShareToAlipaySession, nil]
                                       delegate:self];

}

#pragma mark ------分享------
//弹出列表方法presentSnsIconSheetView需要设置delegate为self
-(BOOL)isDirectShareInIconActionSheet
{
    return YES;
}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
