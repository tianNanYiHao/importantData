//
//  MyAccountTableViewCell.m
//  QuickPos
//
//  Created by 张倡榕 on 15/3/11.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "MyAccountTableViewCell.h"

@implementation MyAccountTableViewCell

@synthesize titleLabel;
@synthesize logoImageView;
@synthesize arrowImage;



- (void)awakeFromNib {
    
    if([UIDevice currentDevice].isIphone6p){
        
        arrowImage.frame = CGRectMake(390, 20, 14, 16);
        
    }else if([UIDevice currentDevice].isIphone6){
        
        arrowImage.frame = CGRectMake(352, 20, 14, 16);
        
    }else if([UIDevice currentDevice].isIphone5){
        
        arrowImage.frame = CGRectMake(298, 20, 14, 16);
        
    }
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
