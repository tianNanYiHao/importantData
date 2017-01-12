//
//  SDJBankListTableViewCell.h
//  QuickPos
//
//  Created by feng Jie on 16/9/7.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDJBankListTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *bankLogo;//银行卡logo


@property (weak, nonatomic) IBOutlet UILabel *BankcardNo;//银行卡号

@property (weak, nonatomic) IBOutlet UILabel *BankName;//银行名称

@end
