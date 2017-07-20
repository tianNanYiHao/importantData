//
//  EyeMouthLayerLff.h
//  customFaceSwitchLFF
//
//  Created by Lff on 17/1/3.
//  Copyright © 2017年 Lff. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
@interface EyeMouthLayerLff : CALayer

@property (nonatomic,assign)CGRect eyeRect;
@property (nonatomic,assign)CGFloat eyeSpace;
@property (nonatomic,strong)UIColor *eyeColor;
@property (nonatomic,assign)CGFloat mouthY;
@property (nonatomic,assign)BOOL isHappy;





@end
