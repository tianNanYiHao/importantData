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
    //可用支付工具
    NSMutableArray *payToolsArrayUsableM;
    //不可用支付工具
    NSMutableArray *payToolsArrayUnusableM;
    //处理后的整体支付工具组 (包含 可用 + 添加卡dic + 不可用)
    NSMutableArray *newPayToolsArr;
    
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



#pragma mark - 创建且添加各子视图
/**
 添加背景遮罩view
 */
- (void)addMaskBackGroundView{
    _maskBackGroundView = [[UIView alloc] initWithFrame:self.bounds];
    _maskBackGroundView.backgroundColor = [UIColor blackColor];
    _maskBackGroundView.userInteractionEnabled = YES;
    _maskBackGroundView.alpha = 0.f;
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
    //常规模式
    if (_style == SDPayViewNomal) {
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
    //仅密码键盘模式
    if (_style == SDPayViewOnlyPwd) {
        _payToolPwdView = [[SDPayToolPwdView alloc] initWithFrame:SDPayToolPwdViewDidDisapper];
        _payToolPwdView.isOnlyPayToolPwdViewStyle = YES;
        _payToolPwdView.delegate = self;
        if (selectpayToolDic) {
            _payToolPwdView.selectpayToolDic = selectpayToolDic;
        }else{
            _payToolPwdView.selectpayToolDic = [_payListArray firstObject];
        }
        _payToolPwdView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_payToolPwdView];

    }
    
    
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
        self.style = SDPayViewNomal;
        // 注册 - 接受成功支付消息后 隐藏整个支付工具View
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hidPayToolInPayPwdView) name:PaySuccessAnimationNotifaction object:nil];
    }return self;
}

- (void)setStyle:(SDPayViewStyle)style{
    _style = style;
}

#pragma mark - 统一配置支付信息
#pragma mark 配置支付工具列表
/**
 支付工具配置
 (配置原则)
 (1.优先选取 isDefault == true)支付工具作为默认返回,其余支付工具顺延,(后端不保证isDefault的工具同时其orderID最小)
 (2.若无isDefault,则取排序第一个作为默认返回)
 
 @param payTools 原始支付工具集组
 */
- (void)setPayTools:(NSArray *)payTools{
    
                        //*******payTools 必须是已排序过的payTools,在外部已经做好排序*********//
    
    //方式一: 默认支付工具不管是否可以,均置顶
//    //1.遍历 isDefault == true
//    //如果有default,则设置Default排在第一位,其余顺延
//    //如果没有default,则不做遍历
//    NSDictionary *defulPayToolDic = nil;
//    NSMutableArray *defulPayToolArrM = [NSMutableArray arrayWithCapacity:0];//包含默认支付工具(默认支付工具排第一位)的其他支付工具数组
//    for (int i = 0; i<payTools.count; i++) {
//        defulPayToolDic = payTools[i];
//        BOOL isDefault = [[defulPayToolDic objectForKey:@"isDefault"] boolValue];
//        if (isDefault) {
//            //返回默认支付工具 且 让整个支付工具顺延其后
//            if ([_delegate respondsToSelector:@selector(payViewReturnDefulePayToolDic:)]) {
//                [_delegate payViewReturnDefulePayToolDic:[NSMutableDictionary dictionaryWithDictionary:defulPayToolDic]];
//
//                NSMutableArray *payToolsArrM = [NSMutableArray arrayWithArray:payTools];
//                [payToolsArrM removeObject:defulPayToolDic];
//                for (int j = 0; j<payToolsArrM.count; j++) {
//                    [defulPayToolArrM addObject:payToolsArrM[i]];
//                }
//                //组装数组:(包含默认支付工具(默认支付工具排第一位)的其他支付工具数组)
//                [defulPayToolArrM insertObject:defulPayToolDic atIndex:0];
//                break;
//            }
//        }
//        else{
//            //do no thing
//        }
//    }
//    //default处理过的排序支付工具
//    NSArray *defaultPayToolArr = [NSArray arrayWithArray:defulPayToolArrM];
//    payTools = defaultPayToolArr.count>0?defaultPayToolArr:payTools;
    
    
    //预处理 - 支付工具 (分三块 1-可用 2-添加卡类型 3-不可用支付工具)
    //检测支付工具
    if (payTools.count>0) {
        //1.过滤可用支付工具
        payToolsArrayUsableM = [NSMutableArray arrayWithCapacity:0];
        payToolsArrayUnusableM = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i<payTools.count; i++) {
            if ([[payTools[i] objectForKey:@"available"] boolValue]== NO || [[payTools[i] objectForKey:@"type"] isEqualToString:@"1014"]) {
                //不可用支付工具集
                [payToolsArrayUnusableM addObject:payTools[i]];
            }else{
                //可用支付工具集
                [payToolsArrayUsableM addObject:payTools[i]];
            }
        }
        //2.返回默认支付工具
        //方式二: 在可用支付工具中检测默认支付工具,有则将其置顶,无则作罢
        if (payToolsArrayUsableM.count >0) {
            BOOL isDefault = NO;
            for (int i = 0; i<payToolsArrayUsableM.count; i++) {
                 NSDictionary *defulPayToolDic = payTools[i];
                 isDefault = [[defulPayToolDic objectForKey:@"isDefault"] boolValue];
                if (isDefault) {
                    //返回默认支付工具 且 让整个支付工具顺延其后
                    if ([_delegate respondsToSelector:@selector(payViewReturnDefulePayToolDic:)]) {
                        [_delegate payViewReturnDefulePayToolDic:[NSMutableDictionary dictionaryWithDictionary:defulPayToolDic]];
                        [payToolsArrayUsableM removeObject:defulPayToolDic];
                        [payToolsArrayUsableM insertObject:defulPayToolDic atIndex:0];
                        break;
                    }
                }else{
                    // do nothing
                }
            }
            //如果没有默认支付工具,则取可用优先级最高的支付工具返回
            if (!isDefault) {
                if ([_delegate respondsToSelector:@selector(payViewReturnDefulePayToolDic:)]) {
                    [_delegate payViewReturnDefulePayToolDic:[NSMutableDictionary dictionaryWithDictionary:payToolsArrayUsableM[0]]];
                }
            }
            //3.设置支付方式列表
            [self initPayMode];
        }else{
            //@"无可用支付工具"
            if ([_delegate respondsToSelector:@selector(payViewPayToolsError:)]) {
                [_delegate payViewPayToolsError:@"无可用支付工具"];
            }
        }
    }else{
        //@"无可用工具下发"
        if ([_delegate respondsToSelector:@selector(payViewPayToolsError:)]) {
            [_delegate payViewPayToolsError:@"无支付工具下发"];
        }
    }
}
#pragma mark 配置支付订单信息
- (void)setPayInfo:(NSArray *)orderInfo{
    
    if (newPayToolsArr.count>0) {
        if (_style == SDPayViewNomal) {
            _payListArray = newPayToolsArr;
            _orderTypeStr = [orderInfo firstObject];
            _moneyStr = [orderInfo lastObject];
            payToolListIndex = 0;
        }
        if (_style == SDPayViewOnlyPwd) {
            _payListArray = newPayToolsArr;
        }
    }
}

- (void)initPayMode
{
    newPayToolsArr = [NSMutableArray arrayWithCapacity:0];
    //1.添加可用
    for (int i = 0; i<payToolsArrayUsableM.count; i++) {
        [newPayToolsArr addObject:payToolsArrayUsableM[i]];
    }
    
    //2.添加卡dic
    if (_addCardType == SDPayView_ADDBANKCARD) {
        NSMutableDictionary *bankDic = [[NSMutableDictionary alloc] init];
        [bankDic setValue:@"PAYLTOOL_LIST_PAYPASS" forKey:@"type"];
        [bankDic setValue:@"添加银行卡" forKey:@"title"];
        [bankDic setValue:@"list_yinlian_AddCard" forKey:@"img"];
        [bankDic setValue:@"" forKey:@"limit"];
        [bankDic setValue:@"2" forKey:@"state"];
        [bankDic setValue:@"true" forKey:@"available"];
        [newPayToolsArr addObject:bankDic];
    }
    if (_addCardType == SDPayView_ADDSANDCARD) {
        NSMutableDictionary *cardDic = [[NSMutableDictionary alloc] init];
        [cardDic setValue:@"PAYLTOOL_LIST_ACCPASS" forKey:@"type"];
        [cardDic setValue:@"添加杉德卡" forKey:@"title"];
        [cardDic setValue:@"list_sand_AddCard" forKey:@"img"];
        [cardDic setValue:@"" forKey:@"limit"];
        [cardDic setValue:@"2" forKey:@"state"];
        [cardDic setValue:@"true" forKey:@"available"];
        [newPayToolsArr addObject:cardDic];
    }
    //3.添加不可用
    for (int i = 0; i < payToolsArrayUnusableM.count; i++) {
        [newPayToolsArr addObject:payToolsArrayUnusableM[i]];
    }
}

#pragma mark - ********** 显示 支付工具 **********
//(PS:按需加载,仅先加载-支付订单信息:payToolOrderView)

#pragma mark 外部调用 - 弹出支付工具
//外部调用方法显示
- (void)showPayTool{
    
    if (_style == SDPayViewNomal) {
        [self addMaskBackGroundView];
        [self addPayToolOrderView];
        [SDPayAnimtion maskBackGroundViewAnimation:self.maskBackGroundView showState:YES];
        [SDPayAnimtion payToolOrderViewAnimation:self.payToolOrderView frame:SDPayToolOrderViewDidLoadFrame showState:YES];
    }
    if (_style == SDPayViewOnlyPwd) {
        [self addMaskBackGroundView];
        [self addPayToolPwdView];
        [self.payToolPwdView addSDPayKeyBoardView];
        [SDPayAnimtion maskBackGroundViewAnimation:self.maskBackGroundView showState:YES];
        [SDPayAnimtion payToolPwdViewAnimation:self.payToolPwdView frame:SDPayToolPwdViewDidLoadFrame showState:YES];
    }
}

#pragma mark - ********** 隐藏/复位 支付工具 **********
#pragma mark 外部调用 - 直接(无动画效果)隐藏支付工具_需强制隐藏时调用
/**
 外部调用 - 隐藏PayTool(无动画效果,直接从页面删除)
 */
- (void)hidePayTool{
    if (_style == SDPayViewNomal) {
        //1. 订单页删除
        if (self.payToolOrderView) {
            [SDPayAnimtion payToolHidden:self.payToolOrderView];
        }
        //2. 列表页删除
        if (self.payToolListView) {
            [SDPayAnimtion payToolHidden:self.payToolListView];
        }
        //3. 密码页删除
        if (self.payToolPwdView) {
            [SDPayAnimtion payToolHidden:self.payToolPwdView];
        }
        //4. 透明背景删除
        [SDPayAnimtion payToolHidden:self.maskBackGroundView];
    }
    if (_style == SDPayViewOnlyPwd) {
        //3. 密码页删除
        [SDPayAnimtion payToolHidden:self.payToolPwdView];
        //4. 透明背景删除
        [SDPayAnimtion payToolHidden:self.maskBackGroundView];
    }
}

#pragma mark 外部调用 - 复位到待支付页并删除
// 外部调用 - 复位到待支付页并删除
- (void)resetPayToolHidden{
    [self resetOverDelay];
}

#pragma mark 外部调用 - 复位到待支付页_支付失败调用
/**
 外部调用复位方法_支付失败调用
 (方法调用背景:密码输入后,接口返回任何错误信息;)
 (调用此方法,让PayToolPwdView返回到PayToolOrderView)
 */
- (void)payPwdResetToPayOrderView{
    //借用代理方法实现
    [self payToolPwdViewjumpBackToPayToolOrderView];
}

#pragma mark 外部调用 - 隐藏支付密码页_支付成功/忘记密码调用
/**
 外部调用隐藏方法
 (方法调用背景:点击忘记密码,支付控件整体隐藏 - 跳转支付密码设置页)
 (方法调用背景:支付成功,动画类发送成功通知 - 隐藏密码页)
 (调用此方法,让PayToolPwd页面/PayToolOrder页面均下移隐藏且删除)
 */
- (void)hidPayToolInPayPwdView{
    [self hiddenPayToolViewFromePayPwdView];
}

#pragma mark 内部调用 - 隐藏支付密码页_添加银行/杉德卡调用
/**
 内部调用隐藏方法
 (方法调用背景:点击绑新卡按钮,整体下移消失 - 跳转绑卡页面)
 (调用此方法,让PayToolList页面/PayToolOrder页面均下移隐藏且删除)
 */
- (void)hidPayToolInPayListView{
    [self hiddenPayToolViewFromePayListView];
}


#pragma mark - ================= 隐藏/复位支付工具 - 内部具体实现方法 =================
/**
 延迟复位-(各子视图未复位时调用-有延迟)
 */
- (void)resetOverDelay{
    
    //各子视图复位
    //订单信息视图归位(订单信息视图归位时显示在视图)
    [SDPayAnimtion payToolOrderViewAnimation:self.payToolOrderView frame:SDPayToolOrderViewDidLoadFrame showState:YES];
    
    //支付工具列表视图归位 - 且删除
    [SDPayAnimtion payToolListViewAnimation:self.payToolListView frame:SDPayToolListViewWillLoadFrame showState:NO];
    
    //支付密码视图归位 - 且删除
    [SDPayAnimtion payToolPwdViewAnimation:self.payToolPwdView frame:SDPayToolPwdViewWillLoadFrame showState:NO];
    
    //执行隐藏
    [self performSelector:@selector(resetOverNow) withObject:self afterDelay:durationTime*1.2f];
    
}

/**
 立刻复位-(确认各子视图均归位以后可调用-无延迟)
 */
- (void)resetOverNow{
    [SDPayAnimtion maskBackGroundViewAnimation:self.maskBackGroundView showState:NO];
    [SDPayAnimtion payToolOrderViewAnimation:self.payToolOrderView frame:SDPayToolOrderViewWillLoadFrame showState:NO];
    
}
/**
 在支付密码页 - 直接隐藏整个页面
 */
- (void)hiddenPayToolViewFromePayPwdView{
    if (_style == SDPayViewNomal) {
        //1. 订单页删除
        [SDPayAnimtion payToolOrderViewAnimation:self.payToolOrderView frame:SDPayToolOrderViewRightDidDisapper showState:NO];
        //2. 列表页删除
        [SDPayAnimtion payToolListViewAnimation:self.payToolListView frame:SDPayToolListViewDidDisapper showState:NO];
        //3. 密码页删除
        [SDPayAnimtion payToolPwdViewAnimation:self.payToolPwdView frame:SDPayToolPwdViewDidDisapper showState:NO];
        //4. 透明背景删除
        [SDPayAnimtion maskBackGroundViewAnimation:self.maskBackGroundView showState:NO];
    }
    if (_style == SDPayViewOnlyPwd) {
        //4. 透明背景删除
        [SDPayAnimtion maskBackGroundViewAnimation:self.maskBackGroundView showState:NO];
        //3.密码页下移+删除
        [SDPayAnimtion payToolPwdViewAnimation:self.payToolPwdView frame:SDPayToolPwdViewDidDisapper showState:NO];
    }
    
}

/**
 在支付列表页 - 直接隐藏整个页面
 */
- (void)hiddenPayToolViewFromePayListView{
    if (_style == SDPayViewNomal) {
        //1. 订单页删除
        [SDPayAnimtion payToolOrderViewAnimation:self.payToolOrderView frame:SDPayToolOrderViewRightDidDisapper showState:NO];
        //2. 列表页删除
        [SDPayAnimtion payToolListViewAnimation:self.payToolListView frame:SDPayToolListViewDidDisapper showState:NO];
        //3. 密码页删除
        [SDPayAnimtion payToolPwdViewAnimation:self.payToolPwdView frame:SDPayToolPwdViewDidDisapper showState:NO];
        //4. 透明背景删除
        [SDPayAnimtion maskBackGroundViewAnimation:self.maskBackGroundView showState:NO];
    }
    if (_style == SDPayViewOnlyPwd) {
        //此情况不存在,故暂不处理
    }
}




#pragma mark - =================各子视图代理集=================
/*
 各个子视图每次加载,自己的代理回调负责对自己的删除
 */
#pragma - mark - SDPayToolOrderViewDelegate
- (void)payToolOrderViewJumpToSDPayToolListView{
    [self addPayToolListView];
    [SDPayAnimtion payToolOrderViewAnimation:self.payToolOrderView frame:SDPayToolOrderViewRightTranslationFrame showState:YES];
    [SDPayAnimtion payToolListViewAnimation:self.payToolListView frame:SDPayToolListViewDidLoadFrame showState:YES];
    
}
- (void)payToolOrderViewJumpToSDPayToolPwdView{
    [self addPayToolPwdView];
    [self.payToolPwdView addSDPayKeyBoardView];
    [SDPayAnimtion payToolOrderViewAnimation:self.payToolOrderView frame:SDPayToolOrderViewRightTranslationFrame showState:YES];
    [SDPayAnimtion payToolPwdViewAnimation:self.payToolPwdView frame:SDPayToolPwdViewDidLoadFrame showState:YES];
}

- (void)payToolOrderViewJumpToClosePayView{
    if ([self.delegate respondsToSelector:@selector(payViewClickCloseBtn)]) {
        [self.delegate payViewClickCloseBtn];
    }
    [self resetOverNow];
}

#pragma - mark - SDPayToolListViewDelegate
- (void)payToolListViewJumpBackToPayToolOrderView{
    [SDPayAnimtion payToolOrderViewAnimation:self.payToolOrderView frame:SDPayToolOrderViewDidLoadFrame showState:YES];
    [SDPayAnimtion payToolListViewAnimation:self.payToolListView frame:SDPayToolListViewWillLoadFrame showState:NO];
}
- (void)payToolListViewReturnPayToolDict:(NSDictionary *)selectPayToolDict index:(NSInteger)index{
    selectpayToolDic = selectPayToolDict;
    self.payToolOrderView.payToolDic = selectPayToolDict;
    payToolListIndex = index;
    if ([_delegate respondsToSelector:@selector(payViewSelectPayToolDic:)]) {
        [_delegate payViewSelectPayToolDic:[NSMutableDictionary dictionaryWithDictionary:selectPayToolDict]];
    }
    
}
- (void)payToolListViewAddPayToolCardWithpayType:(NSString *)payType{
    if ([_delegate respondsToSelector:@selector(payViewAddPayToolCard:)]) {
        [_delegate payViewAddPayToolCard:payType];
    }
    //隐藏支付工具列表页面
    [self hidPayToolInPayListView];
}


#pragma - mark - SDPayToolPwdViewDelegate
- (void)payToolPwdViewjumpBackToPayToolOrderView{
    if (_style == SDPayViewNomal) {
        [SDPayAnimtion payToolOrderViewAnimation:self.payToolOrderView frame:SDPayToolOrderViewDidLoadFrame showState:YES];
        [SDPayAnimtion payToolPwdViewAnimation:self.payToolPwdView frame:SDPayToolPwdViewWillLoadFrame showState:NO];
    }
    if (_style == SDPayViewOnlyPwd) {
        [self hidPayToolInPayPwdView];
    }
}

- (void)payToolPwdForgetReturnPwdType:(NSString *)type{
    if ([_delegate respondsToSelector:@selector(payViewForgetPwd:)]) {
        //代理回调
        [_delegate payViewForgetPwd:type];
        //隐藏支付密码页面
        [self hidPayToolInPayPwdView];
    }
}
- (void)payToolPwd:(NSString *)pwdStr paySuccessView:(SDPaySuccessAnimationView *)successView{
    if ([_delegate respondsToSelector:@selector(payViewPwd:paySuccessView:)]) {
        
        [_delegate payViewPwd:pwdStr paySuccessView:successView];
    }
}





@end
