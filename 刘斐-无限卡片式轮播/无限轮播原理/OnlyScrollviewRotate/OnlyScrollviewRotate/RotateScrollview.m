//
//  RotateScrollview.m
//  OnlyScrollviewRotate
//
//  Created by tianNanYiHao on 2017/9/30.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "RotateScrollview.h"

@interface RotateScrollview ()<UIScrollViewDelegate>
/**
 *  原始页数
 */
@property(nonatomic, assign) NSInteger orginPageCount;

/**
 *  总页数
 */
@property(nonatomic, assign) NSInteger pageCount;

/**
 *  一页的尺寸
 */
@property(nonatomic, assign) CGSize pageSize;

/**
 左右间距,默认20
 */
@property(nonatomic, assign) CGFloat leftRightMargin;

/**
 上下间距,默认30
 */
@property(nonatomic, assign) CGFloat topBottomMargin;



@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation RotateScrollview
@synthesize orginPageCount;
@synthesize pageCount;
@synthesize pageSize;
@synthesize leftRightMargin;
@synthesize topBottomMargin;


-(instancetype)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        [self initsilize];
    }return self;
    
}

- (void)initsilize{
    leftRightMargin = 10;
    topBottomMargin = 15;
    
    pageSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
    orginPageCount = 5;
    pageCount = orginPageCount*3;
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.clipsToBounds = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.showsVerticalScrollIndicator = YES;
    self.scrollView.showsHorizontalScrollIndicator = YES;
    
    [self addSubview:self.scrollView];
    
    for (int i = 0; i<15; i++) {
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:self.bounds];
        //第一组
        if (i<=4) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Yosemite%02d",i]];
            imgV.image = image;
        }
        //第二组
        if (i<=10&&i>4) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Yosemite%02d",i-5]];
            imgV.image = image;
        }
        //第三组
        if (i<15&&i>9) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Yosemite%02d",i-10]];
            imgV.image = image;
        }
        imgV.frame = CGRectMake(pageSize.width*i, 0, pageSize.width, pageSize.height);
        [self.scrollView addSubview:imgV];
    }
    
    self.scrollView.contentSize = CGSizeMake(pageSize.width*pageCount, 0);
    
    //设置scrollview的当前显示状态为 第二组
    [self.scrollView setContentOffset:CGPointMake(pageSize.width*orginPageCount*2, 0)];
}

#pragma  - mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //获取拖拽的下标
    NSInteger pageIndex;
    pageIndex = (int)round(_scrollView.contentOffset.x / pageSize.width) % orginPageCount;
    
    
    //向左滑动实现无限滚动
    if (scrollView.contentOffset.x / pageSize.width >= 2 * self.orginPageCount) {
        NSLog(@"%.f",scrollView.contentOffset.x / pageSize.width);
        //回到
        [scrollView setContentOffset:CGPointMake(pageSize.width * self.orginPageCount, 0) animated:NO];
        
    }
    //向右滑动实现无限滚动
    if (scrollView.contentOffset.x/ pageSize.width < self.orginPageCount -1) {
        
        [scrollView setContentOffset:CGPointMake(pageSize.width * (self.orginPageCount*2-1), 0) animated:NO];
    }

    
    
}


@end
