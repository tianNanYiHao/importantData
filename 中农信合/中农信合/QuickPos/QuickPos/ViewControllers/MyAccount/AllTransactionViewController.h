//
//  AllTransactionViewController.h
//  QuickPos
//
//  Created by Leona on 15/4/2.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllTransactionViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *AlltransactionTableView;

- (void)loadData;
@end
