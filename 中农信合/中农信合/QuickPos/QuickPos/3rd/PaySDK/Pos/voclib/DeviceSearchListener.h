//
//  DeviceSearchListener.h
//  StaticLibSDKDemo
//
//  Created by hezewen on 14-5-23.
//
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@protocol DeviceSearchListener <NSObject>

//找到蓝牙设备
- (void)discoverOneDevice:(CBPeripheral *)peripheral;
- (void)discoverComplete;//蓝牙搜索结束
@optional
- (void)discoverBLeDevice:(NSDictionary *)uuidAndName;

@end
