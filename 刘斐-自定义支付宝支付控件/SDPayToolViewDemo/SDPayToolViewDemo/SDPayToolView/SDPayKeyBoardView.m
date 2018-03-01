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
    
    //键盘样式一
//    [self addKeyBoardView1];
    
    //键盘样式二
    [self addKeyBoardView2];

}


//弹出键盘
- (void)showUpPayKeyBoardView{
    [SDPayAnimtion payKeyBoardViewAnimation:self frame:SDPayKeyBoardDidLoadFrame showState:YES];
}

//退出键盘
- (void)hiddenDownPayKeyBoardView{
    [SDPayAnimtion payKeyBoardViewAnimation:self frame:SDPayKeyBoardWillLoadFrame showState:NO];
}

#pragma - mark 添加键盘-样式一
- (void)addKeyBoardView1
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
/**打乱顺序*/
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


#pragma - mark 添加键盘-样式二
- (void)addKeyBoardView2{
    
    //标题视图宽高
    CGFloat titleBaseViewW = [UIScreen mainScreen].bounds.size.width;
    CGFloat titleBaseViewH = AdapterHfloat(40);
    
    //回退/确认按钮宽高
    CGFloat backBtnW = AdapterWfloat(105);
    CGFloat backBtnH = AdapterHfloat(98);
    CGFloat sureBtnW = backBtnW;
    CGFloat sureBtnH = backBtnH;
    
    //数字键盘宽高
    CGFloat allNumKeyBoardW = titleBaseViewW - backBtnW;
    CGFloat allNumkeyBoardH = backBtnH*2;
    
    

    //1.titleBaseView
    UIView *titleBaseView = [[UIView alloc] init];
    titleBaseView.backgroundColor = [UIColor whiteColor];
    titleBaseView.frame = CGRectMake(0, 0, titleBaseViewW, titleBaseViewH);
    titleBaseView.layer.borderColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1/1.0].CGColor;
    titleBaseView.layer.borderWidth = 0.8f;
    [self addSubview:titleBaseView];
    
    //titleLogo
    UIImage *saveLogo = [UIImage imageNamed:@"sdb_saveLogo"];
    UIImageView *saveLogoView = [[UIImageView alloc] init];
    saveLogoView.image = saveLogo;
    [titleBaseView addSubview:saveLogoView];
    
    //titleLab
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = @"杉德安全键盘";
    titleLab.font = [UIFont fontWithName:@"PingFangSC-Light" size:AdapterFfloat(13)];
    titleLab.textColor = [UIColor colorWithRed:104/255.0 green:119/255.0 blue:133/255.0 alpha:1/1.0];
    [titleBaseView addSubview:titleLab];
    
    
    // keyboarDownBtn
    UIImage *keyboarddownimg = [UIImage imageNamed:@"sdb_upkeyboard"];
    UIButton *keyboarDownBtn = [[UIButton alloc] init];
    keyboarDownBtn.tag = 90000;
    [keyboarDownBtn setImage:keyboarddownimg forState:UIControlStateNormal];
    [keyboarDownBtn addTarget:self action:@selector(KeyBoradClass:) forControlEvents:UIControlEventTouchUpInside];
    [titleBaseView addSubview:keyboarDownBtn];
    
    CGFloat titlabSizW = [titleLab sizeThatFits:CGSizeZero].width;
    CGFloat logoWihttitleLabW = saveLogo.size.width + titlabSizW;
    CGFloat saveLogoOX = (titleBaseViewW - logoWihttitleLabW)/2;
    saveLogoView.frame = CGRectMake(saveLogoOX, (titleBaseViewH - saveLogo.size.height)/2 , saveLogo.size.width, saveLogo.size.height);
    titleLab.frame = CGRectMake(saveLogoOX + saveLogo.size.width, 0, titlabSizW, titleBaseViewH);
    keyboarDownBtn.frame = CGRectMake(titleBaseViewW - keyboarddownimg.size.width - AdapterWfloat(20), (titleBaseViewH - keyboarddownimg.size.height)/2, keyboarddownimg.size.width, keyboarddownimg.size.height);
    
    
    //2.numKeyboardBaseView
    UIView *numKeyboardBaseView = [[UIView alloc] init];
    numKeyboardBaseView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1/1.0];
    numKeyboardBaseView.frame = CGRectMake(0, titleBaseViewH, allNumKeyBoardW, allNumkeyBoardH);
    [self addSubview:numKeyboardBaseView];
    
    //numCellBtn
    tempArray = [NSMutableArray arrayWithArray:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@" ",@"0",@" "]];
    for(int i=0;i<tempArray.count;i++)
    {
        NSInteger index = i%3;
        NSInteger page = i/3;
        
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(index * (allNumKeyBoardW/3), titleBaseViewH + page  * keyBordCellHeight-keyBordCellBoardLine, allNumKeyBoardW/3,keyBordCellHeight);
        btn.tag=i;
        [btn setTitle:[tempArray objectAtIndex:i] forState:normal];
        [btn setTitleColor:[UIColor blackColor] forState:normal];
        btn.titleLabel.textColor = [UIColor colorWithRed:104/255.0 green:119/255.0 blue:133/255.0 alpha:1/1.0];
        NSMutableAttributedString *titleNomal = [[NSMutableAttributedString alloc] initWithString:[tempArray objectAtIndex:i]];
        NSMutableAttributedString *titleHeighted = [[NSMutableAttributedString alloc]initWithString:[tempArray objectAtIndex:i]];
        [titleNomal addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:keyBoardBtnFontNormal] range:NSMakeRange(0, titleNomal.length)];
        [titleHeighted addAttributes:@{
                                       NSFontAttributeName:[UIFont systemFontOfSize:keyBoardBtnFontHeighted],
                                       } range:NSMakeRange(0, titleHeighted.length)];
        [btn setAttributedTitle:titleNomal forState:UIControlStateNormal];
        [btn setAttributedTitle:titleHeighted forState:UIControlStateHighlighted];
        
        btn.layer.borderColor=keyBoardColor.CGColor;
        btn.layer.borderWidth=keyBordCellBoardLine;
        if (!(i == 9 || i == 11)) {
            [btn addTarget:self action:@selector(KeyBoradClass:) forControlEvents:UIControlEventTouchUpInside];
        }
        [self addSubview:btn];
    }
    
    
    
    //3.backBtn
    UIButton *backBtn = [[UIButton alloc] init];
    backBtn.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1/1.0];
    backBtn.frame = CGRectMake(allNumKeyBoardW, titleBaseViewH, backBtnW, backBtnH);
    backBtn.layer.borderColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1/1.0].CGColor;
    backBtn.layer.borderWidth = 0.8f;
    backBtn.tag = 90001;
    [backBtn setImage:[UIImage imageNamed:@"sab_cleanKeyBoard"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(KeyBoradClass:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backBtn];
    
    //4.sureBtn
    UIButton *sureBtn = [[UIButton alloc] init];
    sureBtn.backgroundColor = [UIColor colorWithRed:53/255.0 green:139/255.0 blue:239/255.0 alpha:1/1.0];
    sureBtn.frame = CGRectMake(allNumKeyBoardW, titleBaseViewH+backBtnH, sureBtnW, sureBtnH);
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.tag = 90002;
    sureBtn.titleLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:AdapterFfloat(18)];
    [sureBtn addTarget:self action:@selector(KeyBoradClass:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sureBtn];
    
    
    
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
