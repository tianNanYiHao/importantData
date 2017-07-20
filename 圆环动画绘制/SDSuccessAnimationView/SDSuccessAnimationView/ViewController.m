//
//  ViewController.m
//  SDSuccessAnimationView
//
//  Created by tianNanYiHao on 2017/7/19.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"
#import "SDSuccessAnimationView.h"
#define RRBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
@interface ViewController ()
{
    SDSuccessAnimationView *circleSuccessView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    circleSuccessView = [SDSuccessAnimationView createCircleSuccessView:CGRectMake(50, 100, 100, 100)];
    circleSuccessView.center = CGPointMake(self.view.frame.size.width/2, 200);
    
    
    circleSuccessView.circleLineWidth = 6.5f;
    
    circleSuccessView.lineSuccessColor = RRBA(29, 204, 140, 1);
    
    [self.view addSubview:circleSuccessView];
    
    
    
 
    
}
- (IBAction)dd:(id)sender {
    
    [circleSuccessView clearAllLayer];
    
    [circleSuccessView animationAgainStart];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
