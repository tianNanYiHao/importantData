//
//  MQTTStatus.h
//  MQTTSDKLearn
//
//  Created by Vie on 2017/3/3.
//  Copyright © 2017年 Vie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MQTTClient.h"
@interface MQTTStatus : NSObject
//状态
@property(nonatomic,assign) MQTTSessionEvent statusCode;
//状态信息
@property(nonatomic,copy)  NSString *statusInfo;
@end
