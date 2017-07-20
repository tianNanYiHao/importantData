//
//  EyeMouthLayerLff.m
//  customFaceSwitchLFF
//
//  Created by Lff on 17/1/3.
//  Copyright © 2017年 Lff. All rights reserved.
//
#import "EyeMouthLayerLff.h"
#import <UIKit/UIKit.h>
@implementation EyeMouthLayerLff

- (instancetype)init{
    if (self = [super init]) {
        self.eyeRect = CGRectMake(0, 0, 0, 0);
    }return self;
}


- (instancetype)initWithLayer:(EyeMouthLayerLff *)layer {
    self = [super initWithLayer:layer];  //重写方法 确保眼睛/嘴部的颜色 和位置不断重置
    if (self) {
        self.eyeRect = layer.eyeRect;
        self.eyeSpace = layer.eyeSpace;
        self.eyeColor = layer.eyeColor;
        self.mouthY = layer.mouthY;
        self.isHappy = layer.isHappy;
    }
    return self;
}

-(void)drawInContext:(CGContextRef)ctx{
    UIBezierPath *bezierLeft = [UIBezierPath bezierPathWithOvalInRect:_eyeRect];
    UIBezierPath *bezierRight = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(_eyeSpace, _eyeRect.origin.y, _eyeRect.size.width, _eyeRect.size.height)];
    CGContextAddPath(ctx, bezierLeft.CGPath);
    CGContextAddPath(ctx, bezierRight.CGPath);
    CGContextSetFillColorWithColor(ctx, _eyeColor.CGColor);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextFillPath(ctx);
    

    
    //mouth
    
    if (_isHappy) {
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_eyeRect.size.width, 5) radius:_eyeSpace*3/2 startAngle:M_PI_2 endAngle:M_PI_4 clockwise:NO];
        CGContextAddPath(ctx, path.CGPath);
        CGContextSetFillColorWithColor(ctx, _eyeColor.CGColor);
        CGContextFillPath(ctx);
    }else{
        
    }

    
}

+(BOOL)needsDisplayForKey:(NSString *)key{
    if ([key isEqualToString:@"mouthOpenClose"]) {
        return YES;
    }
    if ([key isEqualToString:@"eyeRect"]) {
        return YES;
    }
    return [super needsDisplayForKey:key];
    
}

@end
