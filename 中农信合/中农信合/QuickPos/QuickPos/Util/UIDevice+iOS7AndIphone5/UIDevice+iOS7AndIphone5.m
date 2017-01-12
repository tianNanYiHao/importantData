//
//  UIDevice+iOS7AndIphone5.m
//  KAKUIAPP
//
//  Created by 123 on 13-12-17.
//  Copyright (c) 2013年 huifu. All rights reserved.
//

#import "UIDevice+iOS7AndIphone5.h"
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)


#define iPhone6p ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) : NO)



@implementation UIDevice (iOS7AndIphone5)

- (BOOL)isIOS8
{
    return iOS8;
}

- (BOOL)isIOS7
{
    return iOS7;
}

- (BOOL)isIOS6
{
    return iOS6;
}

- (BOOL) isIphone5
{
    return iPhone5;
}
- (BOOL) isIphone4
{
    return iPhone4;
}

- (BOOL) isIphone6
{
    return iPhone6;
}
- (BOOL) isIphone6p
{
    return iPhone6p;
}

////用于cell
//-(void)cellEdgeInsetsZero:(UITableViewCell*)cell{
//    if([self isIOS7]){
//    
//        [cell setSeparatorInset:UIEdgeInsetsZero];
//
//    
//    }else if ([self isIOS8]){
//        if ([cell respondsToSelector:@selector(setSeparatorInset:)])
//        {
//            [cell setSeparatorInset:UIEdgeInsetsZero];
//        }
//        if ([cell respondsToSelector:@selector(setLayoutMargins:)])
//        {
//            [cell setLayoutMargins:UIEdgeInsetsZero];
//        }
//    
//    }
//
//
//}





@end
