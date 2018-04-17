//
//  ViewController.m
//  windowsArr
//
//  Created by tianNanYiHao on 2018/4/17.
//  Copyright © 2018年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"

#import "FViewController.h"
@interface ViewController ()
@property (nonatomic, strong) UIWindow *wind1;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"%@",[UIApplication sharedApplication].windows);
    NSLog(@"%@",[UIApplication sharedApplication].keyWindow);
    
    FViewController *fvc = [[FViewController alloc] init];
    
    self.wind1 = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.wind1.rootViewController = fvc;
    [self.wind1 makeKeyAndVisible];
    

    
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
