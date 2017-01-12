//
//  CardToCardPayViewController.h
//  QuickPos
//
//  Created by feng Jie on 16/6/19.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardToCardPayViewController : UIViewController

@property (nonatomic,retain)BankCardItem *bankCardItem;
@property (weak, nonatomic) IBOutlet UILabel *notes;
@property (retain, nonatomic) NSDictionary *item;

@end
