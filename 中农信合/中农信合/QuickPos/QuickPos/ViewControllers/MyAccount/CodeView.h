//
//  CodeView.h
//  QuickPos
//
//  Created by 张倡榕 on 15/6/10.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "SetupBaseView.h"

@protocol getRespDesc <NSObject>

- (void)getRespDesc:(NSString *)desc;

@end


@interface CodeView : SetupBaseView

@property (nonatomic ,strong)NSObject<getRespDesc>*delegate;

+ (void)showVersionView:(UIViewController *)ctrl lab:(NSString *)lab;
@end
