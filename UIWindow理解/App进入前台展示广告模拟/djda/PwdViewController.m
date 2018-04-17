//
//  PwdViewController.m
//  djda
//
//  Created by tianNanYiHao on 2018/4/17.
//  Copyright © 2018年 tianNanYiHao. All rights reserved.
//

#import "PwdViewController.h"

@interface PwdViewController ()

@end

@implementation PwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];
    
    UIImageView *imgeV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"屏幕快照 2018-04-17 下午2.59.09"]];
    [self.view addSubview:imgeV];
    imgeV.frame = [UIScreen mainScreen].bounds;
    
    
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    [UIApplication sharedApplication].keyWindow.hidden = YES;
    
    NSLog(@"%@",[UIApplication sharedApplication].keyWindow);
    
    
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
