//
//  TransactionRecordsTableViewCell.h
//  QuickPos
//
//  Created by Leona on 15/4/2.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransactionRecordsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleNameLabel;//标题

@property (weak, nonatomic) IBOutlet UILabel *dataLabel;//日期

@property (weak, nonatomic) IBOutlet UILabel *amountLabel;//金额

@end
