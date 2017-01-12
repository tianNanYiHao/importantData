//
//  BaseData.h
//  QuickPos
//
//  Created by 胡丹 on 15/3/20.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseData : NSObject
@property (nonatomic,strong)NSString *respCode;
@property (nonatomic,strong)NSString *respDesc;

- (instancetype)initWithData:(NSDictionary*)dict;

@end
