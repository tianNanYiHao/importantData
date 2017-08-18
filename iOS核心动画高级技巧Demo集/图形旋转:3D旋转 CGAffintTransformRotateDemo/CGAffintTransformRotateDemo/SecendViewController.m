//
//  SecendViewController.m
//  CGAffintTransformRotateDemo
//
//  Created by tianNanYiHao on 2017/8/2.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "SecendViewController.h"
#define radian(degrees) ((M_PI*(degrees))/180.f)  //角度转弧度
@interface SecendViewController ()
{
    UIView *backGroundView;
    UIView *view1;
    UIView *view2;
    UIButton *btn1;
    
}
@end

@implementation SecendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"2";
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn1 addTarget:self action:@selector(ss) forControlEvents:UIControlEventTouchUpInside];
    btn1.backgroundColor = [UIColor redColor];
    btn1.frame = CGRectMake(150, 64+150+20, 30, 30);
    [self.view addSubview:btn1];
    
    
    
    
    backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0,64, 300,150)];
    backGroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backGroundView];
    
    
    view1 = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
    view1.layer.contents = (__bridge id)[UIImage imageNamed:@"屏幕快照 2017-08-02 上午11.14.12"].CGImage;
    [backGroundView addSubview:view1];
    
    
    view2 = [[UIView alloc] initWithFrame:CGRectMake(130, 20, 100, 100)];
    view2.layer.contents = (__bridge id)[UIImage imageNamed:@"屏幕快照 2017-08-02 上午11.14.12"].CGImage;
    [backGroundView addSubview:view2];
    
    
    
    
    
    

    
    
    
}

- (void)ss{
    //设置此视图下统一的3D透视变换
    CATransform3D perspaective = CATransform3DIdentity;
    perspaective.m34 = -1.0/500.f;
    backGroundView.layer.sublayerTransform = perspaective;
    
    CATransform3D rotationY = CATransform3DRotate(perspaective, radian(45), 0, 1, 0);
    view1.layer.transform = rotationY;
    
    CATransform3D rotationYDef = CATransform3DRotate(perspaective, radian(-45), 0, 1, 0);
    view2.layer.transform = rotationYDef;
    
    
    
    
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
