//
//  SDSelectBarView.m
//  SDSelectBarView
//
//  Created by tianNanYiHao on 2017/12/4.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "SDSelectBarView.h"

@interface SDSelectBarView (){
    
    CGFloat labSpace; //标题lab间隙大小
    
    CGFloat labMaxWidth; //最大长度标题的宽度
    CGFloat labMaxHeight;//最大长度标题的高度
    
    CGFloat whiteBgViewHeight; //白色背景view高度
    CGFloat whiteBgViewWidth; //白色背景view宽度
    
    NSMutableArray *titleLabArray;   //存储创建好的标题Lab
    
}
/**
 标题数组
 */
@property (nonatomic ,strong) NSArray *titleArr;

@property (nonatomic, copy) SDSelectBarBlock selectBlock;

@end


@implementation SDSelectBarView


+ (instancetype)showSelectBarView:(NSArray*)titleArr selectBarBlock:(SDSelectBarBlock)block{
    
    SDSelectBarView *selectBarView = [[SDSelectBarView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 0)];
    selectBarView.backgroundColor = [UIColor redColor];
    selectBarView.titleArr = titleArr;
    selectBarView.selectBlock = block;
    return selectBarView;
    
}

- (void)setTitleArr:(NSArray *)titleArr{
    
    _titleArr = titleArr;
    titleLabArray = [NSMutableArray arrayWithCapacity:0];
    [self createSelectBarContentView];
    
}

- (void)createSelectBarContentView{
    
    //计算基础frame
    [self getBaseFrame];
    
    // whiteBgView
    UIView *whiteBgView = [[UIView alloc] init];
    whiteBgView.backgroundColor = [UIColor whiteColor];
    whiteBgView.layer.cornerRadius = whiteBgViewHeight/2;
    whiteBgView.layer.masksToBounds = YES;
    whiteBgView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - whiteBgViewWidth)/2 , 0, whiteBgViewWidth, whiteBgViewHeight);
    [self addSubview:whiteBgView];
    
    //lab
    for (int i = 0; i<self.titleArr.count; i++) {
        UILabel *lab  = [self createLab:self.titleArr[i] index:i];
        lab.frame = CGRectMake(labSpace/2 + i*labMaxWidth, labSpace/2, labMaxWidth, labMaxHeight);
        [whiteBgView addSubview:lab];
        [titleLabArray addObject:lab];
    }
    
    //设置frame
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, whiteBgView.frame.size.height);
    
}

- (void)getBaseFrame{
    
    //1. 计算最长标题所占空间
    //对titleArr进行排序
    NSArray *resultArrayOrder = [self.titleArr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSNumber *tNumber1 = (NSNumber *)obj1;
        NSNumber *tNumber2 = (NSNumber *)obj2;
        //因为不满足sortedArrayUsingComparator方法的默认排序顺序，则需要交换
        if ([tNumber1 integerValue] < [tNumber2 integerValue]){
            return NSOrderedDescending;
            return NSOrderedAscending;
        }
        //因为满足sortedArrayUsingComparator方法的默认排序顺序，则不需要交换
        if ([tNumber1 integerValue] > [tNumber2 integerValue]){
            return NSOrderedAscending;
        }
        return NSOrderedDescending;
    }];
    //取最长字符串标题
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    titleLab.text = [resultArrayOrder firstObject];
    
    labSpace = (12.f/375.f)*[UIScreen mainScreen].bounds.size.width;
    CGSize maxLabSize = [titleLab sizeThatFits:CGSizeZero];
    labMaxWidth = maxLabSize.width + labSpace*2;
    labMaxHeight = maxLabSize.height + labSpace*2;
    whiteBgViewWidth = self.titleArr.count * labMaxWidth + labSpace;
    whiteBgViewHeight = labMaxHeight + labSpace;
    titleLab = nil;

}

- (UILabel*)createLab:(NSString*)titleName index:(NSInteger)index{
    
    UILabel *titlelab = [[UILabel alloc] init];
    titlelab.text = titleName;
    titlelab.userInteractionEnabled = YES;
    titlelab.layer.cornerRadius = labMaxHeight/2;
    titlelab.layer.masksToBounds = YES;
    titlelab.layer.backgroundColor = [UIColor whiteColor].CGColor;
    titlelab.textAlignment = NSTextAlignmentCenter;
    titlelab.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    titlelab.textColor = [UIColor colorWithRed:52/255.0 green:51/255.0 blue:57/255.0 alpha:1/1.0];
    titlelab.tag = index;
    
    UITapGestureRecognizer *tapRecognize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    [titlelab addGestureRecognizer:tapRecognize];
    return titlelab;
    
}
- (void)handleTap:(UIGestureRecognizer*)tap{
    
    NSInteger index = tap.view.tag;
    
    //回调
    self.selectBlock(index);
    
    //修改选中的样式
    UILabel *selectLab = titleLabArray[index];
    for (UILabel *lab in titleLabArray) {
        if (lab == selectLab) {
            lab.layer.backgroundColor = [UIColor colorWithRed:53/255.0 green:139/255.0 blue:239/255.0 alpha:1/1.0].CGColor;
            lab.textColor = [UIColor whiteColor];
            lab.userInteractionEnabled = NO;
        }else{
            lab.layer.backgroundColor = [UIColor whiteColor].CGColor;
            lab.textColor = [UIColor colorWithRed:52/255.0 green:51/255.0 blue:57/255.0 alpha:1/1.0];
            lab.userInteractionEnabled = YES;
        }
    }
    
    
    
}


@end
