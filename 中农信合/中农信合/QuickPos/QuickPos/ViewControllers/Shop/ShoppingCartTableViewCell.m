//
//  ShoppingCartTableViewCell.m
//  QuickPos
//
//  Created by 张倡榕 on 15/3/12.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "ShoppingCartTableViewCell.h"

@implementation ShoppingCartTableViewCell
@synthesize shopCartMerchandiseImage;
@synthesize shopCartMerchandiseName;
@synthesize shopCartMerchandisePrice;
@synthesize shopCartMerchandiseSum;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
