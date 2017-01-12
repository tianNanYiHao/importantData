//
//  Manager.h
//  PosDemo
//
//  Created by 张倡榕 on 15/1/19.
//  Copyright (c) 2015年 yoolink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pos.h"

@interface PosManager : NSObject

@property (nonatomic, strong)Pos *pos;

+ (PosManager*)getInstance;

- (void)switchDevice:(NSInteger) deviceType;

- (void)getDevice:(NSString*)device;

- (void)posNotification;

- (void)initDeviceWithType:(int) deviceType;

- (void)cswipecardTransLogNo:(NSString *)transLogNo orderId:(NSString *)orderId delegate:(id<PosResponse>)de;

- (BOOL)getPluggedType;

-(BOOL)getBigType;

- (void)ResetBlue;
@end
