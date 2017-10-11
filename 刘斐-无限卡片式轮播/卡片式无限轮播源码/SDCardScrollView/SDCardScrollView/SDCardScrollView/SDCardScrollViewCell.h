//
//  SDCardScrollViewCell.h
//  SDCardScrollView
//
//  Created by tianNanYiHao on 2017/9/28.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDCardScrollViewCell : UIView


/**
 主图
 */
@property (nonatomic, strong) UIImageView *mainImageView;



- (void)setSubviewsWithSuperViewBounds:(CGRect)superViewBounds;

@end
