//
//  MyRunSubWithdrawViewController.h
//  QuickPos
//
//  Created by 张倡榕 on 15/3/6.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyRunSubWithdrawViewController : UIViewController

@property (nonatomic,strong)NSString *name;

@property (nonatomic,assign)NSUInteger destinationType;

@property (weak, nonatomic) IBOutlet UILabel *Notes;

@property (retain, nonatomic) NSDictionary *item;
@end
