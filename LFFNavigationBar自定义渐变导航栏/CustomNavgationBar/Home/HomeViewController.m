//
//  HomeViewController.m
//  CustomNavgationBar
//
//  Created by tianNanYiHao on 2017/3/9.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "HomeViewController.h"
#import "HSecondViewController.h"

#import "LFFNavigationBar.h"

@interface HomeViewController ()
{
    HSecondViewController *secVC;
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    self.navigationItem.title = @"Home";
    
    UIButton *push = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    push.frame = CGRectMake(15, 64, self.view.bounds.size.width-30, 50);
    push.backgroundColor = [UIColor whiteColor];
    push.titleLabel.text = @"push";
    push.titleLabel.textColor = [UIColor darkGrayColor];
    push.layer.cornerRadius = 5.0f;
    push.layer.masksToBounds = YES;
    [push addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:push];
    
    secVC = [[HSecondViewController alloc] init];
    
    [self setNavGationBarStyle];
    
}
-(void)setNavGationBarStyle{
    
    LFFNavigationBar *lffNavBar = [[LFFNavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64) lffNavgationBarStyle:LFFNavgationBarDeful leftBLOCK:^() {
        
    } rightBLOCK:^() {
        
    }];
    lffNavBar.titleName = @"Home1";
    [lffNavBar addLFFNavgationBar];
    [self.view addSubview:lffNavBar];
}


-(void)push:(UIButton*)btn{
    
    [self.navigationController pushViewController:secVC animated:YES];
    
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
