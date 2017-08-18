//
//  ViewController.m
//  CAReplicatorLayerDemo
//
//  Created by tianNanYiHao on 2017/8/9.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
    CATransform3D trans = CATransform3DIdentity;
    trans = CATransform3DTranslate(trans, 0, 30, 0);
    trans = CATransform3DRotate(trans, M_PI/5.f, 0, 0,1);
    trans = CATransform3DTranslate(trans, 0, -30, 0);
    
    
    CAReplicatorLayer *replicaLayer = [CAReplicatorLayer layer];
    replicaLayer.frame = self.view.bounds;
    replicaLayer.instanceCount = 10;
    replicaLayer.instanceBlueOffset = -0.1;
    replicaLayer.instanceGreenOffset = -0.1f;
    replicaLayer.instanceTransform = trans;
    [self.view.layer addSublayer:replicaLayer];
    
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(100, 100, 100, 100);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    [replicaLayer addSublayer:layer];
    
    
    
    
    
    
    
    
    
    
    
}
- (IBAction)pppp:(id)sender {
    
    NextViewController *nextVc = [[NextViewController alloc] init];
    [self.navigationController pushViewController:nextVc animated:YES];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
