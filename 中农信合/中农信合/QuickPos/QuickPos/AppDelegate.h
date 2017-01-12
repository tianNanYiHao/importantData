//
//  AppDelegate.h
//  QuickPos
//
//  Created by 张倡榕 on 15/3/11.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserBaseData.h"

static UserBaseData *userBaseData = nil;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property float autoSizeScaleX;
@property float autoSizeScaleY;
+ (void)storyBoradAutoLay:(UIView *)allView;
+ (void)storyBoradAutoLayOfTableView:(UITableView *)allTableView;
+ (UserBaseData*)getUserBaseData;
+(void)setUserBaseData:(UserBaseData*)_userBaseData;
- (NSDictionary*)getConfigDic;
@end

