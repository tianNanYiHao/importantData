//
//  ViewController.m
//  OnlyScrollviewRotate
//
//  Created by tianNanYiHao on 2017/9/30.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"
#import "RotateScrollview.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    RotateScrollview *r = [[RotateScrollview alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 150)];
    [self.view addSubview:r];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
