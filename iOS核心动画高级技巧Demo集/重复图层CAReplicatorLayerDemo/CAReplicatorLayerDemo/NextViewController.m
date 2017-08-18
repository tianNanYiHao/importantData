//
//  NextViewController.m
//  CAReplicatorLayerDemo
//
//  Created by tianNanYiHao on 2017/8/9.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController ()
{
    
}
@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"镜像图";
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
    CATransform3D transform = CATransform3DIdentity;
    
    transform = CATransform3DTranslate(transform, 0, 102, 0);
    transform = CATransform3DScale(transform, 1, -1, 0);
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.repeatCount = 2;
    replicatorLayer.instanceTransform = transform;
    replicatorLayer.instanceAlphaOffset = -0.7f;
    replicatorLayer.contents = (__bridge id)[UIImage imageNamed:@"屏幕快照 2017-08-09 下午2.24.50"].CGImage;
    replicatorLayer.frame =  CGRectMake(100, 100, 100, 100);
    [self.view.layer addSublayer:replicatorLayer];
    

    
    

    
    
    
    
    
    
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
