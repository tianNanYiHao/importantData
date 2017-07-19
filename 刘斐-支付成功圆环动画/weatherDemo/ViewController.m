//
//  ViewController.m
//  weatherDemo
//
//  Created by tianNanYiHao on 2017/7/13.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"
#import "LFFCircleSuccessView.h"
#define RRBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
@interface ViewController ()
{
    LFFCircleSuccessView *circleSuccessView;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RRBA(0, 0, 51, 1);
    
    
    
    circleSuccessView = [LFFCircleSuccessView createCircleSuccessView:CGRectMake(50, 100, 100, 100)];
    circleSuccessView.center = CGPointMake(self.view.frame.size.width/2, 200);
    
    
    circleSuccessView.circleLineWidth = 6.5f;
    circleSuccessView.circleBackGroundColor = RRBA(133, 133, 133, 1);
    circleSuccessView.circleLineColor = RRBA(42, 167, 220, 1);
    circleSuccessView.lineSuccessColor = RRBA(29, 204, 140, 1);
    
    [circleSuccessView buildPath];
    
    [circleSuccessView animationStart];
    
    [self.view addSubview:circleSuccessView];
    
    
}

//
- (IBAction)rotateClick:(id)sender {
    

    [circleSuccessView clearAllLayer];
    
    [circleSuccessView animationAgainStart];
    



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
