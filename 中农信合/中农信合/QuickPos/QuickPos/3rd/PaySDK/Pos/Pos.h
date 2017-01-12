//
//  Pos.h
//  PosDemo
//
//  Created by 糊涂 on 14/12/19.
//  Copyright (c) 2014年 yoolink. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Log.h"
#import "CardInfoModel.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#include "vcom.h"

@class CardInfoModel;

@protocol PosResponse <NSObject>

@required
- (void)posResponseDataWithCardInfoModel:(CardInfoModel*)cardInfo;

- (void)onDeviceKind:(int)type;

- (void)onDevicePlugged;

- (void)onDeviceUnPlugged;

@end

@interface Pos : NSObject


enum deviceType {
    DEVICE_TYPE_MINI_IC = 1 << 0,
    DEVICE_TYPE_BOARD_BLUETOOTH = 1 << 1,
    DEVICE_TYPE_BOARD = 1 << 2,
    DEVICE_TYPE_MINI = 1 << 3,
    DEVICE_TYPE_NLIC = 1 << 4,
    DEVICE_TYPE_PRINTER = 1 << 5,
};

@property (nonatomic, strong)NSObject<PosResponse>*delegate;
@property (nonatomic ,strong)vcom *mVcom;
//@property (nonatomic ,strong)

- (id)initWithDelegate:(NSObject<PosResponse>*)delegate;

// 开始刷卡
- (void)startWithData:(NSDictionary*)data;
// 建立连接
- (void)connect;
// 中断刷卡
- (void)stop;
// 关闭连接
- (void)close;
// 检查是否插入耳机
- (BOOL)hasHeadset;

// int数值转16进制数值 返回16进制表示的字符串,可定义长度,不足补0
- (NSString*) intToHexString:(int)num lenght:(int)lenght;

- (void)posResponseDataWithCardInfoModel:(CardInfoModel*)cardInfo;
- (void)onDeviceKind:(int)type;
@end
