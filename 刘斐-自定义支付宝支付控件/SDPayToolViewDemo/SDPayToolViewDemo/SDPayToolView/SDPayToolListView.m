//
//  SDPayToolListView.m
//  SDPayToolViewDemo
//
//  Created by tianNanYiHao on 2017/9/8.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "SDPayToolListView.h"
#import "SDPayConfig.h"
@interface SDPayToolListView()
{
    NSArray *paylistArr; //全局记录
    NSMutableArray *stateImgArr; //记录所有状态imgview
}
@end

@implementation SDPayToolListView




- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        [self setSuperView];
    }return self;
}

- (void)setSuperView{
    //super View Set
    self.midTitleLab.text = @"请选择收付款方式";
    [self.leftBtn setImage:[UIImage imageNamed:@"payGoBack"] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setPayListArray:(NSArray *)payListArray{
    paylistArr = payListArray;
    
    stateImgArr = [NSMutableArray arrayWithCapacity:0];
    
    [self createUI:payListArray];
}

- (void)createUI:(NSArray*)payListArray{
   
    //创建UIScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.userInteractionEnabled = YES;
    scrollView.scrollEnabled = YES;
    scrollView.directionalLockEnabled = YES; //只能一个方向滑动
    scrollView.pagingEnabled = NO; //是否翻页
    scrollView.showsVerticalScrollIndicator =YES; //垂直方向的滚动指示
    scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;//滚动指示的风格
    scrollView.showsHorizontalScrollIndicator = NO;//水平方向的滚动指示
    [scrollView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:scrollView];
    
    
    CGFloat itemBtnHeight = 0;
    for (int i = 0; i<payListArray.count; i++) {
        
        //StepOne - 创建UI
        //0.父控件btn
        UIButton *itemBtn = [[UIButton alloc] init];
        itemBtn.tag = PAY_TOOL_LIST_BTN_BASE_TAG + i;
        [itemBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:itemBtn];
        
        //1.1 icon图标
        UIImage *iconImage = [UIImage imageNamed:@"qvip_pay_imageholder"];
        CGSize iconImageSize = iconImage.size;
        UIImageView *iconImageView = [[UIImageView alloc] init];
        iconImageView.image = iconImage;
        [itemBtn addSubview:iconImageView];
        
        //2.1 nameLab
        UILabel *bankNameLabel = [[UILabel alloc] init];
        bankNameLabel.text = @"中国建设银行储蓄卡(1245)";
        bankNameLabel.textColor = textBlackColor;
        bankNameLabel.font = [UIFont systemFontOfSize:paylistTitleFont];
        [itemBtn addSubview:bankNameLabel];
        
        //3.1 limitLab
        UILabel *bankLimitLabel = [[UILabel alloc] init];
        bankLimitLabel.text = @"快捷借记卡";
        bankLimitLabel.textColor = [UIColor lightGrayColor];
        bankLimitLabel.font = [UIFont systemFontOfSize:paylisttitleDesFont];
        [itemBtn addSubview:bankLimitLabel];
        
        //4.1 状态img
        UIImage *stateImage = [UIImage imageNamed:@"payListSelectedState"];
        UIImageView *stateImageView = [[UIImageView alloc] init];
        stateImageView.image = stateImage;
        stateImageView.hidden = (i == _index)?NO:YES;
        [stateImgArr addObject:stateImageView];
        [itemBtn addSubview:stateImageView];
        
        //5.1  line
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = lineColor;
        [itemBtn addSubview:line];

        
        //StepTwo - UI属性赋值
        NSDictionary *dic = payListArray[i];
        CGFloat limitFloat = 0;
        CGFloat userBalanceFloat = 0;
        
        NSString *type = [dic objectForKey:@"type"];
        NSString *title = [dic objectForKey:@"title"];
        
        //获取limit
        if (!([type isEqualToString:PAYTOOL_PAYPASS] || [type isEqualToString:PAYTOOL_ACCPASS])) {
            limitFloat = [self limitInfo:[dic objectForKey:@"limit"]]/100;
            userBalanceFloat = [[[dic objectForKey:@"account"] objectForKey:@"useableBalance"] floatValue]/100;
        }
        
        //1.2 Icon图片
        NSString *imgURLStr = [[payListArray[i] objectForKey:@"img"] length]>0 ? [payListArray[i] objectForKey:@"img"]:@"qvip_pay_imageholder";
        imgURLStr = [SDPayToolListView getIconImageName:type title:title imaUrl:imgURLStr];
        iconImageView.image = [UIImage imageNamed:imgURLStr];
        //[iconImageView sd_setImageWithURL:[NSURL URLWithString:imgURLStr] placeholderImage:[UIImage imageNamed:imgURLStr]];

        //2.2 nameLab文字
        NSString *accNo  = [[dic objectForKey:@"account"] objectForKey:@"accNo"];
        NSString *lastfournumber = accNo.length>=4?[accNo substringFromIndex:accNo.length-4]: @"暂无显示";
        bankNameLabel.text = [NSString stringWithFormat:@"%@(%@)",title,lastfournumber];
        
        //3.2 limitLab文字
         bankLimitLabel.text = [SDPayToolListView getbankLimitLabelText:type userblance:userBalanceFloat];
        
        //4.2 状态img图片
        
        
        //StepThree -UI设置Frame
        //(setFrame)设置控件的位置和大小
        CGFloat upDownSpace = SIDE_SPACE;
        CGFloat labelWidth = ScreenW - 2 * SIDE_LEFT_RIGHT - iconImageSize.width - SIDE_LEFT_RIGHT - stateImage.size.width - SIDE_SPACE;
        CGSize bankNameLabelSize = [bankNameLabel sizeThatFits:CGSizeMake(labelWidth, MAXFLOAT)];
        CGFloat bankNameLabelHeight = bankNameLabelSize.height;
        CGSize bankLimitLabelSize = [bankLimitLabel sizeThatFits:CGSizeMake(labelWidth, MAXFLOAT)];
        CGFloat bankLimitLabelHeight = bankLimitLabelSize.height;
        
        itemBtnHeight = bankNameLabelHeight + SIDE_SPACE + bankLimitLabelHeight + 2 * upDownSpace + LineBorder;
        //itemBtn
        itemBtn.frame = CGRectMake(0, i*itemBtnHeight, ScreenW, itemBtnHeight);
        
        
        //iconImage
        CGFloat iconImageViewOX = SIDE_LEFT_RIGHT;
        CGFloat iconImageViewHeight = iconImageSize.height;
        CGFloat iconImageViewOY = (itemBtnHeight - iconImageViewHeight) / 2;
        CGFloat iconImageViewWidth = iconImageSize.width;
        iconImageView.frame = CGRectMake(iconImageViewOX, iconImageViewOY, iconImageViewWidth, iconImageViewHeight);
        
        //lable1
        CGFloat bankNameLabelOX = iconImageViewOX + iconImageViewWidth + SIDE_LEFT_RIGHT;
        CGFloat bankNameLabelOY = upDownSpace;
        CGFloat bankNameLabelWidth = labelWidth;
        bankNameLabel.frame = CGRectMake(bankNameLabelOX, bankNameLabelOY, bankNameLabelWidth, bankNameLabelHeight);
        
        //lable2
        CGFloat bankLimitLabelOX = iconImageViewOX + iconImageViewWidth + SIDE_LEFT_RIGHT;
        CGFloat bankLimitLabelOY = bankNameLabelOY + bankNameLabelHeight + SIDE_SPACE;
        CGFloat bankLimitLabelWidth = labelWidth;
        bankLimitLabel.frame = CGRectMake(bankLimitLabelOX, bankLimitLabelOY, bankLimitLabelWidth, bankLimitLabelHeight);
        
        //stateImageview
        CGFloat stateImageViewOX = bankLimitLabelOX + bankLimitLabelWidth + SIDE_LEFT_RIGHT;
        CGFloat stateImageViewHeight = stateImage.size.height;
        CGFloat stateImageViewOY = (itemBtnHeight - stateImageViewHeight) / 2;
        CGFloat stateImageViewWidth = stateImage.size.width;
        stateImageView.frame = CGRectMake(stateImageViewOX, stateImageViewOY, stateImageViewWidth, stateImageViewHeight);
        
        //line
        line.frame = CGRectMake(SIDE_LEFT_RIGHT, itemBtnHeight-LineBorder, ScreenW-SIDE_LEFT_RIGHT, LineBorder);
        
        
        //StepFour - 设置例外
        //2.添加新卡部分
        if ([PAYTOOL_ACCPASS isEqualToString:type]||[PAYTOOL_PAYPASS isEqualToString:type]) {
            
            itemBtn.tag = PAY_TOOL_LIST_ADDCARDBTN_TAG;
            bankNameLabel.text = [NSString stringWithFormat:@"%@",title];
            
            CGFloat labelWidth = ScreenW - 2 * SIDE_LEFT_RIGHT - stateImage.size.width - SIDE_SPACE;
            CGSize  bankNameLabelSize = [bankNameLabel sizeThatFits:CGSizeMake(labelWidth, MAXFLOAT)];
            CGFloat bankNameLabelHeight = bankNameLabelSize.height;
            
            CGFloat bankNameLabelOX = SIDE_LEFT_RIGHT + iconImageViewWidth + SIDE_LEFT_RIGHT;
            CGFloat bankNameLabelOY = (itemBtnHeight - bankNameLabelHeight) / 2;
            CGFloat bankNameLabelWidth = labelWidth - SIDE_LEFT_RIGHT*2;
            bankNameLabel.frame = CGRectMake(bankNameLabelOX, bankNameLabelOY, bankNameLabelWidth, bankNameLabelHeight);
            
            bankLimitLabel.frame = CGRectZero;
            
            stateImageView.frame = CGRectZero;
            
        } else {
            //3.不可用支付工具部分 (代付凭证模式不作为支付工具列表展示项)
            if ([[dic objectForKey:@"available"] boolValue] == NO || [[dic objectForKey:@"type"] isEqualToString:@"1014"]) {
                itemBtn.userInteractionEnabled = NO;
                iconImageView.image = [UIImage imageNamed:@"notPay"];
                bankLimitLabel.text = @"暂不支持当前交易";
                bankNameLabel.textColor = [UIColor lightGrayColor];
                stateImageView.hidden = YES;
            }
        }
    }
    
    
    //重置ScrollerView滚动区间及frame
    itemBtnHeight = payListArray.count*itemBtnHeight;
    CGFloat headTitleViewH = CGRectGetMaxY(self.lineView.frame);
    scrollView.frame = CGRectMake(0, headTitleViewH, ScreenW, ViewBaseH - headTitleViewH);
    scrollView.contentSize = CGSizeMake(ScreenW, itemBtnHeight);
    
    
}

- (void)goBack{
    
    if ([_delegate respondsToSelector:@selector(payToolListViewJumpBackToPayToolOrderView)]) {
        [_delegate payToolListViewJumpBackToPayToolOrderView];
    }

}

- (void)goBack:(UIButton*)btn{
    
    //1.添加新卡代理回调
    if (btn.tag == PAY_TOOL_LIST_ADDCARDBTN_TAG) {
      
        if ([_delegate respondsToSelector:@selector(payToolListViewAddPayToolCardWithpayType:)]) {
            for (int i = 0; i<paylistArr.count; i++) {
                NSDictionary *dic = paylistArr[i];
                NSString *title = [dic objectForKey:@"type"];
                if ([title isEqualToString:PAYTOOL_PAYPASS]) {
                    [_delegate payToolListViewAddPayToolCardWithpayType:title];
                }
                else if ([title isEqualToString:PAYTOOL_ACCPASS]){
                     [_delegate payToolListViewAddPayToolCardWithpayType:title];
                }
            }
        }
    }
    //2.支付工具选择回调
    else{
        NSInteger indexNum = btn.tag - PAY_TOOL_LIST_BTN_BASE_TAG;
        NSDictionary *selectPayToolDic = paylistArr[indexNum];
        if ([_delegate respondsToSelector:@selector(payToolListViewReturnPayToolDict:index:)]) {
            [_delegate payToolListViewReturnPayToolDict:selectPayToolDic index:indexNum];
        }
    }
    
    
    //3.UI回退
    if ([_delegate respondsToSelector:@selector(payToolListViewJumpBackToPayToolOrderView)]) {
        [_delegate payToolListViewJumpBackToPayToolOrderView];
    }

}

#pragma - mark ================CommFunc==============
/**
 limit域最大限额

 */
-(CGFloat)limitInfo:(NSDictionary*)limitDic{
    
    //单月最高
    NSString *month = [limitDic objectForKey:@"month"];
    
    //单月可用
    NSString *monthRemain = [limitDic objectForKey:@"monthRemain"];
    CGFloat monthRemainFloat = [monthRemain floatValue];
    //单日最高
    NSString *day = [limitDic objectForKey:@"day"];
    
    //单日可用
    NSString *dayRemain = [limitDic objectForKey:@"dayRemain"];
    CGFloat dayRemainFloat = [dayRemain floatValue];
    
    //单笔
    NSString *single = [limitDic objectForKey:@"single"];
    CGFloat singleFloat = [single floatValue];
    
    monthRemainFloat = monthRemainFloat<dayRemainFloat?monthRemainFloat:dayRemainFloat;
    monthRemainFloat = monthRemainFloat<singleFloat?monthRemainFloat:singleFloat;
    return monthRemainFloat;
}


#pragma mark - 获取paylist列表icon
+ (NSString *)getIconImageName:(NSString*)type title:(NSString*)title imaUrl:(NSString*)imaUrl{
    if ([@"1001" isEqualToString:type]){
        NSArray *bankInfoArr = [self getBankIconInfo:title];
        return [bankInfoArr[0] accessibilityIdentifier];
    }
    else if ([@"1002" isEqualToString:type]) {
        NSArray *bankInfoArr = [self getBankIconInfo:title];
        return [bankInfoArr[0] accessibilityIdentifier];
    }
    else if ([@"1003" isEqualToString:type]) {
        return @"list_sand_logo";
    }
    else if ([@"1004" isEqualToString:type]) {
        return @"qvip_pay_imageholder";
    }
    else if ([@"1005" isEqualToString:type]) {
        return @"list_cash";
    }
    else if ([@"1006" isEqualToString:type]) {
        return @"list_xiaofei";
    }
    else if ([@"1007" isEqualToString:type]) {
        //return @"久璋宝杉德币账户";
        return @"qvip_pay_imageholder";
    }
    else if ([@"1008" isEqualToString:type]) {
        //return @"久璋宝专用账户";
        return @"qvip_pay_imageholder";
    }
    else if ([@"1009" isEqualToString:type]) {
        //return @"久璋宝通用账户";
        return @"qvip_pay_imageholder";
    }
    else if ([@"1010" isEqualToString:type]) {
        //return @"会员卡账户";
        return @"qvip_pay_imageholder";
    }
    else if ([@"1011" isEqualToString:type]) {
        NSArray *bankInfoArr = [self getBankIconInfo:title];
        return [bankInfoArr[0] accessibilityIdentifier];
    }
    else if ([@"1012" isEqualToString:type]) {
        NSArray *bankInfoArr = [self getBankIconInfo:title];
        return [bankInfoArr[0] accessibilityIdentifier];
    }
    else if ([@"1014" isEqualToString:type]) {
        return @"list_sand_logo";
    }
    else if([PAYTOOL_PAYPASS isEqualToString:type] || [PAYTOOL_ACCPASS isEqualToString:type]){ //添加卡按钮
        if ([imaUrl isEqualToString:@"list_yinlian_AddCard"]) {
            return @"list_yinlian_AddCard";
        }else if ([imaUrl isEqualToString:@"list_sand_AddCard"]){
            return @"list_sand_AddCard";
        }
    }
    return @"qvip_pay_imageholder";
}

#pragma mark - 银行icon数据获取
+ (NSArray*)getBankIconInfo:(NSString*)bankName{
    
    NSArray *arrayInfo = [NSArray new];
    //背景和图标
    UIImage *iconImage;
    
    NSArray *bankNameArray = @[@"工商银行",@"建设银行",@"农业银行",@"招商银行",@"交通银行",@"中国银行",@"光大银行",@"民生银行",@"兴业银行",@"中信银行",@"广发银行",@"浦发银行",@"平安银行",@"华夏银行",@"宁波银行",@"东亚银行",@"上海银行",@"中国邮储银行",@"南京银行",@"上海农商行",@"渤海银行",@"成都银行",@"北京银行",@"徽商银行",@"天津银行"];
    
    NSArray *bankImageNameArray = @[@"banklist_gs",@"banklist_js",@"banklist_nh",@"banklist_zs",@"banklist_jt",@"banklist_gh",@"banklist_gd",@"banklist_ms",@"banklist_xy",@"banklist_zx",@"banklist_gf",@"banklist_pf",@"banklist_pa",@"banklist_hx",@"banklist_nb",@"banklist_dy",@"banklist_sh",@"banklist_yz",@"banklist_nj",@"banklist_shns",@"banklist_bh",@"banklist_cd",@"banklist_bj",@"banklist_hs",@"banklist_tj"];
    
    for (int i = 0; i<bankNameArray.count; i++) {
        if ([bankName containsString:[bankNameArray[i] substringToIndex:2]]) {
            iconImage = [UIImage imageNamed:bankImageNameArray[i]];
            [iconImage setAccessibilityIdentifier:bankImageNameArray[i]];
        }
    }
    arrayInfo = @[iconImage];
    return arrayInfo;
    
}

#pragma mark - 获取payList列表不同支付工具描述
+ (NSString *)getbankLimitLabelText:(NSString*)type userblance:(CGFloat)userBalanceFloat{
    if ([@"1001" isEqualToString:type]){
        return @"快捷借记卡";
    }
    else if ([@"1002" isEqualToString:type]) {
        return @"快捷贷记卡";
    }
    else if ([@"1003" isEqualToString:type]) {
        return [NSString stringWithFormat:@"可用余额%.2f元",userBalanceFloat];;
    }
    else if ([@"1004" isEqualToString:type]) {
        return [NSString stringWithFormat:@"可用余额%.2f元",userBalanceFloat];;
    }
    else if ([@"1005" isEqualToString:type]) {
        return [NSString stringWithFormat:@"可用余额%.2f元",userBalanceFloat];;
    }
    else if ([@"1006" isEqualToString:type]) {
        return [NSString stringWithFormat:@"可用余额%.2f元",userBalanceFloat];;
    }
    else if ([@"1007" isEqualToString:type]) {
        return @"久璋宝杉德币账户";
    }
    else if ([@"1008" isEqualToString:type]) {
        return @"久璋宝专用账户";
    }
    else if ([@"1009" isEqualToString:type]) {
        return @"久璋宝通用账户";
    }
    else if ([@"1010" isEqualToString:type]) {
        return @"会员卡账户";
    }
    else if ([@"1011" isEqualToString:type]) {
        return @"网银借记卡";
    }
    else if ([@"1012" isEqualToString:type]) {
        return @"网银贷记卡";
    }
    else if ([@"1014" isEqualToString:type]) {
        return @"代付凭证";
    }
    else{
        return @"   ";
    }
}




@end
