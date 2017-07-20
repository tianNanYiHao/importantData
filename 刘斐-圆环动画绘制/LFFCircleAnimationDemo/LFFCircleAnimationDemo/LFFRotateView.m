//
//  LFFRotateView.m
//  LFFCircleAnimationDemo
//
//  Created by tianNanYiHao on 2017/7/12.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "LFFRotateView.h"

//角度转弧度
#define radian(degree) ((M_PI*(degree))/180.f)

@interface LFFRotateView (){
    
    CGAffineTransform transform;
    
}

@end

@implementation LFFRotateView


- (instancetype)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        //保存当前的transform
        transform = self.transform;
        
    }return self;
    
}



-(void)rotateAngle:(CGFloat)angle duration:(CGFloat)duration{
    
    [UIView animateWithDuration:duration animations:^{
       
        self.transform = CGAffineTransformRotate(transform,radian(angle));
        
    }];
    
}


- (void)rotateAngle:(CGFloat)angle{
    
    self.transform = CGAffineTransformRotate(transform, radian(angle));
    
    
}



@end
