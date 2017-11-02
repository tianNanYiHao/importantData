//
//  SDBottomPop.h
//  SDpopViewDemo
//
//  Created by tianNanYiHao on 2017/11/2.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^SDBottomPopSureBlock)(NSString *cellName);
typedef void(^SDBottomPopCancleBlock)();

@interface SDBottomPop : UIView


/**
 显示底部弹框pop控件

 @param tipStr 提示文字
 @param cellNameArr 功能列表组
 @param sureBlock 点击事件回调
 @param cancleBlock 取消事件回调
 */
+ (void)showBottomPopView:(NSString*)tipStr cellNameList:(NSArray*)cellNameArr suerBlock:(SDBottomPopSureBlock)sureBlock cancleBlock:(SDBottomPopCancleBlock)cancleBlock;



@end
