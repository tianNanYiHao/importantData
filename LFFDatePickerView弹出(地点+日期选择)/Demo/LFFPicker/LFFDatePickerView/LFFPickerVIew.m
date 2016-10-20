//
//  LFFPickerVIew.m
//  SFoofSave
//
//  Created by Lff on 16/8/22.
//  Copyright © 2016年 Lff. All rights reserved.
//

#import "LFFPickerVIew.h"
#define customBlue [UIColor colorWithRed:69/255.0 green:120/255.0 blue:245/255.0 alpha:1]
#define customGray [UIColor colorWithRed:238/255.0 green:238/255.0 blue:245/255.0 alpha:1]
#define customLineBlue [UIColor colorWithRed:151/255.0 green:170/255.0 blue:245/255.0 alpha:1]
@interface LFFPickerVIew()
{

}
@property (weak, nonatomic) IBOutlet UIButton *maskBtn; //遮罩按钮
@property (weak, nonatomic) IBOutlet UIView *showView; //展示View


@property (weak, nonatomic) IBOutlet UILabel *timeTitleLab; //显示时间的lab
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerView; //pickview
@property (weak, nonatomic) IBOutlet UIButton *goBackBtn;  //回到今天按钮
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;      //确定按钮


@end

@implementation LFFPickerVIew
+ (LFFPickerVIew*)awakeFromXib{
    NSArray *xibArr = [[NSBundle mainBundle] loadNibNamed:@"LFFPickerVIew" owner:nil options:nil];
    return xibArr[0];
}

- (void)awakeFromNib{
    _showView.layer.masksToBounds = YES;
    _showView.layer.borderWidth = 1;
    _showView.layer.borderColor = customBlue.CGColor;
    _showView.layer.cornerRadius = 5;
    
    _goBackBtn.layer.masksToBounds = YES;
    _goBackBtn.layer.borderWidth = 1;
    _goBackBtn.layer.borderColor = customGray.CGColor;
    _goBackBtn.layer.cornerRadius = 5;
    
    
    _sureBtn.layer.masksToBounds = YES;
    _sureBtn.layer.borderColor = customBlue.CGColor;
    _sureBtn.layer.borderWidth = 1.0;
    _sureBtn.layer.cornerRadius = 5;
    
    //设置datePickerView模式
    _datePickerView.contentMode = UIDatePickerModeDate;
    //设置显示默认当天
    _datePickerView.calendar = [NSCalendar currentCalendar];
    
    //设置监听事件
    [_datePickerView addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
    
    //设置 显示当前的时间
    _timeTitleLab.text = [self formatterDate:[NSDate date]];
    
    
}

//NSDate 转换 为 时间字符串
-(NSString*)formatterDate:(NSDate*)date{
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    [dataFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [dataFormatter stringFromDate:date];
    return dateTime;
}

//动画处理方法
-(void)animationByCustom:(UIView*)view{

    //设置为 缩放动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //动画持续时间
    animation.duration = 0.1;
    //动画重复次数
    animation.repeatCount = 1;
    //动画结束以后执行逆动画
    animation.autoreverses = YES;
    
    //缩放倍数
    animation.fromValue = [NSNumber numberWithFloat:1];
    animation.toValue = [NSNumber numberWithFloat:0.9];
    
    //添加动画
    [view.layer addAnimation:animation forKey:@"scale-layer"];
}


//触及页面灰色部分,页面消失
- (IBAction)hiddenBtn:(id)sender {
    if ([_delegate respondsToSelector:@selector(changeAlphaHiden)]) {
        [_delegate changeAlphaHiden];
        
    }
    
}


//回到今天 按钮
- (IBAction)goBackToday:(id)sender {
    //执行按钮动画
    [self animationByCustom:sender];
    //执行滚轮动画
   [ _datePickerView setDate:[NSDate date] animated:YES];
    _timeTitleLab.text = [self formatterDate:[NSDate date]];
    [self animationByCustom:_timeTitleLab];
}
//确认按钮
- (IBAction)sureBtn:(id)sender {
    [self animationByCustom:sender];
    if (_Timetype == 1) {
        if ([_delegate respondsToSelector:@selector(changeAlphaHiden:)]) {
            [_delegate changeAlphaHiden:_timeTitleLab.text];
        }
    }else if (_Timetype == 2){
        if ([_delegate respondsToSelector:@selector(changeAlphaHiden:)]) {
            [_delegate changeAlphaHiden:_timeTitleLab.text];
        }
    }
    
  
}

- (void)changeValue:(UIDatePicker*)sender{
    _timeTitleLab.text = [self formatterDate:[sender date]];
    [self animationByCustom:_timeTitleLab];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
