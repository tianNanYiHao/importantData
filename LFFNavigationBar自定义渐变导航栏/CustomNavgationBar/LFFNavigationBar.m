//
//  LFFNavigationBar.m
//  CustomNavgationBar
//
//  Created by tianNanYiHao on 2017/3/10.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "LFFNavigationBar.h"
#import "NavCoverView.h"

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

// 判断是否为iPhone4
#define iPhone4 (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
// 判断是否为iPhone5
#define iPhone5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
// 判断是否为iPhone6
#define iPhone6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
// 判断是否为iPhone6 plus
#define iPhone6plus (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)


@interface LFFNavigationBar(){
    
    //自定义bar
    NavCoverView *navCoverView;
    
    //frame
    CGRect frameRec;
    
    //导航控制器样式
    LFFNavgationBarStyle lffNavgationBarStyle;
    
    CGFloat textSzieFont;
}


@end

@implementation LFFNavigationBar


#pragma mark - 初始化方法
-(instancetype)initWithFrame:(CGRect)frame lffNavgationBarStyle:(LFFNavgationBarStyle)style leftBLOCK:(LeftBtnBlock)leftblock rightBLOCK:(RightBtnBlock)rightblock{
    if (self = [super initWithFrame:frame]) {
        
        if (iPhone4 || iPhone5) {
            textSzieFont = 14;
        } else if (iPhone6) {
            textSzieFont = 16;
        } else {
            textSzieFont = 19;
        }
        
        frameRec = frame;
        lffNavgationBarStyle = style;
        _leftBlock = leftblock;
        _rightBlock = rightblock;
    }
    return self;
}

#pragma mark 设置完成 添加
-(void)addLFFNavgationBar{
    if (lffNavgationBarStyle == LFFNavgationBarDeful) {
        [self navgationBarDeful];
    }
    if (lffNavgationBarStyle == LFFNavgationBarOnlyGoBack) {
        [self navgationBarOnlyGoBack];
    }
    if (lffNavgationBarStyle == LFFNavgationBarBackAndNext) {
        [self navgationBarBackAndNext];
    }
    if (lffNavgationBarStyle == LFFNavgationBarSystenBtn) {
        [self LFFNavgationBarSystenBtn];
    }
    
}


#pragma mark - 创建方法
-(void)navgationBarDeful{
    navCoverView = [NavCoverView shareNavCoverView:frameRec title:_titleName];
    [self addSubview:navCoverView];
}

-(void)navgationBarOnlyGoBack{
    
    navCoverView = [NavCoverView shareNavCoverView:frameRec title:_titleName];
    
    //leftBtn
    UIImage *leftImage = [UIImage imageNamed:@"back"];
    UIButton *leftBarBtn = [[UIButton alloc] init];
    leftBarBtn.frame = CGRectMake(0, 20 + (40 - leftImage.size.height) / 2, leftImage.size.width, leftImage.size.height);
    leftBarBtn.tag = 101;
    [leftBarBtn setImage:leftImage forState:UIControlStateNormal];
    [leftBarBtn setImage:leftImage forState:UIControlStateHighlighted];
    leftBarBtn.contentMode = UIViewContentModeScaleAspectFit;
    [leftBarBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [navCoverView addSubview:leftBarBtn];
    [self addSubview:navCoverView];
}

-(void)navgationBarBackAndNext{
    navCoverView = [NavCoverView shareNavCoverView:frameRec title:_titleName];
    
    //leftBtn
    UIImage *leftImage = [UIImage imageNamed:_leftBtnImageName];
    UIButton *leftBarBtn = [[UIButton alloc] init];
    leftBarBtn.frame = CGRectMake(0, 20 + (40 - leftImage.size.height) / 2, leftImage.size.width, leftImage.size.height);
    leftBarBtn.tag = 101;
    [leftBarBtn setImage:leftImage forState:UIControlStateNormal];
    [leftBarBtn setImage:leftImage forState:UIControlStateHighlighted];
    leftBarBtn.contentMode = UIViewContentModeScaleAspectFit;
    [leftBarBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [navCoverView addSubview:leftBarBtn];
    
    
    UIImage *rightimage = [UIImage imageNamed:_rightBtnInageName];
    UIButton *rightBarBtn = [[UIButton alloc] init];
    rightBarBtn.frame = CGRectMake(self.bounds.size.width - rightimage.size.width, 20 + (40 - rightimage.size.height) / 2, rightimage.size.width, rightimage.size.height);
    rightBarBtn.tag = 102;
    [rightBarBtn setImage:rightimage forState:UIControlStateNormal];
    [rightBarBtn setImage:rightimage forState:UIControlStateHighlighted];
    rightBarBtn.contentMode = UIViewContentModeScaleAspectFit;
    [rightBarBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [navCoverView addSubview:rightBarBtn];
    
    [self addSubview:navCoverView];
    
}

-(void)LFFNavgationBarSystenBtn{
    navCoverView = [NavCoverView shareNavCoverView:frameRec title:_titleName];
    
    //leftBtn
    UIButton *leftBarBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBarBtn.titleLabel.font = [UIFont systemFontOfSize:textSzieFont];
    leftBarBtn.frame = CGRectMake(10, 20 , 50, 40);
    [leftBarBtn setTitle:_leftBanName forState:UIControlStateNormal];
    [leftBarBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leftBarBtn.tag = 101;
    leftBarBtn.contentMode = UIViewContentModeScaleAspectFit;
    [leftBarBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [navCoverView addSubview:leftBarBtn];
    [self addSubview:navCoverView];
    
    //rightbtn
    UIButton *rightbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    rightbtn.titleLabel.font = [UIFont systemFontOfSize:textSzieFont];
    rightbtn.frame = CGRectMake(self.bounds.size.width/2 + self.bounds.size.width/2 - leftBarBtn.frame.size.width-10, 20 , 50, 40);
    [rightbtn setTitle:_rightBtnName forState:UIControlStateNormal];
    [rightbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightbtn.tag = 102;
    rightbtn.contentMode = UIViewContentModeScaleAspectFit;
    [rightbtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [navCoverView addSubview:rightbtn];
    [self addSubview:navCoverView];
}

-(void)buttonAction:(UIButton*)btn{
    if (btn.tag == 101) {
        _leftBlock();
    }
    if (btn.tag == 102) {
        _rightBlock();
    }
}



#pragma mark - setter
-(void)setTitleName:(NSString *)titleName{
    _titleName = titleName;
}

-(void)setLeftBtnImageName:(NSString *)leftBtnImageName{
    _leftBtnImageName = leftBtnImageName;
}

-(void)setLeftBanName:(NSString *)leftBanName{
    _leftBanName = leftBanName;
}

-(void)setRightBtnInageName:(NSString *)rightBtnInageName{
    _rightBtnInageName = rightBtnInageName;
}

-(void)setRightBtnName:(NSString *)rightBtnName{
    _rightBtnName = rightBtnName;
}

@end
