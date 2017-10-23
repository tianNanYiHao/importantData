//
//  NNTextfiled.m
//  NNValidationCodeView
//
//  Created by tianNanYiHao on 2017/10/18.
//  Copyright © 2017年 刘朋坤. All rights reserved.
//

#import "NNTextfiled.h"

@implementation NNTextfiled

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}
@end
