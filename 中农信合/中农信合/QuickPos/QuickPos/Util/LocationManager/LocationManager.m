//
//  LocationManager.m
//  QuickPos
//
//  Created by 胡丹 on 15/4/8.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "LocationManager.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


static LocationManager *locationManager;
@interface LocationManager()<CLLocationManagerDelegate>{
    
}
@property (nonatomic,strong)CLLocationManager *manager;
@property (nonatomic,copy)LocationCallback locationCallback;
@end

@implementation LocationManager
@synthesize manager;

+ (LocationManager*)instance{
    if (!locationManager) {
        locationManager = [[LocationManager alloc]init];
    }
    return locationManager;
}

- (instancetype)init{
    if (!self.manager) {
        self.manager = [[CLLocationManager alloc]init];
        self.manager.delegate = self;
        self.manager.desiredAccuracy  = kCLLocationAccuracyBest;
        self.manager.distanceFilter  = 1000;
    }
    return self;
}




- (void)startLocationManager:(LocationCallback)callback{
    self.locationCallback = callback;
    switch ([CLLocationManager authorizationStatus]) {
        case kCLAuthorizationStatusNotDetermined:
            //[self.manager requestWhenInUseAuthorization];
            break;
        case kCLAuthorizationStatusRestricted:
            
            break;
        case kCLAuthorizationStatusDenied:
            
            break;

        default:{
            if ([CLLocationManager locationServicesEnabled]) {
                [self.manager startUpdatingLocation];
            }
        }
            break;
    }
        
}


+ (void)stopLocationManager{
    if (locationManager.manager ) {
        [locationManager.manager stopUpdatingLocation];
    }
    
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocationCoordinate2D location = [(CLLocation*)[locations lastObject] coordinate];
    float longtitude = location.longitude;
    float latitude = location.latitude;
    self.locationCallback(longtitude,latitude);
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{

    
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if (status == kCLAuthorizationStatusNotDetermined) {
        //[self.manager requestWhenInUseAuthorization];
    }
}

@end
