//
//  ContractView.m
//  QuickPos
//
//  Created by 胡丹 on 15/4/14.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "ContractView.h"
#import "WebViewController.h"
#import "QuickPosTabBarController.h"
#import "DDMenuController.h"
#import "Common.h"




@interface ContractView ()

{
    UIWebView *_webView;
}

@property (weak, nonatomic) IBOutlet UIView *backview;
@property (weak, nonatomic) IBOutlet UILabel *telephone;
@property (weak, nonatomic) IBOutlet UILabel *website;
@property (nonatomic,strong)UIViewController *parentCtrl;
@end


@implementation ContractView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init{
    self = [super init];
    if (self) {
        self  = [[[NSBundle mainBundle] loadNibNamed:@"ContractView" owner:self options:nil] objectAtIndex:0];
        self.backview.center = self.center;
        self.backview.layer.masksToBounds = YES;
        self.backview.layer.cornerRadius = 8;
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        if (!self.parentCtrl) {
            self.parentCtrl = [[UIViewController alloc]init];
        }
        
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        self.telephone.text = [NSString stringWithFormat:@"400-050-9558",L(@"ContactCompany"),[[delegate getConfigDic] objectForKey:@"customerService"]];
        NSString *url;
        if ([[[delegate getConfigDic] objectForKey:@"website"]hasPrefix:@"http://www.cnznxh.cc"]) {
            url = [NSString stringWithFormat:@"http://www.cnznxh.cc",L(@"CompanyWebsite"),[[delegate getConfigDic] objectForKey:@"website"]];
        }else{
            url = [NSString stringWithFormat:@"http://www.cnznxh.cc",L(@"CompanyWebsite"),[[delegate getConfigDic] objectForKey:@"website"]];
        }

        self.website.text = url;
        
    }
    return self;

    
}

//- (void)awakeFromNib{
//    self.alpha = 0;
//    [UIView animateWithDuration:0.5 animations:^{
//        self.alpha = 0.8;
//    }];
//
//}

//访问官网
- (IBAction)gotoWebview:(UIButton *)sender {
    
    //访问官网
    [self.superCtrl dismissViewControllerAnimated:NO completion:^{
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        NSString *url;
        if ([[[delegate getConfigDic] objectForKey:@"website"]hasPrefix:@"http"]) {
            url = [NSString stringWithFormat:@"%@",[[delegate getConfigDic] objectForKey:@"website"]];
        }else{
            url = [NSString stringWithFormat:@"http://www.cnznxh.cc",L(@"CompanyWebsite"),[[delegate getConfigDic] objectForKey:@"website"]];
        }
        
        WebViewController *web = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"WebViewController"];
        web.url = url;
        web.navigationItem.title = L(@"CompanyWebsite");
        DDMenuController *menuController = (DDMenuController*)[QuickPosTabBarController getQuickPosTabBarController].parentCtrl;
        
        UITabBarController *tb = (UITabBarController*)[menuController rootViewController];
        UINavigationController *ctr = (UINavigationController*)[tb selectedViewController];
        [menuController showRootController:YES];
        UIViewController *ctrl = [ctr visibleViewController];
        [web setHidesBottomBarWhenPushed:YES];
        [[ctrl navigationController] pushViewController:web animated:YES];
        
    }];
    
}

//拨打电话  telephone:021-31129501
- (IBAction)telephone:(UIButton *)sender {
    
//    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//    NSString *telUrl = [NSString stringWithFormat:@"tel://%@",[[delegate getConfigDic] objectForKey:@"customerService"]];
    
    NSString *telUrl = [NSString stringWithFormat:@"tel://%@",@"4000509558"];
    NSURL *url = [[NSURL alloc] initWithString:telUrl];
    [[UIApplication sharedApplication] openURL:url];

}


- (IBAction)closeContractView:(UIButton *)sender {
    [self.superCtrl dismissViewControllerAnimated:NO completion:^{
     }];

}

+ (void)showVersionView:(id)ctrl{
    
    ContractView *v = [[ContractView alloc]init];
    [v.parentCtrl.view addSubview:v];
    v.superCtrl = (UIViewController*)ctrl;
    v.originFrame = v.superCtrl.view.frame;
    v.parentCtrl.view.window.windowLevel = UIWindowLevelAlert;
    [(UIViewController*)ctrl presentViewController:v.parentCtrl animated:NO completion:nil];
    
}
@end
