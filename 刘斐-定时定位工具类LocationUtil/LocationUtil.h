//
//  LocationUtil.h
//  sandbao
//
//  Created by tianNanYiHao on 2017/11/28.
//  Copyright © 2017年 sand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationUtil : NSObject

/**
 单例

 @return 定位管理类实例
 */
+ (LocationUtil*)shareLocationManager;


/**
 开启定位更新
 */
- (NSArray*)startUpdatingLocation;
 
 

@end
