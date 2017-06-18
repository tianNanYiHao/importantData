//
//  SDActivityView.h
//  MBPHUDProgressLFFDemo
//
//  Created by tianNanYiHao on 2017/6/18.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDActivityView : UIView



/**
 根据图片创建imageView

 @param imgName imgName 图片名
 @param view imageView
 @param rectWH 宽高
 @return 实例
 */
-(instancetype)initWithImage:(NSString*)imgName view:(UIView*)view rectWH:(CGFloat)rectWH;


@end
