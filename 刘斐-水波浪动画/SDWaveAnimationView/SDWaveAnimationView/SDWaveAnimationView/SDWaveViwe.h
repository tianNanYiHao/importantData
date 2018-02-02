//
//  SDWaveViwe.h
//  SDWaveAnimationView
//
//  Created by tianNanYiHao on 2017/8/25.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDWaveViwe : UIView

#pragma mark - 控制水波上涨动画的属性

/**
 水波上涨动画 - 最终刻度
 */
@property (nonatomic , assign) float waveUpRang;


/**
 水波上涨动画 - 上涨速度
 */
@property (nonatomic , assign) float waveUpSpeed;



#pragma mark - 控制水波波动动画的属性

@property (nonatomic, assign) float wavaChangeSpeed;

/**
 水波波动动画 - 波动振幅
 */
@property (nonatomic , assign) float waveChangA;


@end
