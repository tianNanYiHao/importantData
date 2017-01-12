//
//  BankcardTableViewCell.m
//  QuickPos
//
//  Created by Leona on 15/3/12.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "BankcardTableViewCell.h"

@implementation BankcardTableViewCell

@synthesize cardNumberLabel;
@synthesize bankNameLabel;
@synthesize cardTypeLabel;
@synthesize bankLogoImageView;
@synthesize cellBG;


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
