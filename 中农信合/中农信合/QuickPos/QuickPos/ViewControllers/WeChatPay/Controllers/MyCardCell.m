//
//  MyCardCell.m
//  QuickPos
//
//  Created by feng Jie on 16/7/26.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "MyCardCell.h"

@implementation MyCardCell


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
