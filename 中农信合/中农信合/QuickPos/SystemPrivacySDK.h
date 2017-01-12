//
//  SystemPrivacySDK.h
//  SystemPrivacySDK
//
//  Created by zhuxiaomeng on 14-12-28.
//  Copyright (c) 2014年 zhuxiaomeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemPrivacySDK : NSObject

/**
*  获得定位权限
*  @param appName 应用程序名称
*  @date 2014-12-29
*  @author zhu xiaomeng
*/
- (void)getLocationAuthorityWithAppName:(NSString *)appName;

/**
 *  获得设备信息
 *  @return 设备相关信息
 *  @date 2014-12-29
 *  @author zhu xiaomeng
 */
- (NSString *)getSystemPrivacy;

@end
