//
//  ViewController.m
//  UIControlAlertSheet
//
//  Created by tianNanYiHao on 2017/9/1.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"
#import "SDAlertControllerUtil.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    

    
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSArray *actionArr = @[@"我的",@"你的",@"取消"];
    [SDAlertControllerUtil showAlertControllerWihtTitle:@"标题" message:@"消息" actionArray:actionArr presentedViewController:self actionBlock:^(NSInteger index) {
       
        if (index == 0) {
            NSLog(@"我的");
        }
        if (index == 1) {
            NSLog(@"你的");
        }
        if (index == 2) {
            NSLog(@"取消");
        }
        
        
    }];
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
