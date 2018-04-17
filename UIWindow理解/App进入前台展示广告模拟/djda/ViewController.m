//
//  ViewController.m
//  djda
//
//  Created by tianNanYiHao on 2018/4/17.
//  Copyright © 2018年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImageView *imgeV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"屏幕快照 2018-04-17 下午3.00.02"]];
    [self.view addSubview:imgeV];
    imgeV.frame = [UIScreen mainScreen].bounds;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
