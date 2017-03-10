//
//  NavCoverView.m
//  sandbao
//
//  Created by tianNanYiHao on 2017/3/8.
//  Copyright © 2017年 sand. All rights reserved.
//

#import "NavCoverView.h"
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
@interface NavCoverView(){
    
}
@end

@implementation NavCoverView



+(NavCoverView*)shareNavCoverView:(CGRect)frame title:(NSString*)title style:(NavCoverViewStyle)style{
    
    NavCoverView *v = [[NavCoverView alloc] init];
    v.frame = frame;
    NSArray *arr = [NSArray array];
    if (style == navCoverViewStyle1) {
        arr = @[(__bridge id)RGBACOLOR(0, 92, 151, 1).CGColor,
                (__bridge id)RGBACOLOR(54, 55, 149,1).CGColor
                ];
    }
    if (style == navCoverViewStyle2) {
        arr = @[(__bridge id)RGBACOLOR(102, 204, 102, 1).CGColor,
                (__bridge id)RGBACOLOR(54, 55, 149,1).CGColor
                ];
    }
    if (style == navCoverViewStyle3) {
        arr = @[(__bridge id)RGBACOLOR(204, 51, 102, 1).CGColor,
                (__bridge id)RGBACOLOR(153, 0, 51,1).CGColor
                ];
    }

    //4.渐变色
    CAGradientLayer *layerRGB = [CAGradientLayer layer];
    layerRGB.frame = v.frame;
    layerRGB.startPoint = CGPointMake(0, 0);
    layerRGB.endPoint = CGPointMake(1, 0);
    layerRGB.colors = arr;
    [v.layer addSublayer:layerRGB];
    
    
    //title
    // 1.标题
    UILabel *labTitle = [[UILabel alloc] init];
    labTitle.frame = CGRectMake(15, 20, v.frame.size.width-2*15, 64-20);
    labTitle.text = title;
    labTitle.font = [UIFont systemFontOfSize:17];
    labTitle.textAlignment = NSTextAlignmentCenter;
    labTitle.textColor = [UIColor whiteColor];
    [v addSubview:labTitle];
    
    //leftBtn
    
    //rightBtn
    
    
    return v;
}




@end
