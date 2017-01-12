//
//  ReusableHeaderView.m
//  QuickPos
//
//  Created by feng Jie on 16/7/8.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "ReusableHeaderView.h"

@implementation ReusableHeaderView


//重写HeaderCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(300, 0, 44, 44)];
        [self addSubview:_titleLabel];
        [self addSubview:_imageView];
    }
    return self;
}

@end
