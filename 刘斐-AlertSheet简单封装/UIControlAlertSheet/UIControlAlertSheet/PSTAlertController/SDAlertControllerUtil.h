//
//  SDAlertControllerUtil.h
//  UIControlAlertSheet
//
//  Created by tianNanYiHao on 2017/9/1.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^SDAlertControllerActionBlock)(NSInteger index);

@interface SDAlertControllerUtil : NSObject



//PSTAlertControllerStyleActionSheet 模式
+ (void)showAlertControllerWihtTitle:(NSString*)title message:(NSString*)message actionArray:(NSArray*)actionArray presentedViewController:(UIViewController*)viewController actionBlock:(SDAlertControllerActionBlock)actionBlock;


@end
