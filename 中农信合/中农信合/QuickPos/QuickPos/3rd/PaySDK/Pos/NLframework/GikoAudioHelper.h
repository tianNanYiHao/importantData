//
//  GikoAudioHelper.h
//  ipos
//
//  Created by ZhangSx on 14-11-18.
//
//
#import <Foundation/Foundation.h>
#import "NLYLAudioHelper.h"
//#import "CSwiperStateChangedListener.h"
//#import "vcom.h"
typedef enum {
    AudioDeviceTypeUnKnown,
    AudioDeviceTypeME11,
    AudioDeviceTypeVoc
} GikoAudioDevice;
@protocol GikoAudioPortListener<NSObject>
-(void)onAudioDevicePlugged;
-(void)onAudioDeviceUnPlugged;
/****************************************
 事件定义
 ****************************************/

//通知监听器控制器CSwiperController正在搜索刷卡器
-(void) onGikoWaitingForDevice;

//通知监听器没有刷卡器硬件设备
-(void)onGikoNoDeviceDetected;

//通知监听器可以进行刷卡动作
-(void)onGikoWaitingForCardSwipe;

// 通知监听器检测到刷卡动作
-(void)onGikoCardSwipeDetected;

//通知监听器开始解析或读取卡号、磁道等相关信息
-(void)onGikoDecodingStart;
-(void)onGikoError:(int)errorCode andMsg:(NSString*)errorMsg;

//通知监听器控制器CSwiperController的操作被中断
-(void)onGikoInterrupted;

//通知监听器控制器CSwiperController的操作超时
//(超出预定的操作时间，30秒)
-(void)onGikoTimeout;

//通知监听器解码刷卡器输出数据完毕。
/*
 formatID　　　　　此参数保留
 ksn               刷卡器设备编码
 encTracks         加密的磁道资料。1，2，3的十六进制字符
 track1Length       磁道1的长度（没有加密数据为0）
 track2Length       磁道2的长度（没有加密数据为0）
 track3Length       磁道3的长度（没有加密数据为0）
 randomNumber     加密时产生的随机数
 maskedPAN        基本账号号码。卡号的一种格式“ddddddddXXXXXXXXdddd”(隐藏卡号
 的中间的几位数字)d 数字   X 隐藏字符
 expiryDate         到期日，格式ＹＹＭＭ
 cardHolderName　　持卡人姓名
 cardMAC 卡mac
 cardSequensNo 卡序列号
 IccData IC卡55域数据
 isIcc	是否是IC卡交易
 */
-(void)onGikoDecodeCompleted:(NSString*) formatID
                  andKsn:(NSString*) ksn
            andencTracks:(NSString*) encTracks
         andTrack1Length:(int) track1Length
         andTrack2Length:(int) track2Length
         andTrack3Length:(int) track3Length
         andRandomNumber:(NSString*) randomNumber
            andMaskedPAN:(NSString*) maskedPAN
           andExpiryDate:(NSString*) expiryDate
       andCardHolderName:(NSString*) cardHolderName
              andCardMAC:(NSString *) cardMAC
        andCardSequensNo:(NSString *) cardSequensNo
              andIccData:(NSString *) iccData
                andIsIcc:(BOOL) isIcc
            cardNOEncode:(NSString *)cardNOEncode;
//解析卡号、磁道信息等数据出错时，回调此接口
-(void)onGikoDecodeDrror:(int)decodeResult;

//收到数据
//-(void) dataArrive:(vcom_Result*) vs  Status:(int)_status;
//mic插入
-(void) onGikoMicInOut:(int) inout;
@end
@interface GikoAudioHelper : NSObject
@property (nonatomic,strong) id<GikoAudioPortListener> delegate;
@property (nonatomic) GikoAudioDevice deviceType;
/*!
 @method
 @abstract 是否有音频设备插上（NL）
 @return 是否有设备插在音频口
 */
+ (BOOL)isGikoDevicePresent;
/*!
 @method
 @abstract 注册音频口设备拔插监听器
 @param listener 音频口监听器
 */
+ (GikoAudioHelper *)registerGikoAudioPortListener:(id<GikoAudioPortListener>)listener;
/*!
 @method
 @abstract 注销音频口设备拔插监听器（NL）
 */
+ (void)unregisterGikoAudioPortListener;
/*!
 *  @brief  初始化vcom
 */
//-(void)registerVcom:(vcom *)vcom;
@end
