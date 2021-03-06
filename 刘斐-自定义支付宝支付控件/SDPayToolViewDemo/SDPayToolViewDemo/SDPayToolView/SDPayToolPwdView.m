//
//  SDPayToolPwdView.m
//  SDPayToolViewDemo
//
//  Created by tianNanYiHao on 2017/9/8.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "SDPayToolPwdView.h"
#import "SDPayConfig.h"

@interface SDPayToolPwdView()<SDPayKeyBoardViewDelegate>
{
    NSString *payPwd;
    NSString *type;  //支付工具支付类型
    SDPayKeyBoardView *keyBoardView;
    SDPaySuccessAnimationView *successAnimationView;
}
@property (strong, nonatomic) UITextField *pwdTextFieldOne, *pwdTextFieldTwo, *pwdTextFieldThree, *pwdTextFieldFour, *pwdTextFieldFive, *pwdTextFieldSix;
@end

@implementation SDPayToolPwdView

@synthesize pwdTextFieldOne, pwdTextFieldTwo, pwdTextFieldThree, pwdTextFieldFour, pwdTextFieldFive, pwdTextFieldSix;


#pragma - mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        [self setSuperView];
        [self createUI];
    }return self;
}

- (void)setSuperView{
    //super View Set
    self.midTitleLab.text = @"请输入支付密码";
    [self.leftBtn setImage:[UIImage imageNamed:@"payGoBack"] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
}

- (void)goBack{
    
    if ([_delegate respondsToSelector:@selector(payToolPwdViewjumpBackToPayToolOrderView)]) {
        [_delegate payToolPwdViewjumpBackToPayToolOrderView];
    }
    
}

- (void)setIsOnlyPayToolPwdViewStyle:(BOOL)isOnlyPayToolPwdViewStyle{
    
    [self.leftBtn setImage:[UIImage imageNamed:@"payClosed"] forState:UIControlStateNormal];
}

- (void)createUI{
    CGFloat lineViewMaxY = CGRectGetMaxY(self.lineView.frame)+LineBorder;
    CGFloat pwdTextFieldBorderWidth = 0.6f;
    CGFloat allPwdTextFieldBorderWidth = pwdTextFieldBorderWidth * 5;
    CGFloat pwdTextFieldWidth = (ScreenW - 2*SIDE_LEFT_RIGHT - allPwdTextFieldBorderWidth)/6;
    CGFloat pwdTextFieldHeight = pwdTextFieldWidth;
    CGFloat allPwdTextFieldWidth = pwdTextFieldWidth * 6;
    CGFloat pwdTextFieldBackgroundViewW = allPwdTextFieldWidth + allPwdTextFieldBorderWidth;

    //baseView
    UIView *payPwdPayBaseView = [[UIView alloc] init];
    payPwdPayBaseView.backgroundColor =  [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1/1.0];
    [self addSubview:payPwdPayBaseView];
    
    //  密码输入框
    CGFloat pwdTextFieldOY = AdapterHfloat(45);
    
    //背景框
    UIView *pwdTextFieldBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(SIDE_LEFT_RIGHT, pwdTextFieldOY, allPwdTextFieldWidth+allPwdTextFieldBorderWidth, pwdTextFieldHeight)];
    pwdTextFieldBackgroundView.backgroundColor = pwdBackGroundColor;
    pwdTextFieldBackgroundView.layer.borderColor = pwdBorderColor.CGColor;
//    pwdTextFieldBackgroundView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
//    pwdTextFieldBackgroundView.layer.shadowOffset = CGSizeMake(0, 0);
//    pwdTextFieldBackgroundView.layer.shadowRadius = 4.f;
//    pwdTextFieldBackgroundView.layer.shadowOpacity = 1.f;
//    pwdTextFieldBackgroundView.layer.masksToBounds = YES;
    [payPwdPayBaseView addSubview:pwdTextFieldBackgroundView];
    

    
    
    pwdTextFieldOne = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, pwdTextFieldWidth, pwdTextFieldHeight)];
    pwdTextFieldOne.textAlignment= NSTextAlignmentCenter;
    pwdTextFieldOne.textColor= pwdTextFieldTextColor;
    [pwdTextFieldOne setSecureTextEntry:YES];
    pwdTextFieldOne.font= [UIFont systemFontOfSize:pwdTextFieldTextSizeFont];
    pwdTextFieldOne.layer.borderWidth= pwdTextFieldBorderWidth;
    [pwdTextFieldOne setEnabled:NO];
    pwdTextFieldOne.backgroundColor = [UIColor whiteColor];
    pwdTextFieldOne.layer.borderColor = [UIColor whiteColor].CGColor;
    [pwdTextFieldBackgroundView addSubview:pwdTextFieldOne];
    
    pwdTextFieldTwo = [[UITextField alloc] initWithFrame:CGRectMake(pwdTextFieldWidth + pwdTextFieldBorderWidth, 0, pwdTextFieldWidth, pwdTextFieldHeight)];
    pwdTextFieldTwo.textAlignment= NSTextAlignmentCenter;
    pwdTextFieldTwo.textColor= pwdTextFieldTextColor;
    [pwdTextFieldTwo setSecureTextEntry:YES];
    pwdTextFieldTwo.font= [UIFont systemFontOfSize:pwdTextFieldTextSizeFont];
    pwdTextFieldTwo.layer.borderWidth= pwdTextFieldBorderWidth;
    [pwdTextFieldTwo setEnabled:NO];
    pwdTextFieldTwo.backgroundColor = [UIColor whiteColor];
    pwdTextFieldTwo.layer.borderColor = [UIColor whiteColor].CGColor;
    [pwdTextFieldBackgroundView addSubview:pwdTextFieldTwo];
    
    
    pwdTextFieldThree = [[UITextField alloc] initWithFrame:CGRectMake(pwdTextFieldWidth * 2 + pwdTextFieldBorderWidth * 2, 0, pwdTextFieldWidth, pwdTextFieldHeight)];
    pwdTextFieldThree.textAlignment= NSTextAlignmentCenter;
    pwdTextFieldThree.textColor= pwdTextFieldTextColor;
    [pwdTextFieldThree setSecureTextEntry:YES];
    pwdTextFieldThree.font= [UIFont systemFontOfSize:pwdTextFieldTextSizeFont];
    pwdTextFieldThree.layer.borderWidth=pwdTextFieldBorderWidth;
    [pwdTextFieldThree setEnabled:NO];
    pwdTextFieldThree.backgroundColor = [UIColor whiteColor];
    pwdTextFieldThree.layer.borderColor = [UIColor whiteColor].CGColor;
    [pwdTextFieldBackgroundView addSubview:pwdTextFieldThree];
    
    pwdTextFieldFour = [[UITextField alloc] initWithFrame:CGRectMake(pwdTextFieldWidth * 3 + pwdTextFieldBorderWidth * 3, 0, pwdTextFieldWidth, pwdTextFieldHeight)];
    pwdTextFieldFour.textAlignment= NSTextAlignmentCenter;
    pwdTextFieldFour.textColor= pwdTextFieldTextColor;
    [pwdTextFieldFour setSecureTextEntry:YES];
    pwdTextFieldFour.font= [UIFont systemFontOfSize:pwdTextFieldTextSizeFont];
    pwdTextFieldFour.layer.borderWidth=pwdTextFieldBorderWidth;
    pwdTextFieldFour.backgroundColor = [UIColor whiteColor];
    pwdTextFieldFour.layer.borderColor = [UIColor whiteColor].CGColor;
    [pwdTextFieldFour setEnabled:NO];
    [pwdTextFieldBackgroundView addSubview:pwdTextFieldFour];
    
    pwdTextFieldFive = [[UITextField alloc] initWithFrame:CGRectMake(pwdTextFieldWidth * 4 + pwdTextFieldBorderWidth * 4, 0, pwdTextFieldWidth, pwdTextFieldHeight)];
    pwdTextFieldFive.textAlignment= NSTextAlignmentCenter;
    pwdTextFieldFive.textColor= pwdTextFieldTextColor;
    [pwdTextFieldFive setSecureTextEntry:YES];
    pwdTextFieldFive.font= [UIFont systemFontOfSize:pwdTextFieldTextSizeFont];
    pwdTextFieldFive.layer.borderWidth=pwdTextFieldBorderWidth;
    pwdTextFieldFive.backgroundColor = [UIColor whiteColor];
    pwdTextFieldFive.layer.borderColor = [UIColor whiteColor].CGColor;
    [pwdTextFieldFive setEnabled:NO];
    [pwdTextFieldBackgroundView addSubview:pwdTextFieldFive];
    
    pwdTextFieldSix = [[UITextField alloc] initWithFrame:CGRectMake(pwdTextFieldWidth * 5 + pwdTextFieldBorderWidth * 5, 0, pwdTextFieldWidth, pwdTextFieldHeight)];
    pwdTextFieldSix.textAlignment= NSTextAlignmentCenter;
    pwdTextFieldSix.textColor= pwdTextFieldTextColor;
    [pwdTextFieldSix setSecureTextEntry:YES];
    pwdTextFieldSix.font= [UIFont systemFontOfSize:pwdTextFieldTextSizeFont];
    pwdTextFieldSix.layer.borderWidth=pwdTextFieldBorderWidth;
    pwdTextFieldSix.backgroundColor = [UIColor whiteColor];
    pwdTextFieldSix.layer.borderColor = [UIColor whiteColor].CGColor;
    [pwdTextFieldSix setEnabled:NO];
    [pwdTextFieldBackgroundView addSubview:pwdTextFieldSix];
    
    //密码输入框覆盖层按钮 - 用于密码键盘消失后触发唤起/用于外边框圆角展示
    UIButton *pwdTextFieldBackgroundCoverbtn = [[UIButton alloc] init];
    pwdTextFieldBackgroundCoverbtn.backgroundColor = [UIColor clearColor];
    pwdTextFieldBackgroundCoverbtn.tag = 89999;
    [pwdTextFieldBackgroundCoverbtn addTarget:self action:@selector(addSDPayKeyBoardView) forControlEvents:UIControlEventTouchUpInside];
    pwdTextFieldBackgroundCoverbtn.frame = CGRectMake(SIDE_LEFT_RIGHT, pwdTextFieldOY, allPwdTextFieldWidth+allPwdTextFieldBorderWidth, pwdTextFieldHeight);
    pwdTextFieldBackgroundCoverbtn.layer.borderColor = pwdBorderColor.CGColor;
    pwdTextFieldBackgroundCoverbtn.layer.borderWidth = 0.9f;
    pwdTextFieldBackgroundCoverbtn.layer.cornerRadius = 5.f;
    [payPwdPayBaseView addSubview:pwdTextFieldBackgroundCoverbtn];
    
    
    //  忘记密码
    UIButton *forgetPayPwdBtn = [[UIButton alloc] init];
    [forgetPayPwdBtn setTitle:@"忘记支付密码？" forState: UIControlStateNormal];
    forgetPayPwdBtn.titleLabel.font = [UIFont systemFontOfSize:AdapterFfloat(13)];
    [forgetPayPwdBtn setTitleColor:forgetPwdTextColor forState:UIControlStateNormal];
    forgetPayPwdBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [forgetPayPwdBtn addTarget:self action:@selector(forgetPwd:) forControlEvents:UIControlEventTouchUpInside];
    [payPwdPayBaseView addSubview:forgetPayPwdBtn];
    
    //由于杉德宝产品流程限制, 不支持支付过程中新开流程进行忘记密码操作,故暂时隐藏忘记支付密码功能
    forgetPayPwdBtn.hidden = YES;

    
    
    CGSize forgetPayPwdBtnSize = [forgetPayPwdBtn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:pwdTextFieldTextSizeFont]}];
    CGFloat forgetPayPwdBtnWidth = forgetPayPwdBtnSize.width;
    CGFloat forgetPayPwdBtnOX = SIDE_LEFT_RIGHT;
    CGFloat forgetPayPwdBtnOY = pwdTextFieldOY + pwdTextFieldHeight + SIDE_SPACE;
    CGFloat forgetPayPwdBtnHeight = forgetPayPwdBtnSize.height;
    
    forgetPayPwdBtn.frame = CGRectMake(forgetPayPwdBtnOX, forgetPayPwdBtnOY, forgetPayPwdBtnWidth, forgetPayPwdBtnHeight);
    
    //重置密码框背景
    pwdTextFieldBackgroundView.frame = CGRectMake(SIDE_LEFT_RIGHT, pwdTextFieldOY, pwdTextFieldBackgroundViewW, pwdTextFieldHeight);
    
    CGFloat payPwdViewHeight = forgetPayPwdBtnOY + forgetPayPwdBtnHeight + SIDE_LEFT_RIGHT;
    
    payPwdPayBaseView.frame = CGRectMake(0, lineViewMaxY, ScreenW, payPwdViewHeight);
    
    
    
    //
    CGFloat successAnimViewW = ScreenW/3;
    CGFloat successAnimViewOX = ScreenW/3;
    CGFloat successAnimViewOY = CGRectGetMaxY(payPwdPayBaseView.frame)+SIDE_LEFT_RIGHT;
    
    successAnimationView = [SDPaySuccessAnimationView createCircleSuccessView:CGRectMake(successAnimViewOX, successAnimViewOY, successAnimViewW, successAnimViewW)];
    successAnimationView.circleLineWidth = 5.f;
    successAnimationView.circleBackGroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1/1.0];
    successAnimationView.circleLineColor = paySuccessAnimationViewCricleColor;
    successAnimationView.lineSuccessColor = paySuccessAnimationViewCricleColor;
    [self addSubview:successAnimationView];
    [successAnimationView buildPath];
    
   
}
//根据支付类型决定标题展示
- (void)setSelectpayToolDic:(NSDictionary *)selectpayToolDic{
    _selectpayToolDic = selectpayToolDic;
    NSDictionary *authToolsDic = [[_selectpayToolDic objectForKey:@"authTools"] firstObject];
    
    if (authToolsDic != nil) {
        type = [authToolsDic objectForKey:@"type"];
    }
    //若 authTools 为空,则当前业务为提现/??/??
    else{
        type = @"paypass";
    }
    if ([type isEqualToString:@"paypass"]) {
        self.midTitleLab.text = @"请输入支付密码";
    }else if ([type isEqualToString:@"accpass"]){
        self.midTitleLab.text = @"请输入主账户密码";
    }else{
        self.midTitleLab.text = @"请输入支付密码";
    }
}

//添加杉德支付键盘
- (void)addSDPayKeyBoardView{
    if (!keyBoardView) {
        keyBoardView = [SDPayKeyBoardView keyBoardAddWith:self];
        keyBoardView.delegate = self;
        [self addSubview:keyBoardView];
    }
}


#pragma - mark  ==================按钮事件处理==================

/**
 忘记密码按钮

 @param sender 按钮
 */
-(void)forgetPwd:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(payToolPwdForgetReturnPwdType:)]) {
        //1.页面回退
        if ([_delegate respondsToSelector:@selector(payToolPwdViewjumpBackToPayToolOrderView)]) {
//            [_delegate payToolPwdViewjumpBackToPayToolOrderView];
        }
        
        //2.代理回调
        if ([type isEqualToString:@"accpass"]) {
            if ([_delegate respondsToSelector:@selector(payToolPwdForgetReturnPwdType:)]) {
                [_delegate payToolPwdForgetReturnPwdType:PAYTOOL_ACCPASS];
            }
        }
        if ([type isEqualToString:@"paypass"]) {
            if ([_delegate respondsToSelector:@selector(payToolPwdForgetReturnPwdType:)]) {
                [_delegate payToolPwdForgetReturnPwdType:PAYTOOL_PAYPASS];
            }
        }
    }
}

#pragma - mark payKeyBoardViewdelegate ==================键盘事件代理=================
- (void)payKeyBoardCurrentTitle:(UIButton *)btn{
    //键盘消失按钮
    if (btn.tag == 90000) {
        [keyBoardView hiddenDownPayKeyBoardView];
        keyBoardView = nil;
    }
    //回退按钮
    else if (btn.tag == 90001){
        if(payPwd.length==0)
        {
            pwdTextFieldOne.text=@"";
            pwdTextFieldTwo.text=@"";
            pwdTextFieldThree.text=@"";
            pwdTextFieldFour.text=@"";
            pwdTextFieldFive.text=@"";
            pwdTextFieldSix.text=@"";
            return;
        }
        
        NSString *str=[payPwd substringToIndex:payPwd.length-1];
        
        if(str.length==6)
        {
            
        }
        else if (str.length==5)
        {
            pwdTextFieldSix.text=@"";
            
        }
        else if(str.length==4)
        {
            pwdTextFieldFive.text=@"";
            pwdTextFieldSix.text=@"";
            
        }
        else if (str.length==3)
        {
            pwdTextFieldFour.text=@"";
            pwdTextFieldFive.text=@"";
            pwdTextFieldSix.text=@"";
        }
        else if(str.length==2)
        {
            pwdTextFieldThree.text=@"";
            pwdTextFieldFour.text=@"";
            pwdTextFieldFive.text=@"";
            pwdTextFieldSix.text=@"";
            
        }
        else if(str.length==1)
        {
            pwdTextFieldTwo.text=@"";
            pwdTextFieldThree.text=@"";
            pwdTextFieldFour.text=@"";
            pwdTextFieldFive.text=@"";
            pwdTextFieldSix.text=@"";
        }
        else
        {
            pwdTextFieldOne.text=@"";
            pwdTextFieldTwo.text=@"";
            pwdTextFieldThree.text=@"";
            pwdTextFieldFour.text=@"";
            pwdTextFieldFive.text=@"";
            pwdTextFieldSix.text=@"";
            
        }
        payPwd = str;
    }
    //确认按钮
    else if(btn.tag == 90002){
        if(payPwd.length==6){
            //键盘退出
            [keyBoardView hiddenDownPayKeyBoardView];
            //密码回调
            if ([_delegate respondsToSelector:@selector(payToolPwd:paySuccessView:)]) {
                [_delegate payToolPwd:payPwd paySuccessView:successAnimationView];
            }
        }
    }
    else{
        
        if (pwdTextFieldOne.text.length<1) {
            if (pwdTextFieldOne.text.length==0) {
                pwdTextFieldOne.text= btn.currentTitle;
            }
        }
        else if (pwdTextFieldTwo.text.length<1 && pwdTextFieldOne.text.length==1) {
            if (pwdTextFieldTwo.text.length==0) {
                pwdTextFieldTwo.text=btn.currentTitle;
            }
        }
        else if (pwdTextFieldThree.text.length<1 && pwdTextFieldTwo.text.length==1) {
            if (pwdTextFieldThree.text.length==0) {
                pwdTextFieldThree.text=btn.currentTitle;
            }
        }
        else if (pwdTextFieldFour.text.length<1 && pwdTextFieldThree.text.length==1) {
            if (pwdTextFieldFour.text.length==0) {
                pwdTextFieldFour.text=btn.currentTitle;
            }
        }
        else if (pwdTextFieldFive.text.length<1 && pwdTextFieldFour.text.length==1) {
            if (pwdTextFieldFive.text.length==0) {
                pwdTextFieldFive.text=btn.currentTitle;
            }
        }
        else if (pwdTextFieldSix.text.length<1 && pwdTextFieldFive.text.length==1) {
            if (pwdTextFieldSix.text.length==0) {
                pwdTextFieldSix.text=btn.currentTitle;
            }
        }
        //记录支付密码位数
        //密码输入己有6位
        payPwd = [NSString stringWithFormat:@"%@%@%@%@%@%@",pwdTextFieldOne.text,pwdTextFieldTwo.text,pwdTextFieldThree.text,pwdTextFieldFour.text,pwdTextFieldFive.text,pwdTextFieldSix.text];
    }
    
}




@end
