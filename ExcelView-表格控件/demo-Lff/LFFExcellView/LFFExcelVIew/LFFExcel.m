//
//  LFFExcel.m
//  LFFExcellView
//
//  Created by Lff on 16/8/18.
//  Copyright © 2016年 Lff. All rights reserved.
//

#import "LFFExcel.h"
@implementation LFFExcel

@end



@implementation LFFExcelData
@synthesize data,titles,cellHeight,excelWidth,excelY,excelX;

//自动计算表格的合适高度
-(CGFloat)initwithexcelWidthBycellHeight:(CGFloat)cellHeightt{
    CGFloat  excelHeight;
    excelHeight = data.count*cellHeightt;  //表格高
    
    //判断返回的表格框高度 如果超过就固定 如果不超过 就返回本来高度
    CGFloat trueExcelHeight ;
    trueExcelHeight = excelHeight>[UIScreen mainScreen].bounds.size.height-excelY?[UIScreen mainScreen].bounds.size.height-excelY-20:excelHeight;
    return trueExcelHeight;
}
//计算单元格的长度
-(CGFloat)cellwidthByexcelWidth:(CGFloat)excelWidthh excelX:(CGFloat)excelX{
    CGFloat cellWidth;
    cellWidth = excelWidthh/titles.count;
    return cellWidth;
}
//返回表格的frame
-(CGRect)returnFrameForsetexcelWidth:(CGFloat)excelWidthw excelX:(CGFloat)excelXx excelY:(CGFloat)excelYy{
    //根据单元格高度 获取exce表格的总高
  CGFloat excelHeight =   [self initwithexcelWidthBycellHeight:cellHeight];
    return CGRectMake(excelXx, excelYy, excelWidthw, excelHeight);
    
}
@end



@implementation LFFExcelComponent
{
    UILabel *titleLab; //标题的lab
    UILabel *cellLab; //单元格Lab
    UIScrollView *scrollView;  //滚动视图    单元格view加载其上
    
    UIView *titleVIewBg ; // titleVIewBg
    UIView *cellViewBg ; // 单元格组viewBg
    
}
@synthesize dataSource;

-(instancetype)initWithdata:(LFFExcelData*)DataSource{
    //初始化表格样式 以及获取数据
    dataSource = DataSource;
    //根据titles获取单元格长度
    cellWidth = [dataSource cellwidthByexcelWidth:dataSource.excelWidth excelX:dataSource.excelX];
    //初始化显示视图及cell宽高
    cellHeight = dataSource.cellHeight;
    //计算frame
    CGRect frame = [dataSource returnFrameForsetexcelWidth:dataSource.excelWidth excelX:dataSource.excelX excelY:dataSource.excelY];
    
    
    self = [super initWithFrame:frame];
    if (self != nil) {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = dataSource.lineColor.CGColor;
        self.layer.borderWidth = 1;
        [self layoutSubview:frame];
    }
    return self;
}


- (void)layoutSubview:(CGRect)frame{
    //添加背景view 以及 Scrollview
    titleVIewBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, cellHeight)];
    [self addSubview:titleVIewBg];
    cellViewBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-cellHeight)];
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, cellHeight, frame.size.width, frame.size.height-cellHeight)];
    [self addSubview:scrollView];
    [scrollView addSubview:cellViewBg];
    scrollView.scrollEnabled = YES;
    scrollView.contentSize = CGSizeMake(frame.size.width, cellHeight*(dataSource.data.count)); //不超出即可
    
    
    //1. title视图创建
    for (int i = 0; i<dataSource.titles.count; i++) {
        //1.1 创建titleVIew
        vTopLeft = [[UIView alloc] initWithFrame:CGRectMake(cellWidth*i, 0, cellWidth-0.5, cellHeight)];
        vTopLeft.backgroundColor = dataSource.titleColor;
//        vTopLeft.layer.borderWidth =  0.5;
//        vTopLeft.layer.borderColor = [UIColor whiteColor].CGColor;
        [titleVIewBg addSubview:vTopLeft];
        
        //1.2 创建titleLab
        titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cellWidth, cellHeight)];
        [vTopLeft addSubview:titleLab];
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.textColor = [UIColor whiteColor];
        titleLab.text = dataSource.titles[i];
    }
    
    
    
    //2. 创建excel内容  行
    for (int i = 0; i<dataSource.data.count; i++) {
        //2.1创建 行view
        vRowView = [[UIView alloc] initWithFrame:CGRectMake(0,i*cellHeight, frame.size.width, cellHeight)];
        vRowView.backgroundColor = [UIColor blueColor];
        vRowView.layer.borderColor = dataSource.lineColor.CGColor;
        vRowView.layer.borderWidth = 0.5;
        [cellViewBg addSubview:vRowView];
        
        //2.2 创建 excel 内容行 中的       *单元格*
        for (int j = 0; j < dataSource.titles.count ; j++) {
            //2.2.1
            vCellView = [[UIView alloc] initWithFrame:CGRectMake(j*cellWidth, 0, cellWidth, cellHeight)];
            vCellView.layer.borderWidth = 0.5;
            vCellView.layer.borderColor = dataSource.lineColor.CGColor;
            vCellView.backgroundColor = dataSource.cellColor;
            [vRowView addSubview: vCellView];
            
            //2.2.2为每个单元格创建Lab
            cellLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cellWidth, cellHeight)];
            [vCellView addSubview:cellLab];
            cellLab.textAlignment = NSTextAlignmentCenter;
            cellLab.textColor = [UIColor grayColor];
            cellLab.text = (dataSource.data[i])[j];
        }
    }

}


@end