//
//  WeChatBankListViewController.h
//  QuickPos
//
//  Created by 胡丹 on 15/4/8.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderData;

@interface WeChatBankListViewController : UIViewController
@property(nonatomic,strong)OrderData *orderData;

@property (nonatomic,strong)NSString *name;
@property (nonatomic,assign)NSUInteger destinationType;
@property (nonatomic,strong) NSString *state;


@property (retain, nonatomic) NSDictionary *item;

//@property (nonatomic,strong)NSString *newbindid;

@end
