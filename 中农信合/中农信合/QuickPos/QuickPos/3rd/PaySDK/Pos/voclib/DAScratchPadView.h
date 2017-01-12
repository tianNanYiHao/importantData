//
//  DAScratchpadView.h
//  DAScratchPad
//
//  Created by Alex on 5/9/13.
//  Copyright (c) 2013年 www.itron.com.cn All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum {
    //两种类型画笔和喷枪两种
	DAScratchPadToolTypePaint = 0,
	DAScratchPadToolTypeAirBrush
} DAScratchPadToolType;

@interface DAScratchPadView : UIControl

@property (assign) DAScratchPadToolType toolType;
@property (strong,nonatomic) UIColor* drawColor;
@property (assign) CGFloat drawWidth;
@property (assign) CGFloat drawOpacity;
@property (assign) CGFloat airBrushFlow;

- (void) clearToColor:(UIColor*)color;

- (UIImage*) getSketch;
- (void) setSketch:(UIImage*)sketch;

@end
