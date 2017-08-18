//
//  ViewController.m
//  CGAffintTransformRotateDemo
//
//  Created by tianNanYiHao on 2017/8/2.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"
#import "SecendViewController.h"

#define radian(degrees) ((M_PI*(degrees))/180.f)  //角度转弧度

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *transformView;
@property (nonatomic, strong) CALayer *transformLayer;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    _transformView.image = [UIImage imageNamed:@"屏幕快照 2017-08-02 上午11.14.12"];
    
    _transformLayer = [CALayer layer];
    _transformLayer.frame = CGRectMake(50, 150, 100, 100);
    _transformLayer.contents = (__bridge id)[UIImage imageNamed:@"屏幕快照 2017-08-02 上午11.14.12"].CGImage;
    [self.view.layer addSublayer:_transformLayer];
    
}

//视图/图层的2D仿射变换
- (IBAction)switchClick:(UISwitch *)sender {
    if (sender.on) {
        
        //rotate
        CGAffineTransform rotateTransform = CGAffineTransformMakeRotation(M_PI_4);
        //scale
        CGAffineTransform scaleTransform  = CGAffineTransformScale(rotateTransform, 0.5f, 0.5f);
        //translate
        CGAffineTransform translate       = CGAffineTransformTranslate(scaleTransform, 10, 200);
        
        //view的仿射变化-旋转
        _transformView.transform = rotateTransform;
        
        //layer的仿射变换-旋转
        _transformLayer.affineTransform = translate;
        
    }else{
        
        //rotate
        CGAffineTransform rotateTransform = CGAffineTransformMakeRotation(0);
        //scale
        CGAffineTransform scaleTransform  = CGAffineTransformScale(rotateTransform, 1, 1);
        //translate
        CGAffineTransform translate       = CGAffineTransformTranslate(scaleTransform, 0, 0);
        
        //view的仿射变化-旋转
        _transformView.transform = rotateTransform;
        
        //layer的仿射变换-旋转
        _transformLayer.affineTransform = translate;

        
    }
}

//视图/图层的3D仿射变换
- (IBAction)switchClickTwo:(UISwitch *)sender {
    
    if (sender.on) {
        //围绕y轴旋转30角度
        CATransform3D rotateTransform3D = CATransform3DIdentity;
        rotateTransform3D.m34 = - 1.0 / 500.0;
        rotateTransform3D = CATransform3DRotate(rotateTransform3D, radian(120), 0, 1, 0);
        _transformView.layer.transform = rotateTransform3D;
        _transformLayer.transform = rotateTransform3D;
    }else{
        //围绕y轴归位
        CATransform3D rotateTransform3D = CATransform3DMakeRotation(radian(0), 0, 1, 0);
        
        _transformView.layer.transform = rotateTransform3D;
        _transformLayer.transform = rotateTransform3D;
        
    }
    
}


- (IBAction)btnPunsh:(id)sender {
    
    SecendViewController *sc = [[SecendViewController alloc] init];
    
    [self.navigationController pushViewController:sc animated:YES];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
