//
//  BankListTableViewCell.m
//  QuickPos
//
//  Created by Leona on 15/3/13.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "BankListTableViewCell.h"

@implementation BankListTableViewCell
@synthesize bankLogoImageView;
@synthesize bankNameLabel;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
