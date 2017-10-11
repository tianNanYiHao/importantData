//
//  SDCardScrollViewCell.m
//  SDCardScrollView
//
//  Created by tianNanYiHao on 2017/9/28.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "SDCardScrollViewCell.h"

@implementation SDCardScrollViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self addSubview:self.mainImageView];
    }return self;
}

-(UIImageView*)mainImageView{
    if (!_mainImageView) {
        _mainImageView = [[UIImageView alloc] initWithFrame:self.frame];
        _mainImageView.userInteractionEnabled = YES;
    }
    return _mainImageView;
}

- (void)setSubviewsWithSuperViewBounds:(CGRect)superViewBounds {
    
    if (CGRectEqualToRect(self.mainImageView.frame, superViewBounds)) {
        return;
    }
    
    self.mainImageView.frame = superViewBounds;

}

@end
