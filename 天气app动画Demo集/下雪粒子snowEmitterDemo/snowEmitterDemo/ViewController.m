//
//  ViewController.m
//  snowEmitterDemo
//
//  Created by tianNanYiHao on 2017/7/6.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"
#import "SnowView.h"
#import "RainView.h"

#define  Width   [UIScreen mainScreen].bounds.size.width
#define  Height  [UIScreen mainScreen].bounds.size.height

@interface ViewController ()
@property (nonatomic, strong) SnowView                *snow;            // 下雪
@property (nonatomic, strong) EmitterLayerView *weatherConditionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
    self.view.backgroundColor = [UIColor blackColor];
    self.view.alpha = 0.8f;
    
    
    
    
    
    [self snowSub];

 
}


- (void)snowSub{
    self.snow = [[SnowView alloc] initWithFrame:CGRectMake(Width/4 , 100, Width / 2.f, Width / 2.f)];
    [self.view addSubview:self.snow];
    self.snow.snowImage  = [UIImage imageNamed:@"snow"];
    self.snow.birthRate  = 20.f;
    self.snow.gravity    = 5.f;
    self.snow.snowColor  = [UIColor whiteColor];
    self.snow.layer.mask = [ViewController createMaskLayerWithSize:CGSizeMake(Width / 2.f, Width / 2.f)
                                                      maskPNGImage:[UIImage imageNamed:@"alpha"]];
    [self.snow showSnow];
    self.snow.transform  = CGAffineTransformMake(1.4, 0, 0, 1.4, 0, 0);
    
    
    //水平翻转(由于这里是重力效果,所以水平翻转以后还是垂直效果)
    //    self.snow.transform  = CGAffineTransformMakeScale(-1, 1);
    
    
    //垂直翻转
    self.snow.transform  = CGAffineTransformMakeScale(1, -1);
    
    //平移
    //    self.snow.transform = CGAffineTransformMakeTranslation(100, 10);
    
    //旋转(在当前效果上添加旋转)
    CGFloat angle = ([UIImage imageNamed:@"alpha"].size.width/2) * M_PI_4;
    //    self.snow.transform = CGAffineTransformRotate(self.snow.transform,angle);
    
    
}


+ (CALayer *)createMaskLayerWithSize:(CGSize)size maskPNGImage:(UIImage *)image {
    
    CALayer *layer    = [CALayer layer];
    layer.anchorPoint = CGPointMake(0, 0);                          // 重置锚点
    layer.bounds      = CGRectMake(0, 0, size.width, size.height);  // 设置尺寸
    
    if (image) {
        
        layer.contents = (__bridge id)(image.CGImage);
    }
    
    return layer;
}


- (void)emitterView{
    
    
    
    
    
    
    
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
