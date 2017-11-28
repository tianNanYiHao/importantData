//
//  ViewController.m
//  coreLocation
//
//  Created by tianNanYiHao on 2017/11/28.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>
/**
 定位服务管理类
 */
@property (nonatomic, strong) CLLocationManager *locationManager;

/**
 地理编码器
 */
@property (nonatomic, strong) CLGeocoder *geocoder;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.locationManager = [[CLLocationManager alloc] init];
    //[self.locationManager requestWhenInUseAuthorization]; //App在前台时调用
    [self.locationManager requestAlwaysAuthorization]; //App在前后台时均调用
    //iOS8必须，这两行必须有一行执行，否则无法获取位置信息，和定位
    
    self.locationManager.delegate = self;
    
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest; //定位精确到米
    
    self.locationManager.distanceFilter = kCLDistanceFilterNone; //设置过滤器为无
    
    [self.locationManager startUpdatingLocation]; //开始定位 - 之后会不断的执行代理方法更新位置会比较费电所以建议获取完位置即时关闭更新位置服务
    
    self.geocoder = [[CLGeocoder alloc] init];  //初始化地理编码器

    
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    NSLog(@"%lu",(unsigned long)locations.count);
    CLLocation * location = locations.lastObject;
    // 纬度
    CLLocationDegrees latitude = location.coordinate.latitude;
    // 经度
    CLLocationDegrees longitude = location.coordinate.longitude;
    
    NSLog(@"%@",[NSString stringWithFormat:@"%lf", location.coordinate.longitude]);
    
    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f", location.coordinate.longitude, location.coordinate.latitude,location.altitude,location.course,location.speed);
    
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
    //    [manager stopUpdatingLocation];不用的时候关闭更新位置服务
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
