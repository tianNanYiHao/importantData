//
//  ViewController.m
//  customFaceSwitchLFF
//
//  Created by Lff on 16/12/30.
//  Copyright © 2016年 Lff. All rights reserved.
//

#import "ViewController.h"
#import "SwitchLff.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    SwitchLff *lffVie = [[SwitchLff alloc] initWithFrame:CGRectMake(100, 100, 120, 60)];
    [self.view addSubview:lffVie];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
