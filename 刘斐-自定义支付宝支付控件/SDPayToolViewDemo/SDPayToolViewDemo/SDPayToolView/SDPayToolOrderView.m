//
//  SDPayToolOrderView.m
//  SDPayToolViewDemo
//
//  Created by tianNanYiHao on 2017/9/7.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "SDPayToolOrderView.h"
#import "SDPayConfig.h"
@interface SDPayToolOrderView()
{
    
    //付款方式-选择: Lab
    UILabel *payWayChooseLab;
    
}
@end

@implementation SDPayToolOrderView


- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        [self setSuperView];
        
    }return self;
}

- (void)setSuperView{
    //super View Set
    self.midTitleLab.text = @"确认付款";
    [self.leftBtn addTarget:self action:@selector(closedPayView) forControlEvents:UIControlEventTouchUpInside];
}


- (void)setPayListArray:(NSArray *)payListArray moneyStr:(NSString*)moneyStr orderTypeStr:(NSString*)orderTypeStr{
    [self createUI:payListArray moneyStr:moneyStr orderTypeStr:orderTypeStr];
}


//创建UI
- (void)createUI:(NSArray*)payListArray moneyStr:(NSString*)moneyStr orderTypeStr:(NSString*)orderTypeStr{
    
    //设置数据
    NSString *accNo  = [[[payListArray firstObject] objectForKey:@"account"] objectForKey:@"accNo"];
    NSString *title  = [[payListArray firstObject] objectForKey:@"title"];
    NSString *lastfournumber = accNo.length>=4?[accNo substringFromIndex:accNo.length-4]: @"暂无显示";
    
    
    //0.payInfoView
    UIView *payInfoView = [[UIView alloc] init];
    payInfoView.backgroundColor = [UIColor whiteColor];
    [self addSubview:payInfoView];
    
    
    //1. paymoneyView
    UIView *paymoneyView = [[UIView alloc] init];
    paymoneyView.backgroundColor = [UIColor whiteColor];
    [payInfoView addSubview:paymoneyView];
    
    
    //1.1 moneyLab
    UILabel *moneyLab = [[UILabel alloc] init];
    moneyLab.text = @"¥0.01";
    moneyLab.textColor = textBlackColor;
    moneyLab.font = [UIFont systemFontOfSize:moneyLabFont];
    moneyLab.textAlignment = NSTextAlignmentCenter;
    moneyLab.text = moneyStr;
    [paymoneyView addSubview:moneyLab];
    
    
    //2 payDesView
    UIView *payDesView = [[UIView alloc] init];
    payDesView.backgroundColor = [UIColor whiteColor];
    [payInfoView addSubview:payDesView];
    
    //2.1 payOrderLab
    UILabel *payOrderLab = [[UILabel alloc] init];
    payOrderLab.text = @"订单信息";
    payOrderLab.font = [UIFont systemFontOfSize:payOrderInfoLabFont];
    payOrderLab.textColor = textGrayColor;
    [payDesView addSubview:payOrderLab];
    
    //2.2 payOrderDesLab
    UILabel *payOrderDesLab = [[UILabel alloc] init];
    payOrderDesLab.text = @"转账";
    payOrderDesLab.textAlignment = NSTextAlignmentRight;
    payOrderDesLab.font = [UIFont systemFontOfSize:payOrderInfoLabFont];
    payOrderDesLab.textColor = textBlackColor;
    payOrderDesLab.text = orderTypeStr;
    [payDesView addSubview:payOrderDesLab];
    
    
    
    UIView *lineOne = [[UIView alloc] init];
    lineOne.backgroundColor = lineColor;
    [payDesView addSubview:lineOne];
    
    
    //2.3 payWayLab
    UILabel *payWayLab = [[UILabel alloc] init];
    payWayLab.text = @"付款方式";
    payWayLab.font = [UIFont systemFontOfSize:payOrderInfoLabFont];
    payWayLab.textColor = textGrayColor;
    [payDesView addSubview:payWayLab];
    
    
    //2.4 payWayChooseBtn
    
    UIButton *payWayChooseBtn = [[UIButton alloc] init];
    payWayChooseBtn.backgroundColor = [UIColor clearColor];
    [payWayChooseBtn addTarget:self action:@selector(jumpToPayToolListView) forControlEvents:UIControlEventTouchUpInside];
    [payDesView addSubview:payWayChooseBtn];
    
   
    
    //2.4.1 payWayChooseLab
    payWayChooseLab = [[UILabel alloc] init];
    payWayChooseLab.text = @"账户余额";
    payWayChooseLab.font = [UIFont systemFontOfSize:payOrderInfoLabFont];
    payWayChooseLab.textColor = textBlackColor;
    payWayChooseLab.textAlignment = NSTextAlignmentRight;
    payWayChooseLab.text = [NSString stringWithFormat:@"%@(%@)",title,lastfournumber];
    [payWayChooseBtn addSubview:payWayChooseLab];
    
    //2.4.2
    UIImage *payWaychooseimg = [UIImage imageNamed:@"payChooseBtn"];
    UIImageView *payWayChooseImgView = [[UIImageView alloc] init];
    payWayChooseImgView.image = payWaychooseimg;
    [payWayChooseBtn addSubview:payWayChooseImgView];
    
    
    UIView *lineTwo = [[UIView alloc] init];
    lineTwo.backgroundColor = lineColor;
    [payDesView addSubview:lineTwo];

    
    
    //3.payBtn
    UIButton *payBtn = [[UIButton alloc] init];
    NSMutableAttributedString *payStr = [[NSMutableAttributedString alloc] initWithString:@"立即付款"];
    [payStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:payBtnFont],
                            NSForegroundColorAttributeName:[UIColor whiteColor]
                            } range:NSMakeRange(0, payStr.length)];
    [payBtn setAttributedTitle:payStr forState:UIControlStateNormal];
    payBtn.layer.cornerRadius = 5.f;
    payBtn.backgroundColor = payBtnColor;
    payBtn.layer.masksToBounds = YES;
    [payBtn addTarget:self action:@selector(payToolOrderViewJumpToSDPayToolPwdView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:payBtn];
    
    
    
    //setFrame
    
    CGSize moneyLabSize = [moneyLab.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:moneyLabFont]}];
    CGSize payOrderLabSize = [payOrderLab.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:payOrderInfoLabFont]}];
    

    CGFloat moneyLabOY = leftAndRightSpace;
    CGFloat payOrderLabOY = leftAndRightSpace;
    CGFloat paymoneyViewH = moneyLabSize.height + moneyLabOY *2;
    
    CGFloat payOrderLabW  = payOrderLabSize.width;
    CGFloat payOrderLabH  = payOrderLabSize.height;
    
    
    CGFloat payOrderDesLabOX = leftAndRightSpace + payOrderLabW;
    CGFloat payOrderDesLabOY = payOrderLabOY;
    CGFloat payOrderDesLabW = commWidth - payOrderLabW;
    CGFloat payOrderDesLabH = payOrderLabH;
    
    CGFloat lineOneOY = payOrderLabOY + payOrderLabH + leftAndRightSpace;
    
    CGFloat payWayLabOY = lineOneOY + lineH +leftAndRightSpace;
    CGFloat payWayLabW = payOrderLabW;
    CGFloat payWayLabH = payOrderLabH;
    
    CGFloat payDesViewH   = (payOrderLabH + 2*leftAndRightSpace)*2;

    CGFloat payInfoViewH  = paymoneyViewH + payDesViewH;
    CGFloat payInfoViewOY = CGRectGetMaxY(self.lineView.frame);
    
    CGFloat payWaychooseimgW = payWaychooseimg.size.width;
    CGFloat payWaychooseimgH = payWaychooseimg.size.height;
    
    CGFloat payWayChooseBtnOY = lineOneOY + lineH;
    CGFloat payWayChooseBtnW = commWidth - payOrderLabSize.width;
    CGFloat payWayChooseBtnH = payOrderLabH+2*leftAndRightSpace;
    
    CGFloat payWayChooseLabW = payWayChooseBtnW - payWaychooseimgW;
    CGFloat payWayChooseLabH = payOrderLabH;
    
    CGFloat payWayChooseImgViewOX = payWayChooseBtnW - payWaychooseimgW;
    CGFloat payWayChooseImgViewW = payWaychooseimgW;
    CGFloat payWayChooseImgViewH = payWaychooseimgH;
    
    payInfoView.frame = CGRectMake(0, payInfoViewOY, ScreenW, payInfoViewH);
    paymoneyView.frame = CGRectMake(0, 0, ScreenW, paymoneyViewH);
    payDesView.frame = CGRectMake(0, paymoneyViewH, ScreenW, payDesViewH);
    
    moneyLab.frame = CGRectMake(0, moneyLabOY, ScreenW, moneyLabSize.height);
    
    payOrderLab.frame = CGRectMake(leftAndRightSpace, payOrderLabOY, payWayLabW, payWayLabH);
    payOrderDesLab.frame = CGRectMake( payOrderDesLabOX, payOrderDesLabOY, payOrderDesLabW, payOrderDesLabH);
    
    lineOne.frame = CGRectMake(leftAndRightSpace, lineOneOY, commWidth+leftAndRightSpace, lineH);
    
    payWayLab.frame = CGRectMake(leftAndRightSpace, payWayLabOY, payOrderLabW, payOrderLabH);
    
    payWayChooseBtn.frame = CGRectMake(leftAndRightSpace + payOrderLabW,payWayChooseBtnOY, payWayChooseBtnW, payWayChooseBtnH);
    payWayChooseLab.frame = CGRectMake(0, leftAndRightSpace, payWayChooseLabW, payWayChooseLabH);
    
    payWayChooseImgView.frame = CGRectMake(payWayChooseImgViewOX, leftAndRightSpace, payWayChooseImgViewW, payWayChooseImgViewH);
    lineTwo.frame = CGRectMake(leftAndRightSpace, CGRectGetMaxY(payWayLab.frame)+leftAndRightSpace, commWidth+leftAndRightSpace, lineH);
    
    payBtn.frame = CGRectMake(leftAndRightSpace, self.bounds.size.height - leftAndRightSpace*3 - leftAndRightSpace, commWidth, leftAndRightSpace*3);
    
}


- (void)setPayToolDic:(NSDictionary *)payToolDic{
    
    _payToolDic = payToolDic;
    
    //设置数据
    NSString *accNo  = [[_payToolDic objectForKey:@"account"] objectForKey:@"accNo"];
    NSString *title  = [_payToolDic objectForKey:@"title"];
    NSString *lastfournumber = accNo.length>=4?[accNo substringFromIndex:accNo.length-4]: @"暂无显示";
    payWayChooseLab.text = [NSString stringWithFormat:@"%@(%@)",title,lastfournumber];
    
}


//跳转-支付工具列表
- (void)jumpToPayToolListView{
    
    if ([_delegate respondsToSelector:@selector(payToolOrderViewJumpToSDPayToolListView)]) {
        [_delegate payToolOrderViewJumpToSDPayToolListView];
    }
}
//跳转-支付密码
- (void)payToolOrderViewJumpToSDPayToolPwdView{
    if ([_delegate respondsToSelector:@selector(payToolOrderViewJumpToSDPayToolPwdView)]) {
        [_delegate payToolOrderViewJumpToSDPayToolPwdView];
    }
}

- (void)closedPayView{
    if ([_delegate respondsToSelector:@selector(payToolOrderViewJumpToClosePayView)]) {
        [_delegate payToolOrderViewJumpToClosePayView];
    }
}

#pragma - mark 




@end
