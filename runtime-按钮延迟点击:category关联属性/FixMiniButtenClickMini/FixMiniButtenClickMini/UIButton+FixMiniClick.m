//
//  UIButton+FixMiniClick.m
//  sandbao
//
//  Created by tianNanYiHao on 2017/7/24.
//  Copyright © 2017年 sand. All rights reserved.
//

#import "UIButton+FixMiniClick.h"
#import <objc/runtime.h>


@implementation UIButton (FixMiniClick)

// 因category不能添加属性，只能通过关联对象的方式。


static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";
/**
 get方法
 */
- (NSTimeInterval)acceptEventInterval{
    return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}
/**
 set方法
 */
- (void)setAcceptEventInterval:(NSTimeInterval)acceptEventInterval{
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static const char *UIControl_acceptEventTime = "UIControl_acceptEventTime";

/**
 get方法

 */
- (NSTimeInterval)acceptEventTime{
    return [objc_getAssociatedObject(self, UIControl_acceptEventTime) doubleValue];
}

/**
 set方法

 */
- (void)setAcceptEventTime:(NSTimeInterval)acceptEventTime{
    objc_setAssociatedObject(self, UIControl_acceptEventTime, @(acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


//在load时hock
+ (void)load{
    Method befor = class_getClassMethod(self, @selector(sendAction:to:forEvent:));
    Method after = class_getClassMethod(self, @selector(delaySendAction:to:forEvent:));
    method_exchangeImplementations(befor, after);
    
}
- (void)delaySendAction:(SEL)action to:(id)target forEvent:(UIEvent*)event{
    
    if ([NSDate date].timeIntervalSince1970 - self.acceptEventTime < self.acceptEventInterval) {
        return;
    }
    if (self.acceptEventInterval>0) {
        self.acceptEventTime = [NSDate date].timeIntervalSince1970;
    }
    
    [self delaySendAction:action to:target forEvent:event];
}





@end
