//
//  NLICCard.m
//  PosDemo
//
//  Created by 糊涂 on 14/12/19.
//  Copyright (c) 2014年 yoolink. All rights reserved.
//

#import "NLICCard.h"
#import "GikoAudioHelper.h"
#import "ME11Controller.h"

#import <MESDK/MESDK.h>

@interface NLICCard()<NLDeviceEventListener, GikoAudioPortListener, NLEmvControllerListener>
@property (nonatomic, strong)id<NLDeviceDriver> driver;
@property (nonatomic, strong)id<NLDevice> device;

@property (nonatomic, strong)GikoAudioHelper *gikoAudioHelper ;
@property (nonatomic, strong)ME11Controller *me11Controller;
@end

@implementation NLICCard

//@synthesize mVcom;
@synthesize gikoAudioHelper;
@synthesize me11Controller;

- (id)initWithDelegate:(NSObject<PosResponse> *)delegate {
    self = [super initWithDelegate:delegate];
    if (self) {
        [self initNewLandSDK];
    }
    return self;
}

-(void)initNewLandSDK {
    self.driver = [[NLMESeriesDriver alloc] init];//add by zsx
    gikoAudioHelper = [GikoAudioHelper registerGikoAudioPortListener:self];
    me11Controller = [ME11Controller getInstance];
    
    gikoAudioHelper.deviceType = AudioDeviceTypeME11;
}

- (BOOL)hasHeadset{
    return [NLAudioPortHelper isDevicePresent];
}

/*!
 *  @brief  NL音频口连接
 */
- (BOOL)initializeAudioDriver {
    // 音频连接参数
    id<NLDeviceConnParams> params = [[NLAudioPortV100ConnParams alloc] init];
    // 请求连接并获取ME11终端设备
    NSError *err = nil; // 驱动连接设备错误指针
    // 驱动连接ME11获取设备对象信息
    
    BOOL flag = NO;
    
    self.device = [self.driver connectWithConnParams:params closedListener:self launchListener:self error:&err];
    if (err || !self.device) { // 获取失败
        [Log show:[NSString stringWithFormat:@"device error %@", err]];
        self.device = nil;
    }else{
        flag = YES;
    }
    //FIXME: 设备连接成功
    if ([super.delegate respondsToSelector:@selector(onDeviceKind:)]) {
        [super.delegate onDeviceKind:flag?DEVICE_TYPE_NLIC:-1];
    }
    NSLog(@"Audio device instance %@", self.device);
    return flag;
}

- (void)onEvent:(id<NLDeviceEvent>)event {
    
}

- (void)startWithData:(NSDictionary*)data {
    
//    if (!self.device) {
//        self.device = [NLMESeriesDevice alloc];
//    }
    
    //    [self showMsgOnMainThread:@"正在等待刷卡/插卡......"];
    
    NSLog(@"---------请刷卡---------");
    id<NLCardReader> cardReader = (id<NLCardReader>)[self.device standardModuleWithModuleType:NLModuleTypeCommonCardReader];
    // TODO
    int timeout = 60;
    
    NSDateFormatter *ft = [[NSDateFormatter alloc] init];
    [ft setDateFormat:@"yyMMddHHmmss"];
    
    NSData* time = [NLISOUtils hexStr2Data:[ft stringFromDate:[NSDate date]]]; //
    NSData* random = [NLISOUtils hexStr2Data:[data objectForKey:@"transLogNo"]]; // 流水号
    NSData* appendData = [NLISOUtils hexStr2Data:[data objectForKey:@"orderId"]]; // 订单号
    NSLog(@"流水号:%@,订单号:%@", random, appendData);
    
    NLME11SwipeResult *rslt = [cardReader openCardReader:@[@(NLModuleTypeCommonSwiper), @(NLModuleTypeCommonICCard)] readModel:@[@(NLSwiperReadModelReadSecondTrack), @(NLSwiperReadModelReadThirdTrack)] panType:0xFF encryptAlgorithm:[NLTrackEncryptAlgorithm BY_JIFUBAO_MODEL] wk:[[NLWorkingKey alloc] initWithIndex:0x01] time:time random:random appendData:appendData timeout:timeout];
    if (!rslt) {
        //        [self showMsgOnMainThread:CString(@"读卡POS响应失败")];
        return ;
    }
    if (rslt.rsltType != NLSwipeResultTypeSuccess || rslt.moduleTypes <= 0) {
        //        [self showMsgOnMainThread:CString(@"刷卡或插卡超时")];
        if (rslt.rsltType == NLSwipeResultTypeReadTrackTimeout) {
            return ;
        }
        //        [self showMsgOnMainThread:CString(@"刷卡或插卡失败")];
        return ;
    }
    
    NLModuleType moduleType = [rslt.moduleTypes[0] intValue];
    
    
    if (NLModuleTypeCommonICCard == moduleType)
    {
        //IC卡
        // ME11 pboc
        //        [self showMsgOnMainThread:@"正在读取IC卡......"];
        NSLog(@"---------正在读取IC卡---------");
        id<NLEmvModule> emvModule = (id<NLEmvModule>)[self.device standardModuleWithModuleType:NLModuleTypeCommonEMV];
        id<NLEmvTransController> emvController = [emvModule emvTransControllerWithListener:self];
        [emvController startEmvWithAmount: [NSDecimalNumber decimalNumberWithString:@"10.00"] cashback:[NSDecimalNumber zero] forceOnline:YES];
    }
    else if (NLModuleTypeCommonSwiper == moduleType)
    {
        NSString * strKsn = rslt.ksn == nil?@"":[NLISOUtils hexStringWithData:rslt.ksn];
        //刷卡返回的KSN其实是pos里CSN，pos里的KSN可以从CSN中截取出来，取第5个字符开始的子串就是Pos里的KSN
        NSString * strPsam = strKsn.length < 20?@"":[strKsn substringFromIndex:4];
        NSString * strDeviceNo = strKsn.length < 20 ? @"":[strKsn substringToIndex:20];
        NSString * strTrack2 =rslt.secondTrackData == nil?@"":[NLISOUtils hexStringWithData:rslt.secondTrackData];
        int lenTrack2 = [strTrack2 isEqual:@""]?0:(int)strTrack2.length/2;
        
        NSString * strTrack3 =rslt.thirdTrackData == nil?@"":[NLISOUtils hexStringWithData:rslt.thirdTrackData];
        int lenTrack3 = [strTrack3 isEqual:@""]?0:(int)strTrack3.length/2;
        
        
        //从额外信息中截取随机数和mac值
        NSString * strExtInfo = rslt.extInfo == nil?@"":[NLISOUtils hexStringWithData:rslt.extInfo];
        NSString * strRandom = strExtInfo.length < 12?@"":[strExtInfo substringWithRange:NSMakeRange(0,8)];
        NSLog(@"随机数:%@",strRandom);
        NSString * strMac = strExtInfo.length < 12?@"":[strExtInfo substringFromIndex:8];
        NSLog(@"MAC:%@",strMac);
        
        NSString * strAcctNo = rslt.acctId == nil?@"":rslt.acctId;
        if (([strAcctNo length] | 0b1) == [strAcctNo length]) {
            strAcctNo = [strAcctNo stringByAppendingString:@"f"];
        }
        
        NSLog(@"磁条卡卡号:%@",strAcctNo);
        NSString * strValidDate = rslt.validDate == nil?@"":CString(@"%@",[rslt.validDate dataUsingEncoding:NSASCIIStringEncoding]);
        strValidDate = [strValidDate substringWithRange:NSMakeRange(1, [strValidDate length]-2)];
        strValidDate = [strValidDate stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSLog(@"卡有效期:%@",strValidDate);
        
        NSMutableString *strFinalKsn = [[NSMutableString alloc] initWithString:strKsn];
        [strFinalKsn appendString:strPsam];
        
        NSLog(@"终端号+psam:%@",strFinalKsn);
        NSMutableString * strEncTracks =[[NSMutableString alloc] initWithString:strTrack2];
        [strEncTracks appendString:strTrack3];
        NSLog(@"二三磁道:%@",strEncTracks);
        CardInfoModel *cardInfo = [[CardInfoModel alloc] init];
        [cardInfo setTrack:[strTrack2 stringByAppendingString:strTrack3]];          //23磁
        [cardInfo setTrack2Lenght:[NSString stringWithFormat:@"%d", lenTrack2]];    //2磁长
        [cardInfo setTrack3Lenght:[NSString stringWithFormat:@"%d", lenTrack3]];    //3磁长
        [cardInfo setDeviceNo:[NSString stringWithFormat:@"%@",strDeviceNo]];       //终端号
        [cardInfo setPsamNO:[NSString stringWithFormat:@"%@",strPsam]];             //pasm
        [cardInfo setRandom:[NSString stringWithFormat:@"%@", strRandom]];          //随机数
        [cardInfo setCardNO:[NSString stringWithFormat:@"%@", strAcctNo]];          //卡号
        [cardInfo setExpiryDate:[NSString stringWithFormat:@"%@", strValidDate]];   //有效期
        [cardInfo setMac:[NSString stringWithFormat:@"%@", strMac]];                //MAC
        [cardInfo setSequensNo:@""];//序列号
        [cardInfo setExpiryDate:@""];
        [cardInfo setData55:@""];
        [cardInfo setHasPassword:YES];
        //
        ////        NSString *track1 = @"0";
        NSString *strTrack1len = [self intToHexString:0 lenght:2];
        NSString *strTrack2len = [self intToHexString:lenTrack2 lenght:2];
        NSString *strTrack3len = [self intToHexString:lenTrack3 lenght:2];
        NSString *randomlen = [self intToHexString:(int)[strRandom length]/2 lenght:2];
        NSString *ksnlen = [self intToHexString:(int)([strDeviceNo length] + [strPsam length])/2 lenght:2];
        NSString *maskedPANlen = [self intToHexString:(int)[strAcctNo length]/2 lenght:2];
        NSString *track2 = strTrack2;
        NSString *track3 = strTrack3;
        //
        NSString * info =[NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@",strTrack1len, strTrack2len, strTrack3len, randomlen, ksnlen, maskedPANlen, track2,track3, strRandom, strDeviceNo, strPsam, strAcctNo, strValidDate, strMac];
        
        
        [cardInfo setCardInfo:[NSString stringWithFormat:@"FF00%@%@", [self intToHexString:(int)[info length]/2 lenght:4],info]];
        
        
        [super.delegate posResponseDataWithCardInfoModel:cardInfo];
        
    }
    
}


- (void)connect {
//    [self initNewLandSDK];
//    BOOL isConnect = [self initializeAudioDriver];
//    if (isConnect)
//    {
//        [Log show:@"设备连接成功"];
//    }
}

- (void)stop {
    [self.device reset];
}

- (void)close {
    [self.device destroy];
}

- (int)getDeviceType {
    int type = -1;
    
    return type;
}



#pragma mark - NLIC卡读卡

- (void)onRequestOnline:(id<NLEmvTransController>)controller context:(NLEmvTransInfo*)context error:(NSError*)err
{
    //卡号明文(10B) + 55域和卡号随机数(4) + 卡有效期(4) + 终端号(10) +55域密文长度(2) + 55域密文 + MAC(4) + MAC随机数(4) + 卡号密文
    
    int index = 0;
    
    NSString *cardNO = CString(@"%@",[[context encrypt_data] subdataWithRange:NSMakeRange(index, 10)]);
    cardNO = [cardNO substringWithRange:NSMakeRange(1, [cardNO length]-2)];
    cardNO = [cardNO stringByReplacingOccurrencesOfString:@"f" withString:@""];
    cardNO = [cardNO stringByReplacingOccurrencesOfString:@" " withString:@""];
    index += 10;
    NSLog(@"卡号明文:%@",cardNO);
    
    NSString *random = CString(@"%@", [[context encrypt_data] subdataWithRange:NSMakeRange(index, 4)]);
    random = [random substringWithRange:NSMakeRange(1, [random length]-2)];
    random = [random stringByReplacingOccurrencesOfString:@" " withString:@""];
    index += 4;
    NSLog(@"55域和卡号随机数:%@", random);
    
    
    NSString *cardSequensNo = [context cardSequenceNumber];
    NSLog(@"卡序列号:%@", cardSequensNo);
    
    NSString *cardVaild = CString(@"%@", [[context encrypt_data] subdataWithRange:NSMakeRange(index, 4)]);
    cardVaild = [cardVaild substringWithRange:NSMakeRange(1, [cardVaild length]-2)];
    cardVaild = [cardVaild stringByReplacingOccurrencesOfString:@" " withString:@""];
    index += 4;
    NSLog(@"卡有效期:%@", cardVaild);
    
    NSString *ksn = CString(@"%@", [[context encrypt_data] subdataWithRange:NSMakeRange(index, 10)]);
    ksn = [ksn substringWithRange:NSMakeRange(1, [ksn length]-2)];
    ksn = [ksn stringByAppendingString:[ksn substringFromIndex:4]];
    ksn = [ksn stringByReplacingOccurrencesOfString:@" " withString:@""];
    index += 10;
    NSLog(@"终端号+psam:%@", ksn);
    NSString *terminalNo = [ksn substringToIndex:20];
    
    NSString *encField55Length = CString(@"%@", [[context encrypt_data] subdataWithRange:NSMakeRange(index, 2)]);
    encField55Length = [encField55Length substringWithRange:NSMakeRange(1, [encField55Length length]-2)];
    encField55Length = [encField55Length stringByReplacingOccurrencesOfString:@" " withString:@""];
    index += 2;
    NSLog(@"55域密文长度:%@",encField55Length);
    
    NSString *encField55 = CString(@"%@", [[context encrypt_data] subdataWithRange:NSMakeRange(index, [encField55Length intValue])]);
    encField55 = [encField55 substringWithRange:NSMakeRange(1, [encField55 length]-2)];
    encField55 = [encField55 stringByReplacingOccurrencesOfString:@" " withString:@""];
    index += [encField55Length intValue];
    NSLog(@"55域密文:%@", encField55);
    
    NSString *mac = CString(@"%@", [[context encrypt_data] subdataWithRange:NSMakeRange(index, 8)]);
    mac = [mac substringWithRange:NSMakeRange(1, [mac length]-2)];
    mac = [mac stringByReplacingOccurrencesOfString:@" " withString:@""];
    index += 8;
    NSLog(@"MAC+MAC随机数:%@", mac);
    
    
//    NSString *enCardNO = [[NSString alloc] initWithData:[context encrypt_data] encoding:NSASCIIStringEncoding];
    NSString *cardNOEncode = CString(@"%@",[[context encrypt_data] subdataWithRange:NSMakeRange(index, [[context encrypt_data] length] - index)]);
    cardNOEncode = [cardNOEncode substringWithRange:NSMakeRange(1, [cardNOEncode length]-2)];
    cardNOEncode = [cardNOEncode stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"卡号密文:%@", cardNOEncode);

    
    /*
     
     ksn
     track1length
     track2length
     track3length
     randomnumber           随机数
     maskedPan              卡号明文（卡号）
     ExpiryDate             卡有效期
     CardHolderName         nil
     CardMac                MAC+MAC随机数
     CarSquensNo            卡序列号、
     IccData                nil
     IsIcc                  yes
     cardNOEncode           卡号密文
 
     */
    
    CardInfoModel *cardInfo = [[CardInfoModel alloc] init];
    [cardInfo setTrack:0];
    [cardInfo setTrack2Lenght:0];
    [cardInfo setTrack3Lenght:0];
    [cardInfo setCardNO:[NSString stringWithFormat:@"%@", cardNO]];         //maskedPan卡号明文==卡号
    [cardInfo setRandom:[NSString stringWithFormat:@"%@",random]];          //55域和卡号随机数
    [cardInfo setSequensNo:[NSString stringWithFormat:@"%@",cardSequensNo]];//序列号
    [cardInfo setExpiryDate:[NSString stringWithFormat:@"%@", cardVaild]];  //卡有效期
    [cardInfo setDeviceNo:[NSString stringWithFormat:@"%@",terminalNo]];    //设备号
    [cardInfo setData55:[NSString stringWithFormat:@"%@", encField55]];     //55域数据
    [cardInfo setMac:[NSString stringWithFormat:@"%@", mac]];               //mac+mac随机数
    
    [cardInfo setHasPassword:YES];
    

    
    NSString *cardLenght = [self intToHexString:(int)[encField55 length]/2 lenght:4];
    NSString *randomLenght = [self intToHexString:(int)[random length]/2 lenght:2];
    NSString *ksnLenght = [self intToHexString:(int)[ksn length]/2 lenght:2];
    NSString *cardNOEncodeLenght = [self intToHexString:(int)[cardNOEncode length]/2 lenght:2];
    
    
     NSString * info =  [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@",cardLenght , randomLenght , randomLenght , ksnLenght , cardNOEncodeLenght ,encField55, random,ksn,cardNOEncode ,random , cardSequensNo , cardVaild ,mac];
    
    [cardInfo setCardInfo:[NSString stringWithFormat:@"FC00%@%@", [self intToHexString:(int)[info length]/2 lenght:4],info]];

    
    
    
    [super.delegate posResponseDataWithCardInfoModel:cardInfo];
    
    
}



#pragma GikoAudioPortListener
//收到数据
//- (void)dataArrive:(vcom_Result *)vs Status:(int)_status {
//    
//}

- (void)onGikoWaitingForDevice{
    //通知监听器控制器CSwiperController正在搜索刷卡器
}

- (void)onGikoDecodingStart {
    //通知监听器开始解析或读取卡号、磁道等相关信息
}

- (void)onGikoDecodeDrror:(int)decodeResult {
    
}

- (void)onGikoDecodeCompleted:(NSString *)formatID andKsn:(NSString *)ksn andencTracks:(NSString *)encTracks andTrack1Length:(int)track1Length andTrack2Length:(int)track2Length andTrack3Length:(int)track3Length andRandomNumber:(NSString *)randomNumber andMaskedPAN:(NSString *)maskedPAN andExpiryDate:(NSString *)expiryDate andCardHolderName:(NSString *)cardHolderName andCardMAC:(NSString *)cardMAC andCardSequensNo:(NSString *)cardSequensNo andIccData:(NSString *)iccData andIsIcc:(BOOL)isIcc cardNOEncode:(NSString *)cardNOEncode {
    
}

//通知监听器没有刷卡器硬件设备
- (void)onGikoNoDeviceDetected{
    
}
//通知监听器控制器CSwiperController的操作超时
//(超出预定的操作时间，30秒)
- (void)onGikoTimeout {
    
}
//通知监听器可以进行刷卡动作
- (void)onGikoWaitingForCardSwipe {
    [Log show:@"请刷卡"];
}
// 通知监听器检测到刷卡动作
- (void)onGikoCardSwipeDetected {
    [Log show:@"正在刷卡"];
}

- (void)onAudioDevicePlugged {
    
}

- (void)onAudioDeviceUnPlugged {
    
}

- (void)onGikoError:(int)errorCode andMsg:(NSString *)errorMsg {
    
}

- (void)onGikoInterrupted {
    
}

- (void)onGikoMicInOut:(int)inout {
    
}




@end
