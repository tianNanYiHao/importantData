//
//  ViewController.m
//  SDSelectBarView
//
//  Created by tianNanYiHao on 2017/12/4.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"
#import "SDSelectBarView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor blueColor];
    
    SDSelectBarView *s  = [SDSelectBarView showSelectBarView:@[@"话费",@"吃饭",@"加油卡",@"生活缴费"] selectBarBlock:^(NSInteger index) {
        
        NSLog(@"点击了:%ld",(long)index);
        
    }];
    s.frame = CGRectMake(0, 100, s.frame.size.width, s.frame.size.height);
    [self.view addSubview:s];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
