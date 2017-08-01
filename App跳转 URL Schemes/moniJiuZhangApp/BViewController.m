//
//  BViewController.m
//  moniJiuZhangApp
//
//  Created by tianNanYiHao on 2017/7/17.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "BViewController.h"
#import "SandbaoSpsSDK.h"

@interface BViewController ()
@property (weak, nonatomic) IBOutlet UITextField *lab;

@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"😁  订单页";
    self.view.backgroundColor = [UIColor whiteColor];
    _lab.text = _tn;
    
    
    
}
- (IBAction)pay:(id)sender {
    
    //SDK
    [SandbaoSpsSDK jumpToSandBaoForPay:_tn];

}


@end
