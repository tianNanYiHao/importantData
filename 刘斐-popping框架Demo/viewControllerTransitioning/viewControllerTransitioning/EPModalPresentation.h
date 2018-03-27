//
//  EPModalPresentation.h
//  viewControllerTransitioning
//
//  Created by tianNanYiHao on 2018/3/27.
//  Copyright © 2018年 tianNanYiHao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,EPModalPresentationStyle){
    
    EPModalPresentationPresent = 1,
    EPModalPresentationDismiss
};

@interface EPModalPresentation : NSObject<UIViewControllerAnimatedTransitioning>


/**
 切换动画时长
 */
@property (nonatomic,assign)NSTimeInterval transitionDuration;

- (instancetype)initWithStyle:(EPModalPresentationStyle)style;


@end
