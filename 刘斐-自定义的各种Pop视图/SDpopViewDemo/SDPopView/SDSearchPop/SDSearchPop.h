//
//  SDSearchPop.h
//  sandbao
//
//  Created by tianNanYiHao on 2017/10/30.
//  Copyright © 2017年 sand. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^SDSearchPopTextBlock)(NSString *text);

@interface SDSearchPop : UIView



/**
 显示搜索框pop控件

 @param placeholder 占位文字
 @param textBlock 搜索结果回调
 */
+ (void)showSearchPopViewPlaceholder:(NSString*)placeholder textBlock:(SDSearchPopTextBlock)textBlock;


@end
