//
//  MyViewController.m
//  CustomNavgationBar
//
//  Created by tianNanYiHao on 2017/3/9.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "MyViewController.h"
#import "MSecondViewController.h"

@interface MyViewController ()
{
    MSecondViewController *msecondVC;
}
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIButton *push = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    push.frame = CGRectMake(15, 64, self.view.bounds.size.width-30, 50);
    push.backgroundColor = [UIColor whiteColor];
    push.titleLabel.text = @"push";
    push.titleLabel.textColor = [UIColor darkGrayColor];
    push.layer.cornerRadius = 5.0f;
    push.layer.masksToBounds = YES;
    [push addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:push];
    
    msecondVC = [[MSecondViewController alloc] init];
    

    
}
-(void)push:(UIButton*)btn
{
    [self.navigationController pushViewController:msecondVC animated:YES];
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
