

//
//  Manager.m
//  PosDemo
//
//  Created by 张倡榕 on 15/1/19.
//  Copyright (c) 2015年 yoolink. All rights reserved.
//

#import "PosManager.h"

#import "ITron4K.h"
#import "ITronAudioICVpos.h"
#import "ITronAudioVpos.h"
#import "ITronBlueToothVpos.h"
#import "ITronICCard.h"
#import "NLICCard.h"
#import "vcom.h"
#import "MBProgressHUD+Add.h"

@interface PosManager()<PosResponse>
{
    UIView *v;
    BOOL pluggedType;
    BOOL posBigType;
    BOOL MBPType;
    NSTimer *time;
    dispatch_queue_t queue;
}
@property (nonatomic, assign)NSInteger deviceType;
@property (nonatomic, assign)int device;
@property (nonatomic, assign)BOOL isPlugged;
//@property (nonatomic, strong)NSTimer  *timer;
@property (nonatomic, strong)NSObject<PosResponse>*delegate;

@end
#define USERDEF_DEVICETYPE @"deviceType"

@implementation PosManager
@synthesize pos;
//@synthesize timer;
@synthesize delegate;

static PosManager *instance;

+ (PosManager*)getInstance{
    if(!instance){
        instance = [[PosManager alloc] init];
        instance.delegate = instance;
    }
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.isPlugged = NO;
        if (!queue) {
            queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        }
    }
    return self;
}
- (void)ResetBlue{
    pluggedType = NO;
}
- (void)posNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(outputDevice:) name:AVAudioSessionRouteChangeNotification object:[AVAudioSession sharedInstance]];
    
    self.pos = [[ITronICCard alloc]initWithDelegate:self];
    if ([[self.pos mVcom] hasHeadset]) {
        pluggedType = YES;
    }
    else
    {
        pluggedType = NO;
    }
    self.pos = nil;
}

-(void)outputDevice:(NSNotification *)aNotification
{
    //    NSLog(@"%@",aNotification);
    //    拔出 = 2 || 插入 = 1；
    NSLog(@"%@",[aNotification.userInfo objectForKey:@"AVAudioSessionRouteChangeReasonKey"]);
    
    NSUInteger temp = [[aNotification.userInfo objectForKey:@"AVAudioSessionRouteChangeReasonKey"] integerValue];
    if (temp == AVAudioSessionRouteChangeReasonNewDeviceAvailable) {
        [self onDevicePlugged];
    }
    else if (temp == AVAudioSessionRouteChangeReasonOldDeviceUnavailable)
    {
        [self onDeviceUnPlugged];
    }
    
}

- (void)getDeviceKind{
    if (self.deviceType == -1) {
        self.deviceType = [[NSUserDefaults standardUserDefaults] integerForKey:USERDEF_DEVICETYPE];
    }
}

- (int)deviceWithString:(NSString*)device{
    int n = 0;
    for (int i=0; i<device.length; i++) {
        char c = [device characterAtIndex:i];
        c -= 48;
        if (i > 0) {
            n = n << 1;
        }
        n += c;
    }
    NSLog(@"dev %X", n);
    
    return n;
}

- (void)getDevice:(NSString*)device{
    self.device = [self deviceWithString:device];
    //    [self performSelectorInBackground:@selector(getDevice) withObject:nil];
    [self getDevice];
}

- (void)getDevice{
    //选择下发设备是哪种
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    int def = [[user objectForKey:defDeivecType] intValue];
    if (def == -99) {
        if (DEVICE_TYPE_MINI_IC == (self.device & DEVICE_TYPE_MINI_IC)) {
            // 找到设备MINI_IC
            [self switchDevice:DEVICE_TYPE_MINI_IC];
            //        self.device -= DEVICE_TYPE_MINI_IC;
        }
        else if (DEVICE_TYPE_BOARD_BLUETOOTH == (self.device & DEVICE_TYPE_BOARD_BLUETOOTH)) {
            // 找到设备BOARD
            [self switchDevice:DEVICE_TYPE_BOARD_BLUETOOTH];
            //        self.device -= DEVICE_TYPE_BOARD;
            
        }
        else if (DEVICE_TYPE_BOARD == (self.device & DEVICE_TYPE_BOARD)) {
            // 找到设备BLUETOOTH
            [self switchDevice:DEVICE_TYPE_BOARD];
            //        self.device -= DEVICE_TYPE_BOARD_BLUETOOTH;
        }
        else if (DEVICE_TYPE_MINI == (self.device & DEVICE_TYPE_MINI)) {
            // 找到设备MINI
            [self switchDevice:DEVICE_TYPE_MINI];
            //        self.device -= DEVICE_TYPE_MINI;
            
        }
        else if (DEVICE_TYPE_NLIC == (self.device & DEVICE_TYPE_NLIC)) {
            // 找到设备NEWLANDIC
            [self switchDevice:DEVICE_TYPE_NLIC];
            //        self.device -= DEVICE_TYPE_NLIC;
            
        }
        else if (DEVICE_TYPE_PRINTER == (self.device & DEVICE_TYPE_PRINTER)) {
            // 找到设备PRINTER
            [self switchDevice:DEVICE_TYPE_PRINTER];
            //        self.device -= DEVICE_TYPE_PRINTER;
        }
    } else {
        // 默认初始化上次的设备
        [self switchDevice:def];
    }
}

- (void)timeOut{
    //    if (timer) {
    //        [self onDeviceKind:-1];
    //    }
}

- (void)switchDevice:(NSInteger) deviceType {
    dispatch_async(queue, ^{
        self.device -= (int)deviceType;
        if (deviceType == DEVICE_TYPE_BOARD || deviceType == DEVICE_TYPE_MINI_IC) {
            //无默认数据或默认为
            self.pos = [[ITronICCard alloc] initWithDelegate:self.delegate];
            self.device = self.device & 0xFA;
            [NSThread sleepForTimeInterval:0.6];
            dispatch_sync(dispatch_get_main_queue(), ^{
                [[self.pos mVcom] StopRec];
                [[self.pos mVcom] getTerminalType];
                [[self.pos mVcom] StartRec];
            });
            NSLog(@"------------> MINI_IC  BOARD");
            //        timer = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(timeOut) userInfo:nil repeats:NO];
            //        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
            //        [[NSRunLoop currentRunLoop] run];
        }
        else if (deviceType == DEVICE_TYPE_BOARD_BLUETOOTH){
            self.pos = [[ITronBlueToothVpos alloc]initWithDelegate:self];
            NSLog(@"------------> BOARD_BLUETOOTH");
            
        }else if (deviceType == DEVICE_TYPE_MINI){
            self.pos = [[ITron4K alloc] initWithDelegate:self.delegate];
            [NSThread sleepForTimeInterval:0.6];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [[self.pos mVcom] StopRec];
                [[self.pos mVcom] Request_GetKsn];
                [[self.pos mVcom] StartRec];
            });
            
            NSLog(@" ------------> MINI");
            //
            //        timer = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(timeOut) userInfo:nil repeats:NO];
            //        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
            //        [[NSRunLoop currentRunLoop] run];
        }else if (deviceType == DEVICE_TYPE_NLIC){
            self.pos = [[NLICCard alloc] initWithDelegate:self.delegate];
            [(NLICCard*)self.pos initializeAudioDriver];
            
            NSLog(@"------------> NLIC");
            
        }else if (deviceType == DEVICE_TYPE_PRINTER){
            self.pos = [[ITronAudioVpos alloc] initWithDelegate:self.delegate];
            [NSThread sleepForTimeInterval:0.6];
            dispatch_sync(dispatch_get_main_queue(), ^{
                [[self.pos mVcom] StopRec];
                
                [[self.pos mVcom] Request_GetExtKsn];
                [[self.pos mVcom] StartRec];
            });
            NSLog(@"------------> PRINTER");
            
        }
        else
        {
            NSLog(@"结束判断");
        }
    });
}

- (void)initDeviceWithType:(int) deviceType{
    NSString *log = @"初始化完成";
    switch (deviceType) {
        case DEVICE_TYPE_MINI_IC :
            self.pos = [[ITronICCard alloc] initWithDelegate:self.delegate];
            break;
        case DEVICE_TYPE_BOARD:
//            self.pos = [[ITronAudioICVpos alloc] initWithDelegate:self.delegate];
            self.pos = [[ITronICCard alloc] initWithDelegate:self.delegate];

            break;
        case DEVICE_TYPE_BOARD_BLUETOOTH:
            self.pos = [[ITronBlueToothVpos alloc] initWithDelegate:self.delegate];
            break;
        case DEVICE_TYPE_MINI:
            self.pos = [[ITron4K alloc] initWithDelegate:self.delegate];
            break;
        case DEVICE_TYPE_NLIC:
            //            self.pos = [[NLICCard alloc] initWithDelegate:self.delegate];
            break;
        case DEVICE_TYPE_PRINTER:
            if (!self.pos) {
                self.pos = [[ITronAudioVpos alloc] initWithDelegate:self.delegate];
            }
            break;
        default:
            self.pos = nil;
            log = @"未找到初始化的刷卡器驱动";
            break;
    }
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:deviceType] forKey:defDeivecType];
    MBPType = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:v animated:YES];
    });
    pluggedType = YES;
    NSLog(@"刷卡器初始化,%@", log);
}

// 设备检查状态,返回-1时未找到设备
- (void)onDeviceKind:(int)type {
    //    DEVICE_TYPE_MINI_IC = 1 << 0,
    //    DEVICE_TYPE_BOARD_BLUETOOTH = 1 << 1,
    //    DEVICE_TYPE_BOARD = 1 << 2,
    //    DEVICE_TYPE_MINI = 1 << 3,
    //    DEVICE_TYPE_NLIC = 1 << 4,
    //    DEVICE_TYPE_PRINTER = 1 << 5,
    NSLog(@"device kind %d, %2X", type, self.device);
    //    if (timer) {
    //        [timer invalidate];
    //        timer = nil;
    ////        [self.pos stop];
    //    }
    [[self.pos mVcom] StopRec];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    if (type != -1) {
        int devDevice = [self deviceWithString:[[UserBaseData getInstance] device]];
        if (!(self.deviceType != type && (devDevice & type) == 0)) {
            self.deviceType = type;
            //            [user setInteger:self.deviceType forKey:USERDEF_DEVICETYPE];
            [user setObject:[NSNumber numberWithInt:self.deviceType] forKey:defDeivecType];
            //获取到deviceType
            [self initDeviceWithType:type];
            if (type == DEVICE_TYPE_PRINTER) {
                posBigType = [(ITronAudioVpos *)self.pos bigType];
            }
        } else {
            NSLog(@"插入的刷卡器未配置");
            type = -1;
            self.device = 0;
            //            if (self.device > 0) {
            //                self.pos = nil;
            //                [self performSelectorInBackground:@selector(getDevice) withObject:nil];
            ////                [self getDevice];
            //            }
        }
    }else if (self.deviceType < DEVICE_TYPE_PRINTER){
        
        int def = [[user objectForKey:defDeivecType] intValue];
        if (def != -99) {
            def = -99;
            [user setObject:[NSNumber numberWithInt:def] forKey:defDeivecType];
            [user synchronize];
        }
        if (self.device > 0) {
            self.pos = nil;
            //            [self performSelectorInBackground:@selector(getDevice) withObject:nil];
            [self getDevice];
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.device == 0 && type == -1) {
            [MBProgressHUD hideHUDForView:v animated:YES];
            [MBProgressHUD showHUDAddedTo:v WithString:@"识别失败，请重新插入。"];
            pluggedType = NO;
        }
    });
    if (type == -1) {
        MBPType = NO;
    }
    else {
        MBPType = YES;
    }
}

-(void)posResponseDataWithCardInfoModel:(CardInfoModel *)cardInfo{
    [self.pos.delegate posResponseDataWithCardInfoModel:cardInfo];
    
}

//
- (void)cswipecardTransLogNo:(NSString *)transLogNo orderId:(NSString *)orderId delegate:(id<PosResponse>)de
{
    self.pos.delegate = de;
    [self.pos startWithData:@{
                              @"transLogNo":transLogNo,
                              @"orderId":orderId,
                              }];
}

- (void)onDevicePlugged {
    if (! self.isPlugged) {
        self.isPlugged = YES;
        [self pluggedInitDevice];
    }
}

- (void)onDeviceUnPlugged {
    //     dispatch_sync(dispatch_get_main_queue(), ^{
    if (v) {
        [MBProgressHUD hideHUDForView:v animated:YES];
    }
    //     });
    [self.pos stop];
    [self.pos close];
    self.pos = nil;
    self.deviceType = -1;
    pluggedType = NO;
    NSLog(@"刷卡器拔出");
    
    self.isPlugged = NO;
    
}

- (void)pluggedInitDevice{
    dispatch_async(dispatch_get_main_queue(), ^{
        v = nil;
        
        NSArray *viewsArray = [UIApplication sharedApplication].windows;
        if([viewsArray count] > 0)
        {
            UIView *frontView = [viewsArray objectAtIndex:0];
            
            id nextResponder = [frontView nextResponder];
            
            if([nextResponder isKindOfClass:[UINavigationController class]]){
                UINavigationController *nav = nextResponder;
                UIViewController *ctrl = [nav.viewControllers lastObject];
                v = ctrl.view;
            }else if([nextResponder isKindOfClass:[UIViewController class]])
            {
                UIViewController *ctrl = nextResponder;
                v = [[ctrl.view subviews] lastObject];
            }
            else
            {
                v = [viewsArray lastObject];
            }
        }
        if (v) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:v animated:YES];
            [hud hide:YES afterDelay:20];
            time = [NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(MBPclose) userInfo:nil repeats:NO];
        }
    });
    
    [self getDeviceKind];
    [self getDevice:[AppDelegate getUserBaseData].device];
    pluggedType = YES;
    NSLog(@"刷卡器插入");
}
-(void)MBPclose
{
    if (MBPType == NO) {
        [self onDeviceUnPlugged];
    }
}

- (BOOL)getPluggedType
{
    return pluggedType;
}

-(BOOL)getBigType
{
    return  posBigType;
}

/*!
 @method
 @abstract 通知ksn
 @discussion 正常启动刷卡器后，将返回ksn
 @param ksn 取得的ksn
 @2014.8.8修改，把版本也传过去
 */
-(void)onGetKsnCompleted:(NSString *)ksn{
    NSLog(@"ksn %@",ksn);
}


@end
