//
//  ViewController.m
//  FixMiniButtenClickMini
//
//  Created by tianNanYiHao on 2017/7/24.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+FixMiniClick.h"
//#import "UIButton+CS_FixMultiClick.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    _btn.acceptEventInterval = 1.9f;
//    _btn.cs_acceptEventInterval = 1.8f;
    
    
}

- (IBAction)clickTest:(id)sender {
    
    NSLog(@"%f",[NSDate date].timeIntervalSince1970);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
