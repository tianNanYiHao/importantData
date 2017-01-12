//
//  SetupBaseView.h
//  QuickPos
//
//  Created by 胡丹 on 15/4/14.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetupBaseView : UIView
@property (nonatomic,strong)UIViewController *parentCtrl;
@property (nonatomic,strong)UIViewController *superCtrl;
@property (nonatomic,assign)CGRect originFrame;
+ (void)showVersionView:(id)ctrl;
@end
