//
//  SDPayKeyBoardView.m
//  SDPayToolViewDemo
//
//  Created by tianNanYiHao on 2017/9/8.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "SDPayKeyBoardView.h"
#import "SDPayConfig.h"

@interface SDPayKeyBoardView()
{
    CGSize superViewSize;
}
@property (nonatomic, strong) NSMutableArray * tempArray;
@property(nonatomic,strong)UIView * keyBordView;
@end

@implementation SDPayKeyBoardView
@synthesize tempArray;
@synthesize keyBordView;


//初始化
+ (instancetype)keyBoardAddWith:(UIView*)superView{
    SDPayKeyBoardView *kb = [[SDPayKeyBoardView alloc] init:superView];
    return kb;
}

- (instancetype)init:(UIView*)view{
    if ([super init]) {
        superViewSize = view.frame.size;
        tempArray = [NSMutableArray arrayWithCapacity:0];
        self.frame = SDPayKeyBoardWillLoadFrame;
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        [self createKeyBaordView];
        [self showUpPayKeyBoardView];
    }return self;
    
}

- (void)createKeyBaordView{
    
    [self addKeyBoardBtn];

}


//弹出键盘
- (void)showUpPayKeyBoardView{
    [SDPayAnimtion payKeyBoardViewAnimation:self frame:SDPayKeyBoardDidLoadFrame showState:YES];
}

//退出键盘
- (void)hiddenDownPayKeyBoardView{
    [SDPayAnimtion payKeyBoardViewAnimation:self frame:SDPayKeyBoardWillLoadFrame showState:NO];
}


#pragma - mark  打乱顺序
- (NSMutableArray *)derangementArray
{
    NSArray * ary =[[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0", nil];
    
    ary = [ary sortedArrayUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2){
        int seed = arc4random_uniform(2);
        
        if (seed) {
            return [str1 compare:str2];
        } else {
            return [str2 compare:str1];
        }
    }];
    NSMutableArray *newArray = [NSMutableArray arrayWithArray:ary];
    [newArray addObject:@"清除"];
    [newArray addObject:@"←"];
    
    return newArray;
}

#pragma - mark 添加键盘按钮
- (void)addKeyBoardBtn
{
    tempArray = [self derangementArray];
    
    for(int i=0;i<tempArray.count;i++)
    {
        NSInteger index = i%3;
        NSInteger page = i/3;
        
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(index * (ScreenW/3), page  * keyBordCellHeight-keyBordCellBoardLine, ScreenW/3,keyBordCellHeight);
        btn.tag=i;
        [btn setTitle:[tempArray objectAtIndex:i] forState:normal];
        [btn setTitleColor:[UIColor blackColor] forState:normal];
        if ([btn.currentTitle isEqualToString:@"清除"]) {
            btn.titleLabel.font = [UIFont systemFontOfSize:keyBoardBtnCleanFont];
        }else{
            NSMutableAttributedString *titleNomal = [[NSMutableAttributedString alloc] initWithString:[tempArray objectAtIndex:i]];
            NSMutableAttributedString *titleHeighted = [[NSMutableAttributedString alloc]initWithString:[tempArray objectAtIndex:i]];
            [titleNomal addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:keyBoardBtnFontNormal] range:NSMakeRange(0, titleNomal.length)];
            [titleHeighted addAttributes:@{
                                           NSFontAttributeName:[UIFont systemFontOfSize:keyBoardBtnFontHeighted],
                                           } range:NSMakeRange(0, titleHeighted.length)];
            [btn setAttributedTitle:titleNomal forState:UIControlStateNormal];
            [btn setAttributedTitle:titleHeighted forState:UIControlStateHighlighted];
        }
        btn.layer.borderColor=keyBoardColor.CGColor;
        btn.layer.borderWidth=keyBordCellBoardLine;
        
        if (i == 9 || i == 11) {
            btn.backgroundColor = Rgba(195, 199, 207);
        }
        [btn addTarget:self action:@selector(KeyBoradClass:) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:btn];
    }
}
#pragma  - mark ===========================自定义键盘事件处理=====================

#pragma - mark 键盘输入6位密码/清空/删除 事件
-(void)KeyBoradClass:(UIButton *)btn
{
    if ([_delegate respondsToSelector:@selector(payKeyBoardCurrentTitle:)]) {
        [_delegate payKeyBoardCurrentTitle:btn];
    }
  
}

@end
