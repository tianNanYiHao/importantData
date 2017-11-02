//
//  SDBottomPop.m
//  SDpopViewDemo
//
//  Created by tianNanYiHao on 2017/11/2.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "SDBottomPop.h"

#define btn_tag_cancle 200

@interface SDBottomPop ()
{
    
}

/**
 透明背景view
 */
@property (nonatomic, strong) UIView *backGroundView;
/**
 遮罩view
 */
@property (nonatomic, strong) UIView *maskBlackView;

/**
 整体高度
 */
@property (nonatomic, assign) CGFloat allHeight;


@property (nonatomic, copy) SDBottomPopSureBlock sureblock;
@property (nonatomic, copy) SDBottomPopCancleBlock cancleblock;

@end

@implementation SDBottomPop


+ (void)showBottomPopView:(NSString*)tipStr cellNameList:(NSArray*)cellNameArr suerBlock:(SDBottomPopSureBlock)sureBlock cancleBlock:(SDBottomPopCancleBlock)cancleBlock{
    
    SDBottomPop *pop = [[SDBottomPop alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    pop.backgroundColor = [UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1/1.0];
    pop.sureblock = sureBlock;
    pop.cancleblock = cancleBlock;
    
    
    //tipView
    UIView *tipView = [[UIView alloc] init];
    tipView.backgroundColor = [UIColor whiteColor];
    [pop addSubview:tipView];
    
    //tipLab
    UILabel *tipLab = [[UILabel alloc] init];
    tipLab.text = @"解除绑定后银行服务将不可用";
    tipLab.textAlignment = NSTextAlignmentCenter;
    tipLab.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    tipLab.textColor = [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1/1.0];
    [tipView addSubview:tipLab];
    
    CGFloat tipLabSpace = 23.f;
    CGSize tipLabSize = [tipLab sizeThatFits:CGSizeZero];
    tipLab.frame = CGRectMake(0, tipLabSpace, [UIScreen mainScreen].bounds.size.width, tipLabSize.height);
    tipView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, tipLabSpace*2 + tipLabSize.height);
    
    
    
    //cellNameBtn
    CGFloat btnSpace = 0.7f;
    CGFloat firstBtnOY = tipView.frame.size.height;
    CGFloat btnCellAllHeight = 0;
    for (int i = 0; i<cellNameArr.count; i++) {
        
        UIButton *btn = [pop addCellBtn:i cellName:cellNameArr[i]];
        CGSize btnSize = btn.frame.size;
        btn.frame = CGRectMake(0, btnSize.height*i+ (btnSpace*(i+1) + firstBtnOY), [UIScreen mainScreen].bounds.size.width, btnSize.height);
        [pop addSubview:btn];
        
        if (i == cellNameArr.count-1) {
            btnCellAllHeight = btnSize.height * cellNameArr.count + btnSpace *cellNameArr.count;
        }
    }
    
    //canceBtn
    CGFloat cancleBtnSpace = 6.f;
    UIButton *cancleBtn = [pop addCancleBtn];
    [pop addSubview:cancleBtn];
    CGFloat cancleBtnOY = tipView.frame.size.height + btnCellAllHeight + cancleBtnSpace;
    cancleBtn.frame = CGRectMake(0, cancleBtnOY, [UIScreen mainScreen].bounds.size.width, cancleBtn.frame.size.height);
    
    
    
    //重置pop的Frame
    CGFloat allHeight = cancleBtnOY + cancleBtn.frame.size.height;
    pop.allHeight = allHeight;
    pop.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, allHeight);
    
    
    [pop show];
    
}


- (void)show{
    
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    [window addSubview:self.backGroundView];
    [self showAnimation:YES];
}

- (void)hidden{
    
    [self showAnimation:NO];
    
}
- (void)showAnimation:(BOOL)isShow{
    
    if (isShow) {
        [UIView animateWithDuration:0.35 animations:^{
            self.maskBlackView.alpha = 0.4f;
            self.alpha = 1.f;
            self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - self.allHeight, [UIScreen mainScreen].bounds.size.width, self.allHeight);
        } completion:^(BOOL finished) {
            
        }];
    }
    if (!isShow) {
        [UIView animateWithDuration:0.35f animations:^{
            self.maskBlackView.alpha = 0.f;
            self.alpha = 0.f;
            self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, self.allHeight);
        } completion:^(BOOL finished) {
            [self.backGroundView removeFromSuperview];
            [self.maskBlackView removeFromSuperview];
            [self removeFromSuperview];
            
        }];
    }
}


- (void)clickBtn:(UIButton*)btn{
    
    if (btn.tag == btn_tag_cancle) {
        
        [self hidden];
        self.cancleblock();

    }else{
        
        [self hidden];
        NSString *str = btn.titleLabel.text;
        //延迟0.35 等待动画结束后 回调消息
        [self performSelector:@selector(delayBlockCellName:) withObject:str afterDelay:0.35];
        
    }
    
    
}

- (void)delayBlockCellName:(NSString*)obj{
    
    self.sureblock(obj);
    
}


/**
 创建 列表按钮

 @param index 下标
 @param cellName 列表名
 @return 实例
 */
- (UIButton*)addCellBtn:(NSInteger)index cellName:(NSString*)cellName{
    
    UIButton *cellBtn = [[UIButton alloc] init];
    [cellBtn setTitle:cellName forState:UIControlStateNormal];
    [cellBtn setTitleColor:[UIColor colorWithRed:230/255.0 green:67/255.0 blue:64/255.0 alpha:1/1.0] forState:UIControlStateNormal];
    cellBtn.titleLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:18];
    cellBtn.backgroundColor = [UIColor whiteColor];
    cellBtn.tag = 100 + index;
    [cellBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat space = 13;
    CGSize cellBtnSizeOrigle = [cellBtn sizeThatFits:CGSizeZero];
    CGSize cellNameBtnSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, cellBtnSizeOrigle.height + 2*space);
    cellBtn.frame = CGRectMake(0, 0, cellNameBtnSize.width, cellNameBtnSize.height);
    return cellBtn;
    
}

/**
 创建取消按钮

 @return 实例
 */
- (UIButton*)addCancleBtn{
    
    UIButton *cancleBtn = [[UIButton alloc] init];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancleBtn.titleLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:18];
    cancleBtn.backgroundColor = [UIColor whiteColor];
    cancleBtn.tag = btn_tag_cancle;
    [cancleBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat space = 13;
    CGSize cancleBtnSizeOrigle = [cancleBtn sizeThatFits:CGSizeZero];
    CGSize cancleBtnSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, cancleBtnSizeOrigle.height + 2*space);
    cancleBtn.frame = CGRectMake(0, 0, cancleBtnSize.width, cancleBtnSize.height);
    return cancleBtn;
    
}



#pragma mark - lazyLoad

-(UIView*)backGroundView{
    
    if (!_backGroundView) {
        _backGroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backGroundView.backgroundColor = [UIColor clearColor];
        
        //背景View 添加 遮罩
        [_backGroundView addSubview:self.maskBlackView];
        //背景View 添加 popView
        [_backGroundView addSubview:self];
    }
    return _backGroundView;
}

-(UIView*)maskBlackView{
    if (!_maskBlackView) {
        _maskBlackView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _maskBlackView.backgroundColor = [UIColor blackColor];
        _maskBlackView.alpha = 0.f;
        UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidden)];
        [_maskBlackView addGestureRecognizer:tapGest];
        
    }
    return _maskBlackView;
}





@end
