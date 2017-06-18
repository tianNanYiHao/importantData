//
//  ViewController.m
//  MBPHUDProgressLFFDemo
//
//  Created by tianNanYiHao on 2017/6/17.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD.h"

#import "SDMBProgressView.h"
#import "SDActivityView.h"


@interface ViewController ()
{
    MBProgressHUD *hud;
    SDMBProgressView *HUD;
    
    
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

 
    
    
    
}




- (IBAction)showHUD:(id)sender {
  
    HUD = [SDMBProgressView showSDMBProgressOnlyLoadingINView:[self.view.window.subviews objectAtIndex:0]];
}

- (IBAction)btn2:(id)sender {
    HUD = [SDMBProgressView showSDMBProgressOnlyLoadingINViewImg:[self.view.window.subviews objectAtIndex:0]];
}
- (IBAction)btn3:(id)sender {
    HUD = [SDMBProgressView showSDMBProgressLoadErrorINView:[self.view.window.subviews objectAtIndex:0]];
}
- (IBAction)btn4:(id)sender {
    
    HUD = [SDMBProgressView showSDMBProgressLoadErrorImgINView:[self.view.window.subviews objectAtIndex:0]];
}
- (IBAction)btn5:(id)sender {
    
    HUD = [SDMBProgressView showSDMBProgressNormalINView:[self.view.window.subviews objectAtIndex:0] lableText:@"常规模式"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [HUD hiddenDelay:1.0f];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
