//
//  ViewController.m
//  viewControllerTransitioning
//
//  Created by tianNanYiHao on 2018/3/27.
//  Copyright © 2018年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"
#import "TwoViewController.h"
#import "EPModalPresentation.h"
@interface ViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    TwoViewController *vc2 = [[TwoViewController alloc] init];
    vc2.modalPresentationStyle = UIModalPresentationCustom;
    vc2.transitioningDelegate = self;
    [self presentViewController:vc2 animated:YES completion:nil];
    
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [[EPModalPresentation alloc] initWithStyle:EPModalPresentationPresent];
    
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [[EPModalPresentation alloc] initWithStyle:EPModalPresentationDismiss];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
