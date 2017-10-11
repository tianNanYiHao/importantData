//
//  SDCardScrollView.m
//  SDCardScrollView
//
//  Created by tianNanYiHao on 2017/9/28.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "SDCardScrollView.h"

@interface SDCardScrollView ()<UIScrollViewDelegate>

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

/**
 可见页面range
 */
@property(nonatomic, assign) NSRange visibleRange;

/**
 保存复用的cell数组
 */
@property(nonatomic, strong) NSMutableArray *reusableCells;

/**
 总cell数组的NULL模型,即塞入所需cell的null个数 仅用于循环
 */
@property(nonatomic, strong) NSMutableArray *cells;



@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation SDCardScrollView
@synthesize orginPageCount;
@synthesize pageCount;
@synthesize pageSize;
@synthesize leftRightMargin;
@synthesize topBottomMargin;
@synthesize visibleRange;
@synthesize reusableCells;
@synthesize cells;


#pragma - mark private Methods

- (void)initialize{
    
    leftRightMargin = 10;
    topBottomMargin = 15;
    self.isCarousel = YES;
    
    reusableCells = [NSMutableArray arrayWithCapacity:0];
    cells = [NSMutableArray arrayWithCapacity:0];
    
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(30, 0, self.frame.size.width-60, self.frame.size.height)];
    self.scrollView.clipsToBounds = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.showsVerticalScrollIndicator = YES;
    self.scrollView.showsHorizontalScrollIndicator = YES;
    
    [self addSubview:self.scrollView];
    
}




#pragma - mark Override Methods
- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if ([super initWithCoder:aDecoder]) {
        [self initialize];
    }return self;
    
}


- (SDCardScrollViewCell *)dequeueReusableCell{
    SDCardScrollViewCell *cell = [reusableCells lastObject];
    if (cell)
    {
        [reusableCells removeLastObject];
    }
    
    return cell;
}
- (void)reloadData{
    
    //获取数据源
    if ([_dataSource respondsToSelector:@selector(numbersOfCellInSDCardScrollView:)]) {
        orginPageCount = [_dataSource numbersOfCellInSDCardScrollView:self];
        if (self.isCarousel) {
            pageCount = orginPageCount*3;
        }else{
            pageCount = orginPageCount;
        }
        //如果总页数为0,洗洗睡
        if (pageCount == 0) {
            return;
        }
        
    }
    
    //默认pageSize
    pageSize = CGSizeMake(self.bounds.size.width - 4 * leftRightMargin,(self.bounds.size.width - 4 * leftRightMargin) * 9 /16);
    //通过代理自定义pageSize
    if ([_delegate respondsToSelector:@selector(sizeForCellInScrollview:)]) {
        pageSize = [_delegate sizeForCellInScrollview:self];
    }
    
    
    //填充cells数组
    [cells removeAllObjects];
    for (NSInteger index=0; index<pageCount; index++){
        [cells addObject:[NSNull null]];
    }
    
    //更新scrollview大小
    _scrollView.frame = CGRectMake(0, 0, pageSize.width, pageSize.height);
    _scrollView.contentSize = CGSizeMake(pageSize.width * pageCount,0);
    CGPoint theCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    _scrollView.center = theCenter;
    
    
    if (orginPageCount > 1) {
        if (self.isCarousel) {
            //滚到第二组
            [_scrollView setContentOffset:CGPointMake(pageSize.width * orginPageCount, 0) animated:NO];
        }else{
            //滚到开始
            [_scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        }
    }
    
    
    [self setPagesAtContentOffset:_scrollView.contentOffset];
    
    [self refreshVisibleCellAppearance];
    
    
}

/**
 根据当前scrollView的offset设置cell

 @param offset 偏移量
 */
- (void)setPagesAtContentOffset:(CGPoint)offset{
    /*
     思路: 整个SDCardScrollview(self)上,分别有三块cell 左 中 右 
     其中,左边及右边两个cell仅显示一点点
     定义 左边cell 为start(cell)
     定义 中间cell 为mid(cell)(仅作为概念,实际不处理)
     定义 右边cell 为end(cell)
     
     动画描述:
     1.当向左滑动:end(cell)向左 随着contentoffset.x偏移量变小,end(cell)变成 mid(cell) 原mid(cell)变为start(cell)
     2.当向右滑动:start(cell)向右 随着contentoffset.x偏移量变大,start(cell)变成 mid(cell) 原mid(cell)变为 end(cell)
     
     对startPoint点定以:
     当cells数组中某个cell(cell均分排列)越过 startPoint点(界限),则这个cell即可认为是 start(cell)
     换句话说,当cell从屏幕左边缘出现(或进入屏幕左边一定范围),这这个cell即为 start(cell)
     因此,定义startPoint.x 与self.frame.origin.x重合.(startPoint点概念上固定,但实际值根据contentOffset.x变化)
     
     对endPoint点定义:
     当cells数组中某个cell(cell均分排列)越过 endPoint点(界限),则这个cell即可认为是 end(cell)
     换句话说,当cell进入屏幕右边一定返回(或从屏幕右边缘出现),这个cell即为 end(cell)
     因此,定义endPoint.x 与 mid(cell)的right边缘重合. (endPoint点概念是固定,但实际值根据contentoffset.x变化)
    */

    //计算_visibleRange
    CGPoint startPoint = CGPointMake(offset.x - _scrollView.frame.origin.x, offset.y - _scrollView.frame.origin.y);
    CGPoint endPoint = CGPointMake(startPoint.x + self.bounds.size.width, startPoint.y + self.bounds.size.height);
    
    
    NSInteger startIndex = 0;
    for (int i = 0; i<[cells count]; i++) {
        if (pageSize.width * (i+1) > startPoint.x) {
            startIndex = i;
            break;
        }
    }
    NSInteger endIndex = startIndex;
    for (NSInteger i = startIndex; i < [cells count]; i++) {
        //如果都不超过则取最后一个
        if ((pageSize.width * (i + 1) < endPoint.x && pageSize.width * (i + 2) >= endPoint.x) || i+ 2 == [cells count]) {
            endIndex = i + 1;//i+2 是以个数，所以其index需要减去1
            break;
        }
    }
    /*
     startIndex] [visibleIndex ] [endIndex
     4             5             6
     */
    
    NSLog(@"startIndex: %ld",(long)startIndex);
    NSLog(@"endIndex:%ld",(long)endIndex);
    self.visibleRange = NSMakeRange(startIndex, endIndex - startIndex + 1);
    
    for (NSInteger i = startIndex; i <= endIndex; i++) {
        [self setPageAtIndex:i];
    }
    
    for (int i = 0; i < startIndex; i ++) {
        [self removeCellAtIndex:i];
    }
    
    for (NSInteger i = endIndex + 1; i < [cells count]; i ++) {
        [self removeCellAtIndex:i];
    }

    

}

/**
 添加cell

 @param pageIndex 下标
 */
- (void)setPageAtIndex:(NSInteger)pageIndex{
    //数据源代理 - 设置cell内容
    if ([_dataSource respondsToSelector:@selector(cell:cellForIndex:)])
    {
        
        SDCardScrollViewCell *cell = [cells objectAtIndex:pageIndex];
        if ((NSObject*)cell == [NSNull null]) {
            //获取cell
            cell = [_dataSource cell:self cellForIndex:pageIndex%orginPageCount];
            //cells空数组对象替换成真正cell
            [cells replaceObjectAtIndex:pageIndex withObject:cell];
            [cell setSubviewsWithSuperViewBounds:CGRectMake(0, 0, pageSize.width, pageSize.height)];
        }
        
        if (!cell.superview) {
            [_scrollView addSubview:cell];
        }
    }
}
- (void)queueReusableCell:(SDCardScrollViewCell *)cell{
    [reusableCells addObject:cell];
}

- (void)removeCellAtIndex:(NSInteger)index{
    SDCardScrollViewCell *cell = [cells objectAtIndex:index];
    if ((NSObject *)cell == [NSNull null]) {
        return;
    }
    
    [self queueReusableCell:cell];
    
    if (cell.superview) {
        [cell removeFromSuperview];
    }
    
    [cells replaceObjectAtIndex:index withObject:[NSNull null]];
}


/**
 cell执行形变动画
 */
- (void)refreshVisibleCellAppearance{
    
    CGFloat offset = _scrollView.contentOffset.x;
    for (NSInteger i = visibleRange.location; i < visibleRange.location + visibleRange.length; i++) {
        SDCardScrollViewCell *cell = [cells objectAtIndex:i];
        CGFloat origin = cell.frame.origin.x;
        CGFloat delta = fabs(origin - offset);
        
        CGRect originCellFrame = CGRectMake(pageSize.width * i, 0, pageSize.width, pageSize.height);//如果没有缩小效果的情况下的本该的Frame
        //同时出现在scrollview(屏幕上) 必有2个cell同时在屏幕上形变 - transform根据delta变化而变化
        if (delta < pageSize.width) {
            
            CGFloat leftRightInset = leftRightMargin * delta / pageSize.width;
            CGFloat topBottomInset = topBottomMargin * delta / pageSize.width;
            
            cell.layer.transform = CATransform3DMakeScale((pageSize.width-leftRightInset*2)/pageSize.width,(pageSize.height-topBottomInset*2)/pageSize.height, 1.0);
            cell.frame = UIEdgeInsetsInsetRect(originCellFrame, UIEdgeInsetsMake(topBottomInset, leftRightInset, topBottomInset, leftRightInset));
            
            
        }
        //未出现在scrollview(屏幕上)的cell - 固定transform
        else {
            
            cell.layer.transform = CATransform3DMakeScale((pageSize.width-leftRightMargin*2)/pageSize.width,(pageSize.height-topBottomMargin*2)/pageSize.height, 1.0);
            cell.frame = UIEdgeInsetsInsetRect(originCellFrame, UIEdgeInsetsMake(topBottomMargin, leftRightMargin,topBottomMargin, leftRightMargin));
        }
        
    }
}






#pragma  - mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    //获取拖拽的下标
    NSInteger pageIndex;
    pageIndex = (int)round(_scrollView.contentOffset.x / pageSize.width) % orginPageCount;
    
    
    if (self.isCarousel) {
    
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
    
    
    [self setPagesAtContentOffset:_scrollView.contentOffset];
    
    [self refreshVisibleCellAppearance];
    
    
}





@end
