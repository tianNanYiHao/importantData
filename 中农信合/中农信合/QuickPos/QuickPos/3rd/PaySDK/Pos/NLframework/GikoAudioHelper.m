//
//  GikoAudioHelper.m
//  ipos
//
//  Created by ZhangSx on 14-11-18.
//
//

#import "GikoAudioHelper.h"
@interface GikoAudioHelper()<NLYLAudioListener>//CSwiperStateChangedListener,
@end
static GikoAudioHelper * sharedInstance = nil;
@implementation GikoAudioHelper
@synthesize delegate;
+ (BOOL)isGikoDevicePresent
{
   return [NLYLAudioHelper isNLDevicePresent];
}
+(void)unregisterGikoAudioPortListener
{
    [NLYLAudioHelper unregisterNLAudioPortListener];
}
+(GikoAudioHelper *)registerGikoAudioPortListener:(id<GikoAudioPortListener>)listener
{
    @synchronized(self)
    {
        if (sharedInstance == nil) {
            sharedInstance = [[self alloc]initWithListener:listener];
        }
    }
    return sharedInstance;
}
-(id)initWithListener:(id<GikoAudioPortListener>)listener
{
    self = [super init];
    if (self) {
        delegate = listener;
        [NLYLAudioHelper registerNLAudioPortListener:self];
    }
    return self;
}

//收到数据
//-(void) dataArrive:(vcom_Result*) vs  Status:(int)_status{
//    [delegate dataArrive:vs Status:_status];
//}
//
//-(void)registerVcom:(vcom *)n_vcom
//{
//    n_vcom.eventListener=self;
//    
//    //设置数据发送模式和接收模式
//    [n_vcom open];
//}
#pragma mark -NLAudioPortListener
-(void)onNLDevicePlugged
{
    [delegate onAudioDevicePlugged];
}
-(void)onNLDeviceUnplugged
{
    [delegate onAudioDeviceUnPlugged];
}
#pragma mark -CSwiperStateChangedListener
-(void)onDevicePlugged
{
    [delegate onAudioDevicePlugged];
}
-(void)onDeviceUnPlugged
{
    [delegate onAudioDeviceUnPlugged];
}
-(void)onWaitingForDevice
{
    [delegate onGikoWaitingForDevice];
}
-(void)onNoDeviceDetected
{
    [delegate onGikoNoDeviceDetected];
}
-(void)onWaitingForCardSwipe
{
    [delegate onGikoWaitingForCardSwipe];
}
-(void)onCardSwipeDetected
{
    [delegate onGikoCardSwipeDetected];
}
-(void)onDecodingStart
{
    [delegate onGikoDecodingStart];
}
-(void)onError:(int)errorCode andMsg:(NSString *)errorMsg
{
    [delegate onGikoError:errorCode andMsg:errorMsg];
}
-(void)onInterrupted
{
    [delegate onGikoInterrupted];
}
-(void)onTimeout
{
    [delegate onGikoTimeout];
}
-(void)onDecodeCompleted:(NSString*) formatID
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
                    andIsIcc:(BOOL) isIcc;
{
    [delegate onGikoDecodeCompleted:formatID
                                    andKsn:ksn
                              andencTracks:encTracks
                           andTrack1Length:track1Length
                           andTrack2Length:track2Length
                           andTrack3Length:track3Length
                           andRandomNumber:randomNumber
                              andMaskedPAN:maskedPAN
                             andExpiryDate:expiryDate
                         andCardHolderName:cardHolderName
                                andCardMAC:cardMAC
                          andCardSequensNo:cardSequensNo
                                andIccData:iccData
                                  andIsIcc:isIcc
                        cardNOEncode:nil];
}
-(void)onDecodeDrror:(int)decodeResult
{
    [delegate onGikoDecodeDrror:decodeResult];
}
-(void)onMicInOut:(int)inout
{
    [delegate onGikoMicInOut:inout];
}


@end
