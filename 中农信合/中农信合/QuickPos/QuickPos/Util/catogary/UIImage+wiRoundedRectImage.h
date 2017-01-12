//
//  UIImage+wiRoundedRectImage.h
//  testNavi
//
//  Created by Leona on 15/4/10.
//  Copyright (c) 2015年 Leona. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (wiRoundedRectImage)
+ (id)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(NSInteger)r;
@end
