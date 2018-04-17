//
//  FViewController.m
//  windowsArr
//
//  Created by tianNanYiHao on 2018/4/17.
//  Copyright © 2018年 tianNanYiHao. All rights reserved.
//

#import "FViewController.h"

@interface FViewController ()

@end

@implementation FViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor greenColor];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"%@",[UIApplication sharedApplication].windows);
    NSLog(@"%@",[UIApplication sharedApplication].keyWindow);
    
    [UIApplication sharedApplication].keyWindow.hidden = YES;
    
    
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
