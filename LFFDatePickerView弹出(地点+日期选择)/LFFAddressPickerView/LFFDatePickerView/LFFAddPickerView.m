//
//  LFFAddPickerView.m
//  QuickPos
//
//  Created by Lff on 16/10/19.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "LFFAddPickerView.h"
#import "TrickAddressModel.h"
#define customBlue [UIColor colorWithRed:69/255.0 green:120/255.0 blue:245/255.0 alpha:1]
#define customGray [UIColor colorWithRed:238/255.0 green:238/255.0 blue:245/255.0 alpha:1]
#define customLineBlue [UIColor colorWithRed:151/255.0 green:170/255.0 blue:245/255.0 alpha:1]

@interface LFFAddPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSString *name1;
    NSString *name2;
    NSString *name;
    NSString *nameCode1;
    NSString *nameCode2;
    
    
    
    
}
@property (weak, nonatomic) IBOutlet UIView *maskView; //
@property (weak, nonatomic) IBOutlet UIView *showView;
@property (weak, nonatomic) IBOutlet UILabel *chooseLab;//标题
@property (weak, nonatomic) IBOutlet UIPickerView *addPickerView; //pickerVIew
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@end


@implementation LFFAddPickerView

+(LFFAddPickerView*)awakeFromXib{
    NSArray *arrNib = [[NSBundle mainBundle] loadNibNamed:@"LFFAddPickerView" owner:nil options:nil];
    return arrNib[0];
    
}

-(void)setInfoArray:(NSArray *)infoArray{
    
    _infoArray = infoArray;
    _addPickerView.delegate = self;
    _addPickerView.dataSource = self;
}
-(void)setFromeAddress:(NSString *)fromeAddress{
    _fromeAddress = fromeAddress;
}

-(void)setToAddress:(NSString *)toAddress{
    _toAddress = toAddress;
    
}

-(void)awakeFromNib{
    
    _showView.layer.masksToBounds = YES;
    _showView.layer.borderWidth = 1;
    _showView.layer.borderColor = customBlue.CGColor;
    _showView.layer.cornerRadius = 5;
    
    _commitBtn.layer.masksToBounds = YES;
    _commitBtn.layer.borderWidth = 1;
    _commitBtn.layer.borderColor =customGray.CGColor;
    _commitBtn.layer.cornerRadius = 5;
    _commitBtn.titleLabel.textColor = customGray;
    _commitBtn.userInteractionEnabled = NO;
    
    _addPickerView.contentMode = UIViewContentModeCenter;
    _addPickerView.showsSelectionIndicator = YES;


}

- (void)changeValue:(UIPickerView*)sender{
    
}



//点击maskVIew
- (IBAction)maskViewHiddenSelf:(id)sender {
    if ([_delegate respondsToSelector:@selector(hiddenLFFAddPickerView)]) {
        [_delegate hiddenLFFAddPickerView];
    }
    
}



//确认提交
- (IBAction)commitBtnClick:(id)sender {
    if ([_delegate respondsToSelector:@selector(hiddenLFFAddPickerView)] && [_delegate respondsToSelector:@selector(returnFromeLFFAddPickerInfo:)] && [_delegate respondsToSelector:@selector(returnToLFFAddPickerInfo:)]) {
        [_delegate hiddenLFFAddPickerView];
        if ([_fromeAddress isEqualToString:@"1"]) {
            [_delegate returnFromeLFFAddPickerInfo:@[name1,nameCode1]];
        }else if ([_toAddress isEqualToString:@"2"]){
            [_delegate returnToLFFAddPickerInfo:@[name2,nameCode2]];
        }
        [self addAnimationToCustomView:sender];  
    }
    _fromeAddress = @"";
    _toAddress = @"";
  
}



#pragma mark - pickviewDelegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _infoArray.count;
}
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    name = [_infoArray[row] addName];
    _commitBtn.layer.borderColor =customGray.CGColor;
    _commitBtn.titleLabel.textColor = customGray;
    _commitBtn.userInteractionEnabled = NO;
    return name;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if ([_fromeAddress isEqualToString:@"1"]) {
        name1 = [_infoArray[row] addName];
        nameCode1 = [_infoArray[row] addCode];
    }else if ([_toAddress isEqualToString:@"2"]){
        name2 = [_infoArray[row] addName];
        nameCode2 = [_infoArray[row] addCode];
    }

    
  
    _commitBtn.layer.borderColor = customBlue.CGColor;
    _commitBtn.titleLabel.textColor = customBlue;
    _commitBtn.userInteractionEnabled = YES;
    [self addAnimationToCustomView:_commitBtn];
    
}





-(void)addAnimationToCustomView:(UIView*)view{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 0.1;
    animation.repeatCount = 1;
    animation.autoreverses = YES;
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:0.9];
    [view.layer addAnimation:animation forKey:@"scale-layer"];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
