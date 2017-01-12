//
//  IRONF2F.m
//  PosDemo
//
//  Created by 张倡榕 on 14/12/24.
//  Copyright (c) 2014年 yoolink. All rights reserved.
//

#import "ITron4K.h"
#import "CardInfoModel.h"
#import "CSwiperStateChangedListener.h"
#define TIMEOUT 30

@interface ITron4K()<CSwiperStateChangedListener>

@end

@implementation ITron4K
@synthesize mVcom;
@synthesize delegate;

- (id)initWithDelegate:(NSObject<PosResponse> *)delegate_ {
    self = [super initWithDelegate:delegate_];
    if (self) {
        [self initIRonSDK];
    }
    return self;
}

-(void)initIRonSDK{
    mVcom = [vcom getInstance];
    [mVcom setEventListener:self];
    [mVcom open];
//    [mVcom setVloumn:95];
    [mVcom setDebug:YES];

//    初始化爱刷刷卡头
    [mVcom setCommmunicatinMode:aiShua];

    [mVcom setMode:VCOM_TYPE_F2F recvMode:VCOM_TYPE_F2F];
    [mVcom setF2F4k:YES];
}

-(void)connect {
//    [mVcom StartRec];
}
-(void)startWithData:(NSDictionary *)data {
    
    [self readcard:1 data:data];
    
}

-(void)stop {
    [mVcom StopRec];
}

-(void)close {
    [mVcom setEventListener:nil];
    [mVcom close];
    mVcom = nil;
}


#pragma  mark - 刷卡方法

//解析卡号、磁道信息等数据出错时，回调此接口
-(void)onDecodeDrror:(int)decodeResult{
    NSLog(@"解析卡号、磁道信息等数据出错时，回调此接口:%d", decodeResult);
}

//收到数据
//-(void) dataArrive:(vcom_Result*) vs  Status:(int)_status;
//mic插入
-(void) onMicInOut:(int) inout{
    NSLog(@"设备插入or拔出 %d",inout);
}

//通知监听器刷卡器插入手机
-(void) onDevicePlugged{
    NSLog(@"刷卡器插入手机");
}

//通知监听器刷卡器已从手机拔出
-(void) onDeviceUnPlugged{
    NSLog(@"刷卡器已从手机拔出");
}

//通知监听器控制器CSwiperController正在搜索刷卡器
-(void) onWaitingForDevice{
    NSLog(@"正在搜索刷卡器");
}

//通知监听器没有刷卡器硬件设备
-(void)onNoDeviceDetected{
    NSLog(@"没有刷卡器硬件设备");
}

//通知监听器可以进行刷卡动作
-(void)onWaitingForCardSwipe{
    NSLog(@"可以进行刷卡动作");
}

// 通知监听器检测到刷卡动作
-(void)onCardSwipeDetected{
    NSLog(@"检测到刷卡动作");
}

//通知监听器开始解析或读取卡号、磁道等相关信息
-(void)onDecodingStart{
    NSLog(@"开始解析或读取卡号、磁道等相关信息");
}

#define VCOM_ERROR 1 //提供errorMsg，描述错误原因
#define VCOM_ERROR_FAIL_TO_START  2//CSwiperController创建失败
#define VCOM_ERROR_FAIL_TO_GET_KSN   3//取ksn失败
-(void)onError:(int)errorCode andMsg:(NSString*)errorMsg{
    NSLog(@"出错:%@,%i", errorMsg, errorCode);
}

//通知监听器控制器CSwiperController的操作被中断
-(void)onInterrupted{
    NSLog(@"刷卡器操作被中断");
}

//通知监听器控制器CSwiperController的操作超时
//(超出预定的操作时间，30秒)
-(void)onTimeout{
    NSLog(@"刷卡器连接超时");
    [self sendDeviceType:-1];
}

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
 */
-(void)onDecodeCompleted:(NSString*) formatID
                  andKsn:(NSString*) ksn
            andencTracks:(NSString*) encTracks
         andTrack1Length:(int) track1Length
         andTrack2Length:(int) track2Length
         andTrack3Length:(int) track3Length
         andRandomNumber:(NSString*) randomNumber
            andMaskedPAN:(NSString*) maskedPAN
           andExpiryDate:(NSString*) expiryDate
       andCardHolderName:(NSString*) cardHolderName {
    
}

//开始刷卡
- (BOOL) readcard: (NSInteger) cmd data:(NSDictionary *)data {
    
    [mVcom StopRec];
//    [mVcom setVloumn:75];
    
    if ( NO == [self hasHeadset] ) {
        return NO;
    }
    
//    F2F
    NSString *orderId = [data objectForKey:@"orderId"];
    NSString *transLogNo = [data objectForKey:@"transLogNo"];
    NSString *cash = [data objectForKey:@"cash"];
    if (! cash || [@"" isEqualToString:cash]) {
        cash = @"0";
    }
    NSMutableArray* result = [NSMutableArray array];
    for (int i=0; i<[orderId length]; i++) {
        int asciiCode = [orderId characterAtIndex:i] - '0' + 30;
        [result addObject:[NSString stringWithFormat:@"%d", asciiCode]];
    }
    NSString *asciiOrderId = [result componentsJoinedByString:@""];
    char append[16]= {0};
    char* st = HexToBin((char *)[asciiOrderId UTF8String]);
    memcpy(append,st,16);
    
    // 随机数
    char *numRadom = HexToBin((char *)[transLogNo UTF8String]);
    int numRadomLen = (int)[transLogNo length] / 2;
    char randomdata[3]={0};
    memcpy(randomdata, numRadom, numRadomLen);
    
//    int cashLen = [cash length];
    char cData[100];
    cData[0] = 0;
    strcpy(cData,((char*)[cash UTF8String]));
    
    
    int ctrlMode = 0b00000011;
    
    [mVcom startDetector:ctrlMode random:randomdata randomLen:numRadomLen data:append datalen:16 time:TIMEOUT];

    
    //开始启动接收刷卡器数据
    [mVcom StartRec];
    NSLog(@"---------请刷卡---------");
    return YES;
}
// 设备检查

- (BOOL) hasHeadset {
    if ( ! [mVcom hasHeadset] ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"未检测到刷卡器" message:@"请将手机刷卡器插入耳机孔，或点击“现在购买”" delegate:self cancelButtonTitle:@"现在购买" otherButtonTitles:@"关闭",nil];
        alert.tag = 2000;
        [alert show];
        return NO;
    }
    
    if (![self checkDeviceType])
        return NO;
    
    return YES;
}

- (BOOL)checkDeviceType{
    
    NSDictionary *info = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DeviceTypeLimit" ofType:@"plist"]];
    
    if (info == nil) {
        return YES;
    }
    
    return NO;
}
//收到数据
-(void) dataArrive:(char*)data dataLen:(int) len {
    NSLog(@"加载了,回来了");
    NSString* info = [mVcom HexValue:data Len:len];
    info = [@"FD" stringByAppendingString:info];
    NSLog(@"数据内容---> %@",info);
    
    //    [super.delegate posResponseDataWithCardInfoModel:info];
}

#pragma mark - CSwiperStateChangedListener 必须实现协议方法

//设备类型回调
- (void)onDeviceKind:(int) result{
    NSLog(@"返回设备号%d", result);
    
    if ([super.delegate respondsToSelector:@selector(onDeviceKind:)]) {
        [super.delegate onDeviceKind:result];
    }
    
}

//通知电话中断结束设备准备好了

-(void)onDeviceReady {
    NSLog(@"电话中断结束设备准备好了");
}

//插入ic卡

-(void)onICcardInput{
    NSLog(@"插入ic卡");
}

// @2014.8.8修改，把版本也传过去
- (void)onGetKsnAndVersionCompleted:(NSArray *)ksnAndVerson{
    NSLog(@"ksn & verson \n%@",ksnAndVerson);
    
    int deviceType = -1;
    if ([[ksnAndVerson objectAtIndex:1] rangeOfString:@"vAC"].length > 0) {
        deviceType = DEVICE_TYPE_MINI_IC;
    } else if ([[ksnAndVerson objectAtIndex:1] rangeOfString:@"VQT"].length > 0){
        deviceType = DEVICE_TYPE_MINI;
    } else if ([[ksnAndVerson objectAtIndex:1] rangeOfString:@"vHH"].length > 0){
        deviceType = DEVICE_TYPE_MINI;
    }else {
        if ([mVcom hasHeadset] == 1) {
            deviceType = DEVICE_TYPE_BOARD;
        }else{
            deviceType = DEVICE_TYPE_BOARD_BLUETOOTH;
        }
    }
    
    if ([super.delegate respondsToSelector:@selector(onDeviceKind:)]) {
        [super.delegate onDeviceKind:deviceType];
    }
}



-(void)onGetKsnCompleted:(NSString *)ksn {
    NSLog(@"ksn %@",ksn);
}

//通知监听器可以进行艾刷刷卡动作
-(void)onWaitingForCardSwipeForAiShua {
    NSLog(@"通知监听器可以进行艾刷刷卡动作");
}


/*!
 @method
 @abstract 错误提示
 @discussion 出现错误。可能偶然的错误，设备与手机的适配问题，或者设备与驱动不符。
 @param errorCode 错误代码。
 @param errorMessage 错误信息。
 */

#define VCOM_ERROR 1 //提供errorMsg，描述错误原因
#define VCOM_ERROR_FAIL_TO_START  2//CSwiperController创建失败
#define VCOM_ERROR_FAIL_TO_GET_KSN   3//取ksn失败
- (void)onError:(int)errorCode ErrorMessage:(NSString *)errorMessage {
    NSLog(@"错误提示,%d,%@", errorCode, errorMessage);
    if ((errorCode == 3 || errorCode == -3) &&[super.delegate respondsToSelector:@selector(onDeviceKind:)]) {
        [super.delegate onDeviceKind:-1];
    }
}



//解析艾刷返回的数据信息
-(void)secondReturnDataFromAiShua {
    NSLog(@"解析艾刷返回的数据信息");
}

-(void)onDecodeCompleted:(NSString*) formatID
                  andKsn:(NSString*) ksn
            andencTracks:(NSString*) encTracks
         andTrack1Length:(int) track1Length
         andTrack2Length:(int) track2Length
         andTrack3Length:(int) track3Length
         andRandomNumber:(NSString*) randomNumber
           andCardNumber:(NSString *)maskedPAN
                  andPAN:(NSString*) PAN
           andExpiryDate:(NSString*) expiryDate
       andCardHolderName:(NSString*) cardHolderName
                  andMac:(NSString *)mac
        andQTPlayReadBuf:(NSString*) readBuf
                cardType:(int)type
              cardserial:(NSString *)serialNum
             emvDataInfo:(NSString *)data55
                 cvmData:(NSString *)cvm {
//    NSLog(@" ----- > %@",formatID);
//    NSLog(@"KSN信息 ----- > %@",ksn);
//    NSLog(@"磁道信息 ----- > %@",encTracks);
//    NSLog(@"1磁长度 ----- > %d",track1Length);
//    NSLog(@"2磁长度 ----- > %d",track2Length);
//    NSLog(@"3磁长度 ----- > %d",track3Length);
//    NSLog(@"随机数 ----- > %@",randomNumber);
//    NSLog(@"PANLength ----- > %@",PAN);
//    NSLog(@"卡号信息 ----- > %@",maskedPAN);
//    NSLog(@"卡有效期 ----- > %@",expiryDate);
//    NSLog(@"MAC ----- > %@",mac);
//    NSLog(@"所有信息 ----- > %@",readBuf);

    
    NSString *cardInfo = nil;
    
    
    NSString *strTrack1Length = [self intToHexString:track1Length lenght:2];
    NSString *strTrack2Length = [self intToHexString:track2Length lenght:2];
    NSString *strTrack3Length = [self intToHexString:track3Length lenght:2];
    NSString *randomLenght = [self intToHexString:(int)[randomNumber length]/2 lenght:2];
    NSString *ksnLenght = [self intToHexString:(int)[ksn length]/2 lenght:2];
    
    if (track2Length == 0) {
        strTrack2Length = @"18";
    }
    maskedPAN = [mVcom HexValue:(char*)[maskedPAN cStringUsingEncoding:NSASCIIStringEncoding] Len:(int)[maskedPAN length]];
    
    NSString *maskedPANLenght = [self intToHexString:(int)[maskedPAN length]/2 lenght:2];
    
    
    
    
    
    NSString *track2 = [encTracks substringToIndex:track2Length*2];
    NSString *track3 = [encTracks substringFromIndex:track2Length*2];
    
    if ([expiryDate length] == 4) {
        expiryDate = [mVcom HexValue:(char*)[expiryDate cStringUsingEncoding:NSASCIIStringEncoding] Len:(int)[expiryDate length]];
    }
    
    NSLog(@"KSN信息 ----- > %@",ksn);
    NSLog(@"磁道信息 ----- > %@",encTracks);
    NSLog(@"二磁数据 ----- > %@",track2);
    NSLog(@"三磁数据 ----- > %@",track3);
    NSLog(@"2磁长度 ----- >%i,16:%@",track2Length,strTrack2Length);
    NSLog(@"3磁长度 ----- >%i,16:%@",track3Length,strTrack3Length);
    NSLog(@"随机数 ----- > %@",randomNumber);
    NSLog(@"随机数长度 ----- > %@",randomLenght);
    NSLog(@"卡号 ----- > %@",maskedPAN);
    NSLog(@"卡号长度 ----- > %@",maskedPANLenght);
    NSLog(@"卡有效期 ----- > %@",expiryDate);
    NSLog(@"MAC ----- > %@",mac);
    NSLog(@"所有信息 ----- > %@",readBuf);
    
//    info = [NSString stringWithFormat:@"%@r%@%@%@%@%@%@%@%@%@%@%@%@", strTrack1Length, strTrack2Length, strTrack3Length ,randomLenght, ksnLenght, maskedPANLenght, track2, track3, randomNumber, ksn, maskedPAN, expiryDate, mac];
    
    CardInfoModel *CardInfo = [[CardInfoModel alloc]init];
    [CardInfo setTrack:encTracks];
    [CardInfo setTrack2Lenght:[NSString stringWithFormat:@"%d",track2Length]];
    [CardInfo setTrack3Lenght:[NSString stringWithFormat:@"%d",track3Length]];
//    [CardInfo setDeviceNo:[NSString stringWithFormat:@"%@",DeviceNo]];
//    [CardInfo setPsamNO:[NSString stringWithFormat:@"%@",]];
    [CardInfo setRandom:[NSString stringWithFormat:@"%@",randomNumber]];
    [CardInfo setCardNO:[NSString stringWithFormat:@"%@",maskedPAN]];
    [CardInfo setExpiryDate:[NSString stringWithFormat:@"%@",expiryDate]];
    [CardInfo setMac:[NSString stringWithFormat:@"%@",mac]];
    [CardInfo setData55:@""];
    [CardInfo setSequensNo:@""];
    [CardInfo setHasPassword:YES];
    
    
    NSString *info = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@",strTrack1Length, strTrack2Length, strTrack3Length ,randomLenght, ksnLenght, maskedPANLenght, track2, track3, randomNumber, ksn, maskedPAN, expiryDate, mac];
    
    cardInfo = [NSString stringWithFormat:@"FF00%@%@", [self intToHexString:(int)[info length]/2 lenght:4],info];
    
    [CardInfo setCardInfo: [NSString stringWithFormat:@"%@",cardInfo]];
    
    
    
    [super.delegate posResponseDataWithCardInfoModel:CardInfo];
    

    
}



//参数下载回调
- (void)onLoadParam:(NSString *)param {
    NSLog(@"参数下载,%@",param );
}

- (void)sendDeviceType:(int)deviceType{
    if ([super.delegate respondsToSelector:@selector(onDeviceKind:)]) {
        [super.delegate onDeviceKind:deviceType];
    }
}


- (BOOL) deviceFindWith:(vcom_Result*)vs{
#define DEVICE_TYPE_POS (SUBCMD_POS  + 3 + 8 + 3)
    BOOL isFind = NO;
    char *data = vs->readbuf;
    
    int deviceType = -1;
    
    if(( data[CMD_POS] & 0xFF )==0x02 ) {
        if( (data[SUBCMD_POS] & 0xFF) == 0x00 ) {
            deviceType = DEVICE_TYPE_MINI;
            isFind = YES;
        } else if((data[SUBCMD_POS] & 0xFF) == 0x80 ) {
            
            if((data[DEVICE_TYPE_POS] & 0xFF) == 0x11 ) {
                
                deviceType = DEVICE_TYPE_BOARD;
                isFind = YES;
            }else if ((data[DEVICE_TYPE_POS] & 0xFF) == 0x17 || (data[DEVICE_TYPE_POS] & 0xFF) == 0x41 ) {
                
                deviceType = DEVICE_TYPE_PRINTER;
                isFind = YES;
            }
        }
    }
    if (isFind) {
        [self sendDeviceType:deviceType];
    }
    return isFind;
}

//收到数据
-(void) dataArrive:(vcom_Result*) vs  Status:(int)_status {
    NSLog(@"收到数据,%d",_status);
    
    if (_status == -3) {
        //超时
    }else if (_status == -2){
        
    }else if (_status == -1){
        
    }else if (_status == 0){
        char *data = vs->readbuf;
        
        if(( data[CMD_POS] & 0xFF )==0x02 ) {
            if( (data[SUBCMD_POS] & 0xFF) == 0x00 ) {
                // 4k型刷卡器
                [super.delegate onDeviceKind:DEVICE_TYPE_MINI];
                return;
            } else if ((data[SUBCMD_POS] & 0xFF) == 0x80 ) {
                if ((data[DEVICE_TYPE_POS] & 0xFF) == 0x11 ) {
                    // 音频vpos
                    [super.delegate onDeviceKind:DEVICE_TYPE_BOARD];
                } else if ((data[DEVICE_TYPE_POS] & 0xFF) == 0x17 || (data[DEVICE_TYPE_POS] & 0xFF) == 0x41 ) {
                    // 音频打印pos
                    [super.delegate onDeviceKind:DEVICE_TYPE_PRINTER];
                }
                return;
            }
        }
        
        NSLog(@"MAC:%@",[mVcom HexValue:vs->mac Len:vs->maclen ]);
        NSLog(@"cardEncryption:%@",[mVcom HexValue:vs->cardEncryption Len:vs->cardEncryptionLen]);
        NSLog(@"pan:%@",[mVcom HexValue:vs->pan Len:vs->panLen ]);
        NSLog(@"psamno:%@",[mVcom HexValue:vs->psamno Len:vs->psamnoLen ]);
        NSLog(@"hardSerialNo:%@",[mVcom HexValue:vs->hardSerialNo Len:vs->hardSerialNoLen ]);
        NSLog(@"pinEncryption:%@",[mVcom HexValue:vs->pinEncryption Len:vs->pinEncryptionLen ]);
    }
}



//IC卡回写脚本执行返回结果
- (void)onICResponse:(int)result resScript:(NSString *)resuiltScript data:(NSString *)data {
    
}



//检测到IC卡插入回调,通知客户端正在进行ic卡操作,用户禁止拔卡
- (void)EmvOperationWaitiing {
    NSLog(@"检测到IC卡插入回调,通知客户端正在进行ic卡操作,用户禁止拔卡");
}

@end
