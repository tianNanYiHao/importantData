//
//  SDSearchPop.m
//  sandbao
//
//  Created by tianNanYiHao on 2017/10/30.
//  Copyright © 2017年 sand. All rights reserved.
//

#import "SDSearchPop.h"


#define AllHeight 88

@interface SDSearchPop ()<UISearchBarDelegate>
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
 搜索框
 */
@property (nonatomic, strong) UISearchBar *searchBar;

/**
 回调
 */
@property (nonatomic, copy) SDSearchPopTextBlock block;

@end


@implementation SDSearchPop



+ (void)showSearchPopViewPlaceholder:(NSString*)placeholder textBlock:(SDSearchPopTextBlock)textBlock{
    
    SDSearchPop *pop = [[SDSearchPop alloc] initWithFrame:CGRectMake(0, -AllHeight, [UIScreen mainScreen].bounds.size.width, AllHeight)];
    
    pop.block = textBlock;
    
    pop.searchBar.placeholder = placeholder;
    
    [pop addSubview:pop.searchBar];
    
    pop.backgroundColor = [UIColor whiteColor];
    
    [pop show];
    
}


- (void)show{
    
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    [window addSubview:self.backGroundView];
    [self showAnimation:YES];
    
}



- (void)showAnimation:(BOOL)isShow{
    
    if (isShow) {
        [UIView animateWithDuration:0.35 animations:^{
            self.maskBlackView.alpha = 0.4f;
            self.frame =CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, AllHeight);
        } completion:^(BOOL finished) {
            
        }];
    }
    if (!isShow) {
        [UIView animateWithDuration:0.35f animations:^{
            self.maskBlackView.alpha = 0.f;
            self.frame =CGRectMake(0, -AllHeight, [UIScreen mainScreen].bounds.size.width, AllHeight);
        } completion:^(BOOL finished) {
            [self.backGroundView removeFromSuperview];
            [self.maskBlackView removeFromSuperview];
            [self removeFromSuperview];
            
        }];
    }
    
    
}


- (void)hidden{
    
    [self showAnimation:NO];
    
}


#pragma searchBarDelegate

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    NSString *nowSearchText = [searchBar.text stringByReplacingCharactersInRange:range withString:text];
    
    if (nowSearchText.length == 11) {
        
        self.block(searchBar.text);
        [searchBar resignFirstResponder];
        [self hidden];
        
        return YES;
    }
    
    return YES;
    
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


- (UISearchBar*)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, AllHeight-20)];
        _searchBar.delegate = self;
        _searchBar.keyboardType = UIKeyboardTypeNumberPad;
        _searchBar.clearsContextBeforeDrawing = YES;
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
        [_searchBar becomeFirstResponder];
    }
    return _searchBar;
}

@end
