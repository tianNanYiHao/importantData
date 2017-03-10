//
//  LFFTabBarController.m
//  CustomNavgationBar
//
//  Created by tianNanYiHao on 2017/3/9.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "LFFTabBarController.h"

#import "LFFNavigationControllerViewController.h"  //自定义的导航控制器

#import "HomeViewController.h"
#import "MyViewController.h"
#import "YourViewController.h"

@interface LFFTabBarController ()

@end

@implementation LFFTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1. 设置TabBar的样式
    [self setTabBar];
    
    //2. 设置各自的 子 导航控制器
    [self setSubNavGationController];
    

}

-(void)setTabBar{
    //1.设置按钮,title颜色
    self.tabBar.tintColor = [UIColor redColor];
    //2.设置tabBar 显示出来的 颜色
    self.tabBar.barTintColor = [UIColor greenColor];
}

-(void)setSubNavGationController{
    
    //1.设置三个主要VC 以及title , 图片
    HomeViewController *home = [[HomeViewController alloc] init];
    home.tabBarItem.title = @"home";
    home.tabBarItem.image = [UIImage imageNamed:@"back"];
    
    
    MyViewController *my = [[MyViewController alloc] init];
    my.tabBarItem.title = @"my";
    my.tabBarItem.image = [UIImage imageNamed:@"back"];
    
    
    YourViewController *you = [[YourViewController alloc] init];
    you.tabBarItem.title = @"you";
    you.tabBarItem.image = [UIImage imageNamed:@"back"];
    
    //2.为三个控制器各自添加到 自定义的导航控制器上
    LFFNavigationControllerViewController *homeLffNav = [[LFFNavigationControllerViewController alloc] initWithRootViewController:home];
    LFFNavigationControllerViewController *myLffNav = [[LFFNavigationControllerViewController alloc] initWithRootViewController:my];
    LFFNavigationControllerViewController *youLffNav = [[LFFNavigationControllerViewController alloc] initWithRootViewController:you];
    
    
    //3.UITabBarController控制器中添加三个被管理对象
    self.viewControllers = @[homeLffNav,myLffNav,youLffNav];
    
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
