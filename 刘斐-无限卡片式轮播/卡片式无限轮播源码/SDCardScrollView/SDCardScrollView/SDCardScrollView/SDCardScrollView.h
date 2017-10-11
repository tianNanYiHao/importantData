//
//  SDCardScrollView.h
//  SDCardScrollView
//
//  Created by tianNanYiHao on 2017/9/28.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCardScrollViewCell.h"
@class SDCardScrollView;
@protocol SDCardScrollViewDelegate <NSObject>

/**
 代理之返回cell的size

 @param scrollview <#scrollview description#>
 @return <#return value description#>
 */
- (CGSize)sizeForCellInScrollview:(SDCardScrollView*)scrollview;

@end
@protocol SDCardScrollViewDataSource <NSObject>


/**
 数据源代理之返回cell个数

 @param scrollview <#scrollview description#>
 @return <#return value description#>
 */
- (CGFloat)numbersOfCellInSDCardScrollView:(SDCardScrollView*)scrollview;

/**
 数据源代理之设置cell内容

 @param scrollView <#scrollView description#>
 @param index <#index description#>
 @return <#return value description#>
 */
- (SDCardScrollViewCell*)cell:(SDCardScrollView*)scrollView cellForIndex:(NSInteger)index;

@end


@interface SDCardScrollView : UIView

@property (nonatomic, assign)id<SDCardScrollViewDelegate> delegate;
@property (nonatomic, assign)id<SDCardScrollViewDataSource> dataSource;

/**
 *  是否开启无限轮播,默认为开启
 */
@property (nonatomic, assign) BOOL isCarousel;


/**
 更新数据
 */
- (void)reloadData;

/**
 获取可重复使用的cell

 @return <#return value description#>
 */
- (SDCardScrollViewCell *)dequeueReusableCell;
@end
