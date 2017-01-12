//
//  ShopCartTableViewCell.m
//  QuickPos
//
//  Created by YZ on 15/8/25.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "ShopCartTableViewCell.h"

@implementation ShopCartTableViewCell
@synthesize bg;
- (void)awakeFromNib {
    // Initialization code
    self.bg.layer.borderColor =[[UIColor blackColor] CGColor];
    self.bg.layer.borderWidth = 0.5f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
