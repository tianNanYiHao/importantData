//
//  MyAccountHeaderTableViewCell.m
//  QuickPos
//
//  Created by 张倡榕 on 15/3/11.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "MyAccountHeaderTableViewCell.h"

@implementation MyAccountHeaderTableViewCell

@synthesize headicon;
@synthesize usernameLabel;
@synthesize moneyLabel;
@synthesize withdrawalLabel;
@synthesize headiconButton;

- (void)awakeFromNib {
    
    self.headicon.layer.masksToBounds = YES;
    self.headicon.layer.cornerRadius = 28;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
