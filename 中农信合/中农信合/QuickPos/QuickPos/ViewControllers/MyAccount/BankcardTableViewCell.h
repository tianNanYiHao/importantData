//
//  BankcardTableViewCell.h
//  QuickPos
//
//  Created by Leona on 15/3/12.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BankcardTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cardNumberLabel;//卡号
@property (weak, nonatomic) IBOutlet UILabel *bankNameLabel;//银行
@property (weak, nonatomic) IBOutlet UILabel *cardTypeLabel;//卡类型
@property (weak, nonatomic) IBOutlet UIImageView *bankLogoImageView;//银行logo

@property (weak, nonatomic) IBOutlet UIView *cellBG;//cell的背景


@end
