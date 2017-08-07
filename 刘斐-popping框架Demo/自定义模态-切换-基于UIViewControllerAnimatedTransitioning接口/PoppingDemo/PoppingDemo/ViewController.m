//
//  ViewController.m
//  PoppingDemo
//
//  Created by tianNanYiHao on 2017/8/4.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"
#import "PresetnViewController.h"

#import "PresentAnimatedTransitioning.h"
#import "DismissAnimatedTransitioning.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate>
{
   
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithRed:123/255.0f green:32/255.0f blue:98/255.0f alpha:1];
    
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"======");
    PresetnViewController *p = [[PresetnViewController alloc] init];
    p.transitioningDelegate = self;
    p.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:p animated:YES completion:NULL];
}





#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    return [PresentAnimatedTransitioning new];
    
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [DismissAnimatedTransitioning new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
