//
//  LocationUtil.m
//  sandbao
//
//  Created by tianNanYiHao on 2017/11/28.
//  Copyright © 2017年 sand. All rights reserved.
//

#import "LocationUtil.h"



//第一步 - 静态实例化 - 且初始化
static LocationUtil *locationManagerInstance = nil;

@interface LocationUtil ()<CLLocationManagerDelegate>
{

    
}

//循环标识
@property (nonatomic, assign)BOOL runLoopOver;

//经纬度数组
@property (nonatomic, strong)NSArray *locationArr;

/**
 定位服务管理类
 */
@property (nonatomic, strong) CLLocationManager *locationManager;

/**
 地理编码器
 */
@property (nonatomic, strong) CLGeocoder *geocoder;

@end

@implementation LocationUtil

//第二步(0) - 实例构造单例化
+ (LocationUtil*)shareLocationManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        locationManagerInstance = [[self alloc] init];
    });
    return locationManagerInstance;
}


//第二步(1) alloc会调用allocWithZone:
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        locationManagerInstance = [super allocWithZone:zone];
    });
    return locationManagerInstance;
}

//第二步(2) - init方法单例化 - 防止使用init方式创建
- (instancetype)init{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if ([super init]) {
            [self initManager];
        }
    });
    return self;
    
}

- (void)initManager{
    
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestWhenInUseAuthorization]; //App在前台时调用
    //[self.locationManager requestAlwaysAuthorization]; //App在前后台时均调用
    //iOS8必须，这两行必须有一行执行，否则无法获取位置信息，和定位
    
    self.locationManager.delegate = self;
    
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest; //定位精确到米
    
    self.locationManager.distanceFilter = kCLDistanceFilterNone; //设置过滤器为无
    
//    self.geocoder = [[CLGeocoder alloc] init];  //初始化地理编码器
    
}

/**
 开启定位 
 * 返回值为经纬度字符串
 * 但需要等待定位方法([self.locationManager startUpdatingLocation])执行且有回调后,才能进行本方法返回经纬度值
 */
- (NSArray *)startUpdatingLocation{
    
    //检测定位权限是否开启 - 若未开启, 则直接返回空数组
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined ||      //定位-未决
        [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied                //定位-用户已禁止
        ) {
        //直接返回空数组
        return @[@"",@""];
    }
    //权限已开启
    else{
        
        //3分钟时间差
        BOOL isThreeMinutesOver =  [self ThreeMinutesOver];
        
        if (isThreeMinutesOver) {
            // @" -= -= -=-=  时间间隔大于3min 允许定位 -=-=-=-=-= "
            
            //开始定位
            //循环结束标识 - 初始化
            _runLoopOver = NO;
            
            //开始定位 - 等待回调 - 耗时操作
            [self.locationManager startUpdatingLocation];
            
            //只要循环结束标识为NO,则当前流程一直等待,(仅当前流程等待,不影响其他线程执行或整个程序执行)
            while(!_runLoopOver){
                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            }
            
            //一旦获取经纬度数组回调, 则当前流程执行返回值返回
            if (_runLoopOver) {
                return  _locationArr;
            }
        }
        else{
            // @" -= -= -=-=  还在3min内 无需定位 -=-=-=-=-= "
            if (_locationArr) {
                return _locationArr;
            }else{
                return  @[@"",@""];
            }
        }
    }
    return @[@"",@""];
}


/**
 3分钟时间差

 @return 是否超过3分钟时间差
 */
- (BOOL)ThreeMinutesOver{
    
    //3分钟时间差内 - 保持不更新
    NSDate *oldDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"oldDate"];
    NSDate *newDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"newDate"];;
    
    if (oldDate == nil || newDate == nil) {
        oldDate = [NSDate date];
        newDate = [NSDate date];
        [[NSUserDefaults standardUserDefaults] setObject:oldDate forKey:@"oldDate"];
        [[NSUserDefaults standardUserDefaults] setObject:newDate forKey:@"newDate"];
    }else{
        oldDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"oldDate"];
        //新时间总是 - 取当前最新时间
        newDate = [NSDate date];
        NSTimeInterval value = newDate.timeIntervalSince1970 - oldDate.timeIntervalSince1970;
        float min = (value / 60); //秒
        
        if (min > 3) {  //3min
            //更新旧时间为当前时间
            oldDate = [NSDate date];
            [[NSUserDefaults standardUserDefaults] setObject:oldDate forKey:@"oldDate"];
            
            return YES;
        }else{
            return NO;
        }
    }
    return NO;
}

#pragma mark - 代理
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    NSLog(@"%lu",(unsigned long)locations.count);
    
    CLLocation * location = locations.lastObject;
    
    // 经度
    CLLocationDegrees longitude = location.coordinate.longitude;
    NSString * longitudeStr = [NSString stringWithFormat:@"%f",longitude];
    
    // 纬度
    CLLocationDegrees latitude = location.coordinate.latitude;
    NSString * latitudeStr = [NSString stringWithFormat:@"%f",latitude];
   
    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f", longitude, latitude,location.altitude,location.course,location.speed);
    
    _runLoopOver = YES;
    
    _locationArr = @[longitudeStr,latitudeStr];

    //定位好以后 , 即执行关闭
    [manager stopUpdatingLocation];//不用的时候关闭更新位置服务
    
    
    
    
    //地理编码器解析地址
    /*
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            NSLog(@"%@",placemark.name);
            //获取城市
            NSString *city = placemark.locality;
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
            }
            // 位置名
            NSLog(@"name,%@",placemark.name);
            // 街道
            NSLog(@"thoroughfare,%@",placemark.thoroughfare);
            // 子街道
            NSLog(@"subThoroughfare,%@",placemark.subThoroughfare);
            // 市
            NSLog(@"locality,%@",placemark.locality);
            // 区
            NSLog(@"subLocality,%@",placemark.subLocality);
            // 国家
            NSLog(@"country,%@",placemark.country);
        }else if (error == nil && [placemarks count] == 0) {
            NSLog(@"No results were returned.");
        } else if (error != nil){
            NSLog(@"An error occurred = %@", error);
        }
    }];
    
     */
    
}

// 定位失误时触发
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
    //如果定位出错or用户关闭定位 - 回调空定位信息
    _runLoopOver = YES;
    
    _locationArr = @[@"",@""];
    
    //定位失败 , 即执行关闭
    [manager stopUpdatingLocation];//不用的时候关闭更新位置服务
}


@end
