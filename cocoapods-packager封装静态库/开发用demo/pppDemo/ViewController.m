//
//  ViewController.m
//  pppDemo
//
//  Created by tianNanYiHao on 2018/7/11.
//  Copyright © 2018年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"
#import "SOCR.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    SOCR *s = [[SOCR alloc] init];
    [s loadSOCRwith:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
