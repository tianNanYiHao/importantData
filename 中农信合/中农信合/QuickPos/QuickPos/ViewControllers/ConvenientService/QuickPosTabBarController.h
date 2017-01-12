//
//  QuickPosTabBarController.h
//  QuickPos
//
//  Created by Leona on 15/3/10.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HandSignViewController.h"

@interface QuickPosTabBarController : UITabBarController<HandSignActionDelegate>

@property(nonatomic,strong)UIViewController *parentCtrl;
@property(nonatomic,retain)OrderData *orderData;
@property (nonatomic,retain)NSString *printInfo;

+ (QuickPosTabBarController*)getQuickPosTabBarController;
- (void)gotoLoginViewCtrl;

@end
