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
    
    UIButton *cellBtn;     //单元格按钮
    
}
@synthesize dataSource;

-(instancetype)initWithdata:(LFFExcelData*)DataSource block:(LFFExcelComponentBlock)block{
    _block = block;
    
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
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = dataSource.lineColor.CGColor;
        self.layer.borderWidth = 1;
        [self layoutSubview:frame];
    }
    return self;
}


- (void)layoutSubview:(CGRect)frame{
    //添加背景view 以及 Scrollview
    
    //标题背景view
    titleVIewBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, cellHeight)];
    [self addSubview:titleVIewBg];
    /*
     单元格背景view
     注意这儿的单元格背景view的高度一定要和真正的单元格总共度相同,不能使用自动计算出来的self.frame的高度,
       那个高度只是整个空间的可视高度,我们实际位单元格们创建的背景view
    一定是要真正的高度 不然由于高度不够,滚动上来的单元格则不能触发点击效果
     */
    cellViewBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, cellHeight*dataSource.data.count)];
    
    //滚动视图
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, cellHeight, frame.size.width, frame.size.height-cellHeight)];
    [self addSubview:scrollView];
    [scrollView addSubview:cellViewBg];
    cellViewBg.userInteractionEnabled = YES;
    scrollView.scrollEnabled = YES;
    scrollView.userInteractionEnabled = YES;
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
        vRowView.userInteractionEnabled = YES;
        [cellViewBg addSubview:vRowView];
        
        //2.2 创建 excel 内容行 中的       *单元格*
        for (int j = 0; j < dataSource.titles.count ; j++) {
            //2.2.1
            vCellView = [[UIView alloc] initWithFrame:CGRectMake(j*cellWidth, 0, cellWidth, cellHeight)];
            vCellView.layer.borderWidth = 0.5;
            vCellView.layer.borderColor = dataSource.lineColor.CGColor;
            vCellView.backgroundColor = dataSource.cellColor;
            vCellView.userInteractionEnabled = YES;
            [vRowView addSubview: vCellView];
            
            //2.2.2为每个单元格创建Lab
            cellLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cellWidth, cellHeight)];
            [vCellView addSubview:cellLab];
            cellLab.textAlignment = NSTextAlignmentCenter;
            cellLab.textColor = [UIColor grayColor];
            cellLab.text = (dataSource.data[i])[j];
            
             //检测到空表格 则停止创建action 按钮
            if(![[dataSource.data[i] firstObject] isEqualToString:@""]){
                if (j == dataSource.titles.count-1  && dataSource.anction == YES) {
                    //2.2.3创建按钮以供点击
                    cellBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                    cellBtn.frame = CGRectMake(0, 0, cellWidth, cellHeight);
                    [cellBtn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
                    cellLab.enabled = YES;
                    cellBtn.tag = i;
                    [vCellView addSubview:cellBtn];
                    //改变文字颜色
                    cellLab.textColor = dataSource.titleColor;
                }
            }
            
            
        }
        
    }

}

-(void)actionBtn:(UIButton*)btn{
    _block(btn.tag);
}


@end