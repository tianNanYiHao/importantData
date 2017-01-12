//
//  LocationManager.h
//  QuickPos
//
//  Created by 胡丹 on 15/4/8.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^LocationCallback) (float lon,float lat);
@interface LocationManager : NSObject

+ (LocationManager*)instance;
- (void)startLocationManager:(LocationCallback)callback;
+ (void)stopLocationManager;

@end
