//
//  ViewController.m
//  moniJiuZhangApp
//
//  Created by tianNanYiHao on 2017/7/10.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *tnLab;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"这就当做是久璋App吧🙃";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    
}
- (IBAction)jumpBtn:(id)sender {
    //跳转杉德宝
    NSString *urlStr = @"com.sand.sandbao://TN:2094032421?moniJiuZhangApp";
    NSURL *url = [NSURL URLWithString:urlStr];
    
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
