//
//  ME11Controller.m
//  ipos
//
//  Created by ZhangSx on 14-11-18.
//
//

#import "ME11Controller.h"
@interface ME11Controller()
@end
static ME11Controller * shareInstance = nil;
static NSArray *L_55TAGS = nil;
@implementation ME11Controller
+(ME11Controller *)getInstance
{
    @synchronized(self)
    {
        if (shareInstance == nil) {
            shareInstance = [self new];
            L_55TAGS = @[@0x9F26, @0x9F27, @0x9F10, @0x9F37, @0x9F36,
                         @0x95, @0x9A, @0x9C, @0x9F02, @0x5F2a, @0x82,
                         @0x9F1A, @0x9F03, @0x9F33, @0x9F34, @0x9F35,
                         @0x9F1E, @0x84, @0x9F09, @0x9F41, @0x9F63];
        }
    }
    return  shareInstance;
}
- (id<NLDeviceDriver>)driver
{
//    GikoAppDelegate * app =(GikoAppDelegate *)[UIApplication sharedApplication].delegate;
//    return app.driver;
    return nil;
}
- (id<NLDevice>)device
{
//     GikoAppDelegate * app =(GikoAppDelegate *)[UIApplication sharedApplication].delegate;
//    return app.device;
    
    return nil;
}
-(NSString *)deviceInfo
{
    id<NLDeviceInfo> me11Info = [self.device me11DeviceInfo];
//    [self showMsgOnMainThread:CString(@"ME11 KSN : %@", [me11Info KSN])];
    
//    NSLog(@"ME11 KSN : %@....%@.....%d",[me11Info CSN],[me11Info VID],[me11Info PID]);
    return [me11Info CSN];
}


// 开始获取卡信息
- (void)startReadCard:(NSDictionary*)data
{
//    [self showMsgOnMainThread:@"正在等待刷卡/插卡......"];
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
    if (NLModuleTypeCommonICCard == moduleType) {
        //IC卡
        // ME11 pboc
//        [self showMsgOnMainThread:@"正在读取IC卡......"];
        id<NLEmvModule> emvModule = (id<NLEmvModule>)[self.device standardModuleWithModuleType:NLModuleTypeCommonEMV];
        id<NLEmvTransController> emvController = [emvModule emvTransControllerWithListener:self];
        [emvController startEmvWithAmount: [NSDecimalNumber decimalNumberWithString:@"10.00"] cashback:[NSDecimalNumber zero] forceOnline:YES];
    } else if (NLModuleTypeCommonSwiper == moduleType) {
//        [app.gikoAudioHelper.delegate onGikoDecodeCompleted:nil andKsn:ksn andencTracks: encTracks andTrack1Length:[rslt.firstTrackData length] andTrack2Length:[rslt.secondTrackData length] andTrack3Length:[rslt.thirdTrackData length] andRandomNumber:nil andMaskedPAN:nil andExpiryDate:rslt.validDate andCardHolderName:nil andCardMAC:nil andCardSequensNo:nil andIccData:nil andIsIcc:NO cardNOEncode:nil];
        
        NSString * strKsn = rslt.ksn == nil?@"":[NLISOUtils hexStringWithData:rslt.ksn];
        //刷卡返回的KSN其实是pos里CSN，pos里的KSN可以从CSN中截取出来，取第5个字符开始的子串就是Pos里的KSN
        NSString * strPsam = strKsn.length < 20?@"":[strKsn substringFromIndex:4];
        NSString * strTrack2 =rslt.secondTrackData == nil?@"":[NLISOUtils hexStringWithData:rslt.secondTrackData];
//        int lenTrack2 = [strTrack2 isEqual:@""]?0:strTrack2.length/2;
        
        NSString * strTrack3 =rslt.thirdTrackData == nil?@"":[NLISOUtils hexStringWithData:rslt.thirdTrackData];
//        int lenTrack3 = [strTrack3 isEqual:@""]?0:strTrack3.length/2;
        
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
        
        
    } else {
//        [self showMsgOnMainThread:@"该读卡模式不支持"];
    }

}



-(void) sendMsgToMain{
    
}

#pragma mark - NLEmvControllerListener implement
- (void)onRequestSelectApplication:(id<NLEmvTransController>)controller context:(NLEmvTransInfo*)context error:(NSError*)err
{
    
    //    [self showMsgOnMainThread:@"错误的事件返回，不可能要求应用选择！"];
    //    [controller cancelEmv];
}
- (void)onRequestTransferConfirm:(id<NLEmvTransController>)controller context:(NLEmvTransInfo*)context error:(NSError*)err
{
    
    //    [self showMsgOnMainThread:@"错误的事件返回，不可能要求交易确认！"];
    //    [controller cancelEmv];
}
- (void)onRequestPinEntry:(id<NLEmvTransController>)controller context:(NLEmvTransInfo*)context error:(NSError*)err
{
    
    //    [self showMsgOnMainThread:@"错误的事件返回，不可能要求密码输入！"];
    //    [controller cancelEmv];
}
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
    
    
}


- (void)onEmvFinished:(BOOL)isSuccess context:(NLEmvTransInfo*)context error:(NSError*)err
{
    
}
- (void)onFallback:(NLEmvTransInfo*)context error:(NSError*)err
{
//    [self showMsgOnMainThread:@"交易降级"];
    NSLog(@"交易降级");
}
- (void)onError:(id<NLEmvTransController>)controller error:(NSError*)err
{
//    [self showMsgOnMainThread:@"emv交易失败"];
    NSLog(@"emv交易失败");
    if ([err isKindOfClass:NSClassFromString(@"NLProcessTimeoutError")]) { // 超时
        // TODO
        return ;
    } else if ([err isKindOfClass:NSClassFromString(@"NLDeviceInvokeCanceledError")]) { // 取消
        // TODO
    }
}

@end
