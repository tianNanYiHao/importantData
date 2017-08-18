//
//  ViewController.m
//  CATransform3DBox
//
//  Created by tianNanYiHao on 2017/8/2.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"

#define radian(degrees) ((M_PI*(degrees))/180.f)  //角度转弧度

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *vie1;
@property (weak, nonatomic) IBOutlet UIView *vie2;
@property (weak, nonatomic) IBOutlet UIView *vie3;
@property (weak, nonatomic) IBOutlet UIView *vie4;
@property (weak, nonatomic) IBOutlet UIView *vie5;
@property (weak, nonatomic) IBOutlet UIView *vie6;
@property (weak, nonatomic) IBOutlet UIView *contenView;
@property (nonatomic, strong) NSArray *subViewArr;
@property (nonatomic, assign) CGFloat radius;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _radius = _vie1.bounds.size.width/2;
    
    _subViewArr = @[_vie1,_vie2,_vie3,_vie4,_vie5,_vie6];
    
    for (int i=0; i<_subViewArr.count; i++) {
        UIView *v = _subViewArr[i];
        v.layer.borderColor = [UIColor redColor].CGColor;
        v.layer.borderWidth = 0.5f;
        v.hidden = YES;
    }
    
    
}

- (void)addvieSubView:(NSInteger)index transform:(CATransform3D)transform{
    
    UIView *face = _subViewArr[index];
    [_contenView addSubview:face];
    CGSize size = _contenView.bounds.size;
    CGPoint center = CGPointMake(size.width/2, size.height/2);
    face.center = center;
    face.hidden = NO;
    face.layer.transform = transform;
}

- (IBAction)btnclick:(id)sender {
    
    //一.绘制立方体
    CATransform3D pesperctive = CATransform3DIdentity;
    pesperctive.m34 = -1.0/500;
    _contenView.layer.sublayerTransform = pesperctive;
    
    //1
    //页面1 沿Y轴 向镜头方向平移100;
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, _radius);
    [self addvieSubView:0 transform:transform];
    
    //2
    //页面2 沿X轴 向右平移100
    transform = CATransform3DMakeTranslation(_radius, 0, 0);
    //页面2 沿Y轴 旋转90度
    transform = CATransform3DRotate(transform, radian(90) , 0, 1, 0);
    [self addvieSubView:1 transform:transform];
    
    //3
    transform = CATransform3DMakeTranslation(0, -_radius, 0);
    transform = CATransform3DRotate(transform, radian(90) , 1, 0, 0);
    [self addvieSubView:2 transform:transform];
    
    //4
    transform = CATransform3DMakeTranslation(0, _radius, 0);
    transform = CATransform3DRotate(transform, radian(-90) , 1, 0, 0);
    [self addvieSubView:3 transform:transform];
    
    //5
    transform = CATransform3DMakeTranslation(-_radius, 0, 0);
    transform = CATransform3DRotate(transform, radian(-90) , 0, 1, 0);
    [self addvieSubView:4 transform:transform];
    
    //6
    transform = CATransform3DMakeTranslation(0, 0, -_radius);
    transform = CATransform3DRotate(transform, radian(180) , 0, 1, 0);
    [self addvieSubView:5 transform:transform];
    
    
    //2.沿XY轴旋转这个立方体45度
//    pesperctive = CATransform3DRotate(pesperctive, radian(20), 1, 0, 0);
//    pesperctive = CATransform3DRotate(pesperctive, radian(71), 0, 1, 0);
//    _contenView.layer.sublayerTransform = pesperctive;
    
    
    
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    CGPoint point = [[touches anyObject] locationInView:self.view];
    
    //2.沿XY轴旋转这个立方体45度
    CATransform3D transform = CATransform3DMakeRotation(radian(point.x), 1, 0, 0);
    transform = CATransform3DRotate(transform, radian(point.y), 0, 1, 0);
    _contenView.layer.sublayerTransform = transform;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
