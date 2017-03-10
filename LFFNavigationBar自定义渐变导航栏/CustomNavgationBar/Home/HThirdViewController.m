//
//  ThirdViewController.m
//  CustomNavgationBar
//
//  Created by tianNanYiHao on 2017/3/9.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "HThirdViewController.h"
#import "LFFNavigationBar.h"

@interface HThirdViewController ()

@end

@implementation HThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"我的命Load");
    
    [self setNavGationBarStyle];
    
}

-(void)setNavGationBarStyle{
    
    LFFNavigationBar *lffNavBar = [[LFFNavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64) lffNavgationBarStyle:LFFNavgationBarOnlyGoBack leftBLOCK:^() {
        [self.navigationController popViewControllerAnimated:YES];
    } rightBLOCK:^() {
        
    }];
    lffNavBar.titleName = @"Home3";
    lffNavBar.leftBtnImageName = @"back";
    [lffNavBar addLFFNavgationBar];
    [self.view addSubview:lffNavBar];
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
