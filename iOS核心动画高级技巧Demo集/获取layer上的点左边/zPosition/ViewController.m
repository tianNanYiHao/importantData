//
//  ViewController.m
//  zPosition
//
//  Created by tianNanYiHao on 2017/8/1.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *viewOne;
@property (nonatomic, strong)CALayer *blueLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
   
    _blueLayer = [CALayer layer];
    _blueLayer.frame = CGRectMake(0, 0, 100, 100);
    _blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    _blueLayer.shadowOpacity = 0.7f;
    _blueLayer.shadowOffset = CGSizeMake(10, 10);
    
    [_viewOne.layer addSublayer:_blueLayer];
    
    
    
    
    

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    BOOL a = NO;
    if (a) {
        //获取触摸的点
        CGPoint point = [[touches anyObject] locationInView:self.view];
        NSLog(@"screenPoint => %@",NSStringFromCGPoint(point));
        
        /*
         方法一:通过获取点以及判断点是否在layer中来判断
         */
        //转换_viewOne在self.view上的位置
        point = [_viewOne.layer convertPoint:point fromLayer:self.view.layer];
        NSLog(@"redPoint =  %@",NSStringFromCGPoint(point));
        
        if ([_viewOne.layer containsPoint:point]) {
            point = [_blueLayer convertPoint:point fromLayer:_viewOne.layer];
            NSLog(@"bluePoint %@",NSStringFromCGPoint(point));
            if ([_blueLayer containsPoint:point]) {
                NSLog(@"在蓝色块中");
            }else{
                NSLog(@"在红色块中");
            }
        }
    }
    
    else{
        /*
         方法二:直接通过判断点所在的layer 是否为我们所要判断的layer
         */
        //获取触摸的点
        CGPoint point2 = [[touches anyObject] locationInView:self.view];
        NSLog(@"screen2Point => %@",NSStringFromCGPoint(point2));
        CALayer *layer = [_viewOne.layer hitTest:point2];
        if (layer == _blueLayer) {
            NSLog(@"在蓝色块中");
        }else{
            NSLog(@"在红色块中");
        }
        
    }
    


    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
