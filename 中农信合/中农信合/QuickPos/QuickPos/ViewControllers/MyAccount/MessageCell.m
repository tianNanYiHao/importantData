//
//  MessageCell.m
//  QuickPos
//
//  Created by Leona on 15/4/12.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

@synthesize logoImageView;
@synthesize messageTextLabel;
@synthesize messageTitleLabel;
@synthesize dateLabel;


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
