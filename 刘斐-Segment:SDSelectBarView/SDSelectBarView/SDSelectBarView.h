//
//  SDSelectBarView.h
//  SDSelectBarView
//
//  Created by tianNanYiHao on 2017/12/4.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^SDSelectBarBlock)(NSInteger index);

@interface SDSelectBarView : UIView


/**
 创建选择bar视图

 @param titleArr 选项数组
 @return 返回实例
 局限:数组文字长度不能过长/整个选择bar视图不能超过屏幕宽度
 (由于UI设计上为考虑超过屏幕后的设计,故暂不考虑标题过多超过屏幕的滚动情况)
 */
+ (instancetype)showSelectBarView:(NSArray*)titleArr selectBarBlock:(SDSelectBarBlock)block;

@end
