//
//  SDPayToolView.m
//  SDPayToolViewDemo
//
//  Created by tianNanYiHao on 2017/9/7.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "SDPayView.h"


@interface SDPayView()<SDPayToolOrderViewDelegate,SDPayToolListViewDelegate,SDPayToolPwdViewDelegate>
{
    //记录支付工具列表所选择的下标 - payToollistView
    NSInteger payToolListIndex;
    //记录要输入支付密码的支付工具 - PayToolPwdView
    NSDictionary *selectpayToolDic;
}
@property (nonatomic, strong) UIView *maskBackGroundView;
@property (nonatomic, strong) SDPayToolOrderView *payToolOrderView;
@property (nonatomic, strong) SDPayToolListView  *payToolListView;
@property (nonatomic, strong) SDPayToolPwdView   *payToolPwdView;

@property (nonatomic, strong) NSArray *payListArray;
@property (nonatomic, strong) NSString *moneyStr;
@property (nonatomic, strong) NSString *orderTypeStr;


@end

@implementation SDPayView



#pragma - mark 创建且添加各子视图
/**
 添加背景遮罩view
 */
- (void)addMaskBackGroundView{
    _maskBackGroundView = [[UIView alloc] initWithFrame:self.bounds];
    _maskBackGroundView.backgroundColor = [UIColor blackColor];
    _maskBackGroundView.userInteractionEnabled = YES;
    _maskBackGroundView.alpha = 0.f;
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskBackGroundViewhidden)];
    [_maskBackGroundView addGestureRecognizer:tapRecognizer];
    [self addSubview:_maskBackGroundView];
    
}

/**
 添加订单信息view
 */
- (void)addPayToolOrderView{

    _payToolOrderView = [[SDPayToolOrderView alloc] initWithFrame:SDPayToolOrderViewWillLoadFrame];
    [_payToolOrderView setPayListArray:_payListArray moneyStr:_moneyStr orderTypeStr:_orderTypeStr];
    _payToolOrderView.delegate = self;
    _payToolOrderView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_payToolOrderView];

}

/**
 添加支付工具列表view
 */
- (void)addPayToolListView{
    _payToolListView = [[SDPayToolListView alloc] initWithFrame:SDPayToolListViewWillLoadFrame];
    _payToolListView.index = payToolListIndex;
    [_payToolListView setPayListArray:_payListArray];
    _payToolListView.delegate = self;
    _payToolListView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_payToolListView];
    
}

/**
 添加支付密码view
 */
- (void)addPayToolPwdView{
    _payToolPwdView = [[SDPayToolPwdView alloc] initWithFrame:SDPayToolPwdViewWillLoadFrame];
    _payToolPwdView.delegate = self;
    if (selectpayToolDic) {
        _payToolPwdView.selectpayToolDic = selectpayToolDic;
    }else{
        _payToolPwdView.selectpayToolDic = [_payListArray firstObject];
    }
    _payToolPwdView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_payToolPwdView];
}



#pragma - mark 初始化
+ (instancetype)getPayView{
    
    SDPayView *payView = [[SDPayView alloc] init];
    return payView;
    
}

- (instancetype)init{
    if ([super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        self.frame = [UIScreen mainScreen].bounds;
        self.hidden = YES;
    }return self;
}

#pragma - mark 统一配置支付信息
- (void)setPayInfo:(NSArray*)payArray moneyStr:(NSString*)moneyStr orderTypeStr:(NSString*)orderTypeStr{
    _payListArray = payArray;
    _moneyStr = moneyStr;
    _orderTypeStr = orderTypeStr;
    payToolListIndex = 0;
}

#pragma - mark 显示支付工具- **************          (按需加载,仅先加载-支付订单信息:payToolOrderView)
- (void)showPayTool{
    [self addMaskBackGroundView];
    [self addPayToolOrderView];
    [SDPayAnimtion maskBackGroundViewAnimation:self.maskBackGroundView showState:YES];
    [SDPayAnimtion payToolOrderViewAnimation:self.payToolOrderView frame:SDPayToolOrderViewDidLoadFrame showState:YES];
}




#pragma - mark 隐藏支付工具
/**
 延迟关闭-(各子视图未归位时调用-有延迟)
 */
- (void)hiddenOverDelay{
    //各子视图归位
    //订单信息视图归位(订单信息视图归位时显示在视图)
    [SDPayAnimtion payToolOrderViewAnimation:self.payToolOrderView frame:SDPayToolOrderViewDidLoadFrame showState:YES];
    
    //支付工具列表视图归位 - 且删除
    [SDPayAnimtion payToolListViewAnimation:self.payToolListView frame:SDPayToolListViewWillLoadFrame showState:NO];
    
    //支付密码视图归位 - 且删除
    [SDPayAnimtion payToolPwdViewAnimation:self.payToolPwdView frame:SDPayToolPwdViewWillLoadFrame showState:NO];
    
    //执行隐藏
    [self performSelector:@selector(hiddenOverNow) withObject:self afterDelay:durationTime*1.2f];
    
}

/**
 立刻关闭-(确认各子视图均归位以后可调用-无延迟)
 */
- (void)hiddenOverNow{
    [SDPayAnimtion maskBackGroundViewAnimation:self.maskBackGroundView showState:NO];
    [SDPayAnimtion payToolOrderViewAnimation:self.payToolOrderView frame:SDPayToolOrderViewWillLoadFrame showState:NO];
    
}
#pragma  - mark 手势-隐藏支付工具
- (void)maskBackGroundViewhidden{
    [self hiddenOverDelay];
}


#pragma - mark =================各子视图代理集=================
/*
 各个子视图每次加载,自己的代理回调负责对自己的删除
 */
#pragma - mark SDPayToolOrderViewDelegate
- (void)payToolOrderViewJumpToSDPayToolListView{
    [self addPayToolListView];
    [SDPayAnimtion payToolOrderViewAnimation:self.payToolOrderView frame:SDPayToolOrderViewRightTranslationFrame showState:YES];
    [SDPayAnimtion payToolListViewAnimation:self.payToolListView frame:SDPayToolListViewDidLoadFrame showState:YES];
    
}
- (void)payToolOrderViewJumpToSDPayToolPwdView{
    [self addPayToolPwdView];
    [self.payToolPwdView addSDPayKeyBoardView];
    [SDPayAnimtion payToolOrderViewAnimation:self.payToolOrderView frame:SDPayToolOrderViewRightTranslationFrame showState:YES];
    [SDPayAnimtion payToolPwdViewAnimation:self.payToolPwdView frame:SDPayPwdVewDidLoadFrame showState:YES];
}
- (void)payToolOrderViewJumpToClosePayView{
    [self hiddenOverNow];
}

#pragma - mark SDPayToolListViewDelegate
- (void)payToolListViewJumpBackToPayToolOrderView{
    [SDPayAnimtion payToolOrderViewAnimation:self.payToolOrderView frame:SDPayToolOrderViewDidLoadFrame showState:YES];
    [SDPayAnimtion payToolListViewAnimation:self.payToolListView frame:SDPayToolListViewWillLoadFrame showState:NO];
}
- (void)payToolListViewReturnPayToolDict:(NSDictionary *)selectPayToolDict index:(NSInteger)index{
    selectpayToolDic = selectPayToolDict;
    self.payToolOrderView.payToolDic = selectPayToolDict;
    payToolListIndex = index;
}
- (void)payToolListViewAddPayToolCardWithpayType:(NSString *)payType{
    if ([_delegate respondsToSelector:@selector(payViewAddPayToolCard:)]) {
        [_delegate payViewAddPayToolCard:payType];
    }
}


#pragma - mark SDPayToolPwdViewDelegate
- (void)payToolPwdViewjumpBackToPayToolOrderView{
    [SDPayAnimtion payToolOrderViewAnimation:self.payToolOrderView frame:SDPayToolOrderViewDidLoadFrame showState:YES];
    [SDPayAnimtion payToolPwdViewAnimation:self.payToolPwdView frame:SDPayToolListViewWillLoadFrame showState:NO];
}
- (void)payToolPwdForgetReturnPwdType:(NSString *)type{
    if ([_delegate respondsToSelector:@selector(payViewForgetPwd:)]) {
        [_delegate payViewForgetPwd:type];
    }
}
- (void)payToolPwd:(NSString *)pwdStr paySuccessView:(SDPaySuccessAnimationView *)successView{
    if ([_delegate respondsToSelector:@selector(payViewPwd:paySuccessView:)]) {
        [_delegate payViewPwd:pwdStr paySuccessView:successView];
    }
}

@end
