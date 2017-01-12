//
//  TSTWechatViewController.m
//  QuickPos
//
//  Created by Lff on 16/9/29.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "TSTWechatViewController.h"
#import "LBXScanWrapper.h"
#import "LBXAlertAction.h"
#import "XYSwitch.h"
#import "Request.h"
#import "ZFBViewController.h"
#import "MBProgressHUD+Add.h"
#import "Common.h"
#import "RadioButton.h"
#import "ZFBViewController.h"


@interface TSTWechatViewController ()<ResponseData>
{
    UIImageView *_imageVIew;
    
    int buttonTag;//提现属性标记
    NSString *cashType;//提现类型
    
    Request *req;
    NSString *payTool;
    
    NSString *merchantId;   //商户商家id
    NSString *productId;
}
@property (weak, nonatomic) IBOutlet RadioButton *btnTwo;
@property (weak, nonatomic) IBOutlet RadioButton *btnOne;
@property (weak, nonatomic) IBOutlet UITextField *textfiledCash;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@end

@implementation TSTWechatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"微信收款";
    
    [self PromptTip];
    payTool = @"01";
    req = [[Request alloc]initWithDelegate:self];
    self.textfiledCash.layer.masksToBounds = YES;
    self.textfiledCash.layer.cornerRadius = 1;
    self.textfiledCash.layer.borderColor = [[UIColor greenColor] CGColor];
    _textfiledCash.keyboardType = UIKeyboardTypeDecimalPad;
    _btnOne.groupButtons = @[_btnOne,_btnTwo];
    _btnOne.selected = YES;
    merchantId = @"0001000006";
    productId = @"0000000002";

}
//tip
- (void)PromptTip
{
    UIView *tip = [Common tipWithStr:@"待定待定待定" color:[UIColor redColor] rect:CGRectMake(0, CGRectGetMaxY(_commitBtn.frame)+270, self.view.frame.size.width, 40)];
    [self.view addSubview:tip];
    
}
//T+0 //T+1
- (IBAction)chooseBtn:(RadioButton*)sender {
    if (sender.tag == 11) {   //T+0
        merchantId = @"0001000006";
        productId = @"0000000002";
    }
    else if (sender.tag == 22){
        merchantId = @"0001000006";
        productId = @"0000000003";
    }
    
}

- (IBAction)commitEwm:(id)sender {
    if (_textfiledCash.text.length == 0) {
        [Common showMsgBox:@"" msg:@"请输入收款金额" parentCtrl:self];
    }else if([_textfiledCash.text integerValue]<5 ){
        [Common showMsgBox:@"" msg:@"收款金额请勿小于5元" parentCtrl:self];
    }else if([_textfiledCash.text length]>100000000){
        [Common showMsgBox:@"" msg:@"输入金额有误" parentCtrl:self];
    }
    else{
        _textfiledCash.text = [NSString stringWithFormat:@"%.2f",[_textfiledCash.text floatValue]];
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        ZFBViewController *WechatVc = [mainStoryboard instantiateViewControllerWithIdentifier:@"ZFBVc"];
        WechatVc.AmtNO = _textfiledCash.text;
        WechatVc.cardNum = self.WeChatBankCardNum;
        WechatVc.merchantId = merchantId;
        WechatVc.productId = productId;
        WechatVc.infoArr = @[WXMERCHANTCODE,WXBACKURL,WXKEY];
        [self.navigationController pushViewController:WechatVc animated:YES];
    }
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
