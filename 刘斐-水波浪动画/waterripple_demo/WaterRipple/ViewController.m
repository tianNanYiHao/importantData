//
//  ViewController.m
//  WaterRipple
//
//  Created by Liyn on 2017/5/24.
//  Copyright © 2017年 Liyn. All rights reserved.
//

#import "ViewController.h"
#import "WaterRippleView.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor darkGrayColor];
    
//    WaterRippleView *view1 = [[WaterRippleView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 50)];
//    [self.view addSubview:view1];
//    
//    WaterRippleView *view2 = [[WaterRippleView alloc] initWithFrame:CGRectMake(0, 170, self.view.frame.size.width, 50)
//                                                    mainRippleColor:[UIColor colorWithRed:255/255.0f green:127/255.0f blue:80/255.0f alpha:1]
//                                                   minorRippleColor:[UIColor whiteColor]];
//    [self.view addSubview:view2];
//
//    WaterRippleView *view3 = [[WaterRippleView alloc] initWithFrame:CGRectMake(0, 240, self.view.frame.size.width, 50)
//                                                    mainRippleColor:[UIColor colorWithRed:253/255.0 green:183/255.0 blue:106/255.0 alpha:1]
//                                                   minorRippleColor:[UIColor colorWithRed:253/255.0 green:158/255.0 blue:61/255.0 alpha:1]
//                                                  mainRippleoffsetX:1.0f
//                                                 minorRippleoffsetX:1.1f
//                                                        rippleSpeed:2.0f
//                                                     ripplePosition:35.0f
//                                                    rippleAmplitude:5.0f];
//    [self.view addSubview:view3];
//    
//    WaterRippleView *view4 = [[WaterRippleView alloc] initWithFrame:CGRectMake(0, 310, self.view.frame.size.width, 50)
//                                                    mainRippleColor:[UIColor colorWithRed:0/255.0 green:217/255.0 blue:220/255.0 alpha:1]
//                                                   minorRippleColor:[UIColor colorWithRed:2/255.0 green:142/255.0 blue:208/255.0 alpha:1]
//                                                  mainRippleoffsetX:1.0f
//                                                 minorRippleoffsetX:1.2f
//                                                        rippleSpeed:2.5f
//                                                     ripplePosition:30.0f
//                                                    rippleAmplitude:5.0f];
//    [self.view addSubview:view4];
//    
//    WaterRippleView *view5 = [[WaterRippleView alloc] initWithFrame:CGRectMake(0, 380, self.view.frame.size.width, 50)
//                                                    mainRippleColor:[UIColor colorWithRed:0/255.0 green:217/255.0 blue:220/255.0 alpha:1]
//                                                   minorRippleColor:[UIColor colorWithRed:73/255.0 green:128/255.0 blue:247/255.0 alpha:1]
//                                                  mainRippleoffsetX:1.0f
//                                                 minorRippleoffsetX:1.2f
//                                                        rippleSpeed:3.0f
//                                                     ripplePosition:25.0f
//                                                    rippleAmplitude:5.0f];
//    [self.view addSubview:view5];
    
    WaterRippleView *view6 = [[WaterRippleView alloc] initWithFrame:CGRectMake(0, 450, self.view.frame.size.width, 50)
                                                    mainRippleColor:[UIColor colorWithRed:0/255.0 green:217/255.0 blue:220/255.0 alpha:1]
                                                   minorRippleColor:[UIColor colorWithRed:0/255.0 green:169/255.0 blue:98/255.0 alpha:1]
                                                  mainRippleoffsetX:3.0f
                                                 minorRippleoffsetX:2.2f
                                                        rippleSpeed:6.5f
                                                     ripplePosition:20.0f
                                                    rippleAmplitude:5.0f];
    [self.view addSubview:view6];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
