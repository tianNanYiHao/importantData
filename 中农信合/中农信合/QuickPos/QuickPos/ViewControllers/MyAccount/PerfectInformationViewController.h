//
//  PerfectInformationViewController.h
//  QuickPos
//
//  Created by Leona on 15/3/12.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PerfectInformationViewController : UIViewController

@property (nonatomic,weak)NSString *IDstr;//传值用-身份证号

@property (nonatomic,weak)NSString *realNameStr;//传值用-姓名

@property (nonatomic,strong) NSString *authenFlag;

@end
