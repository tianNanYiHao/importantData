//
//  UITextField+CheckLenght.h
//  selfService
//
//  Created by blue sky on 15/12/30.
//  Copyright © 2015年 sand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (CheckLenght)

//设置最小长度
- (void)setMinLenght:(NSString *)newMinLenght;
- (NSString *)minLenght;

//设置最大长度
- (void)setMaxLenght:(NSString *)newMaxLenght;
- (NSString *)maxLenght;

@end
