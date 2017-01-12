//
//  NLYLAudioHelper.h
//  ipos
//
//  Created by ZhangSx on 14-11-18.
//
//

#import <Foundation/Foundation.h>
#import <MESDK/NLAudioPortHelper.h>
/*!
 *  @brief  音频口设备拔插检测回调
 */
@protocol NLYLAudioListener<NSObject>
@optional
/*!
 @method
 @abstract 当设备插入音频口时回调
 */
- (void)onNLDevicePlugged;
/*!
 @method
 @abstract 当设备从音频口拔出时回调
 */
- (void)onNLDeviceUnplugged;
@end
/*!
 *  @brief  音频口设备拔插辅助类
 */
@interface NLYLAudioHelper : NSObject
/*!
 @method
 @abstract 是否有音频设备插上
 @return 是否有设备插在音频口
 */
+ (BOOL)isNLDevicePresent;
/*!
 @method
 @abstract 注册音频口设备拔插监听器
 @param listener 音频口监听器
 */
+ (void)registerNLAudioPortListener:(id<NLYLAudioListener>)listener;
/*!
 @method
 @abstract 注销音频口设备拔插监听器
 */
+ (void)unregisterNLAudioPortListener;
@end
