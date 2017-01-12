//
//  ChooseView.h
//  QuickPos
//
//  Created by 胡丹 on 15/4/11.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChooseView;


@protocol ChooseViewDelegate <NSObject>

- (void)chooseView:(ChooseView *)chooseView chooseAtIndex:(NSUInteger)chooseIndex;

@end

@interface ChooseView : UIView

@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;
@property (weak, nonatomic) IBOutlet UILabel *chooseLabel;
@property (nonatomic,retain)NSObject<ChooseViewDelegate> *delegate;

+ (float)chooseWidth;
+ (float)chooseHeight;
+ (UIView*)creatChooseViewWithOriginX:(float)x Y:(float)y delegate:(NSObject<ChooseViewDelegate>*)chooseDelegate count:(int)count;
+ (UIView*)secondCreatChooseViewWithOriginX:(float)x Y:(float)y delegate:(NSObject<ChooseViewDelegate>*)chooseDelegate count:(int)count;


@end
