//
//  ChooseView.m
//  QuickPos
//
//  Created by 胡丹 on 15/4/11.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "ChooseView.h"
#import "PayType.h"


@interface ChooseView (){
    UIView *view;
}



@end

@implementation ChooseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (float)chooseWidth{
    return 95.0f;
}
+ (float)chooseHeight{
    return 30.0f;
}
+ (UIView*)secondCreatChooseViewWithOriginX:(float)x Y:(float)y delegate:(NSObject<ChooseViewDelegate> *)chooseDelegate count:(int)count{
    UIView *backView = [[UIView alloc]init];
    
    for (UIView *v in backView.subviews) {
        [v removeFromSuperview];
    }
    //    int count = ISQUICKPAY?3:2;
    NSMutableDictionary *chooseArr;
    if (count == 2) {
          chooseArr = [NSMutableDictionary dictionaryWithObjectsAndKeys:L(@"CreditCardPayment"),[NSString stringWithFormat:@"%d",CardPayType],L(@"QuickPayment"),[NSString stringWithFormat:@"%d",QuickPayType],nil];
    }else{
        chooseArr = [NSMutableDictionary dictionaryWithObjectsAndKeys:L(@"CreditCardPayment"),[NSString stringWithFormat:@"%d",CardPayType],L(@"AccountToPay"),[NSString stringWithFormat:@"%d",AccountPayType],L(@"QuickPayment"),[NSString stringWithFormat:@"%d",QuickPayType],nil];
    }
    for (int i = 0; i < count ; i ++) {
        ChooseView *c = [[ChooseView alloc]init];
        c.delegate = chooseDelegate;
        
        if (i == 1) {
        c.chooseLabel.text = [chooseArr objectForKey:[NSString stringWithFormat:@"%d",i+2]];
        }else{
        c.chooseLabel.text = [chooseArr objectForKey:[NSString stringWithFormat:@"%d",i+1]];
        }
        
        c.tag = i+1;
        if (i == 0) {
            [c.chooseBtn setSelected:YES];
        }
        c.frame = CGRectMake(c.frame.size.width * i, 0, c.frame.size.width, c.frame.size.height);
        [backView addSubview:c];
    }
    backView.frame = CGRectMake(x, y,[ChooseView chooseWidth]*count , [ChooseView chooseHeight]);
    return backView;
}

+ (UIView*)creatChooseViewWithOriginX:(float)x Y:(float)y delegate:(NSObject<ChooseViewDelegate>*)chooseDelegate count:(int)count{
    
    UIView *backView = [[UIView alloc]init];
  
    for (UIView *v in backView.subviews) {
        [v removeFromSuperview];
    }
//    int count = ISQUICKPAY?3:2;
    NSMutableDictionary *chooseArr;
    if (count == 2) {
        chooseArr = [NSMutableDictionary dictionaryWithObjectsAndKeys:L(@"CreditCardPayment"),[NSString stringWithFormat:@"%d",CardPayType],L(@"AccountToPay"),[NSString stringWithFormat:@"%d",AccountPayType],nil];
    }else{
        chooseArr = [NSMutableDictionary dictionaryWithObjectsAndKeys:L(@"CreditCardPayment"),[NSString stringWithFormat:@"%d",CardPayType],L(@"AccountToPay"),[NSString stringWithFormat:@"%d",AccountPayType],L(@"QuickPayment"),[NSString stringWithFormat:@"%d",QuickPayType],nil];
    }
    for (int i = 0; i < count ; i ++) {
        ChooseView *c = [[ChooseView alloc]init];
        c.delegate = chooseDelegate;
        c.chooseLabel.text = [chooseArr objectForKey:[NSString stringWithFormat:@"%d",i+1]];
        c.chooseLabel.font = [UIFont systemFontOfSize:12];
        c.tag = i+1;
        if (i == 0) {
            [c.chooseBtn setSelected:YES];
        }
        c.frame = CGRectMake(c.frame.size.width * i, 0, c.frame.size.width, c.frame.size.height);
        [backView addSubview:c];
    }
    backView.frame = CGRectMake(x, y,[ChooseView chooseWidth]*count , [ChooseView chooseHeight]);
    return backView;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"ChooseView" owner:self options:nil] objectAtIndex:0];
    }

    return self;
}



- (IBAction)tapChooseBtn:(UIButton *)sender {
    [sender setSelected:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(chooseView:chooseAtIndex:)]) {
        [self.delegate chooseView:(ChooseView*)sender.superview chooseAtIndex:sender.superview.tag];
    }
}

- (IBAction)tapChooseLabel:(UITapGestureRecognizer *)sender {
//    if (self.delegate && [self.delegate respondsToSelector:@selector(chooseView:chooseAtIndex:)]) {
//        [self.delegate chooseView:(ChooseView*)sender.view chooseAtIndex:sender.view.superview.tag];
//    }

}



@end
