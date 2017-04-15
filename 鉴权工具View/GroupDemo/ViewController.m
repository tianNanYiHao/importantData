//
//  ViewController.m
//  GroupDemo
//
//  Created by tianNanYiHao on 2017/4/8.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"
#import "GroupView.h"
#import "AuthToolsUtil.h"


@interface ViewController ()
{
    CGSize viewSize;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    viewSize = self.view.bounds.size;
    
    
    
    [self test];
    
//    GroupView *groutView = [[GroupView alloc] initWithFrame:CGRectMake(0, 100, viewSize.width, 200)];
//    groutView.groupViewStyle = GroupViewStyleYes;
//    groutView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:groutView];
    
    
    /**
     *@brief 手机号验证
     *@return CGFloat
     */
//    - (CGFloat)phoneNumVerification;
//    [groutView phoneNumVerification];
    
    /**
     *@brief 密保验证
     *@return CGFloat
     */
//    - (CGFloat)miBaoQuestionVerification;
//    [groutView miBaoQuestionVerification];
    
    
    /**
     *@brief 登录密码验证
     *@return CGFloat
     */
//    - (CGFloat)loginPwdVerification;
//    [groutView loginPwdVerification];
    
    
    /**
     *@brief 短信验证
     *@return CGFloat
     */
//    - (CGFloat)shortMsgVerification;
//    [groutView shortMsgVerification];
    
    
    /**
     *@brief 短信+手机号 验证
     *@return CGFloat
     */
//    - (CGFloat)shortMsgAndPhoneNumVerification;

//    [groutView shortMsgAndPhoneNumVerification];
    
    
    
    
    /**
     *@brief 图片验证
     *@return CGFloat
     */
//    - (CGFloat)pictureVerification;
//    [groutView pictureVerification];
    
    /**
     *@brief 身份证验证
     *@return CGFloat
     */
//    - (CGFloat)IDCardVerification;
//    [groutView IDCardVerification];
    
    /**
     *@brief 真实姓名+身份证 验证
     *@return CGFloat
     */
//    - (CGFloat)realNameAndIDCardVerification;
//    [groutView realNameAndIDCardVerification];
    
    
    /**
     *@brief 银行卡验证
     *@return CGFloat
     */
//    - (CGFloat)bankCardVerification;
//    [groutView bankCardVerification];
    
    /**
     *@brief 信用卡验证
     *@return CGFloat
     */
//    - (CGFloat)creditCardVerification;
//    [groutView creditCardVerification];
    
    /**
     *@brief 杉德卡验证
     *@return CGFloat
     */
//    - (CGFloat)sandCardVerification;
//    [groutView sandCardVerification];
    
    /**
     *@brief 支付密码验证
     *@return CGFloat
     */
//    - (CGFloat)payPwdVerification;
//    [groutView payPwdVerification];
    
    
    
    
    
    

    
    
    
    
    
}

-(void)test{
    
    UIScrollView *scrView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scrView.backgroundColor = [UIColor lightGrayColor];
    scrView.contentSize = CGSizeMake(viewSize.width, viewSize.height*2);
    [self.view addSubview:scrView];
    
    
    AuthToolsUtil *authView = [[AuthToolsUtil alloc] init];
    authView.backgroundColor = [UIColor redColor];
    CGFloat authViewH =  [authView addAuthToolsInfo:@[@"",@"loginpass",@""]];
    authView.frame = CGRectMake(0, 100, viewSize.width, authViewH);
    [scrView addSubview:authView];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
