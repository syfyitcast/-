//
//  UserLocationManager.m
//  ZXProject
//
//  Created by Me on 2018/2/17.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "UserLocationManager.h"
#import <UIKit/UIKit.h>

@interface UserLocationManager()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *manager;


@end

@implementation UserLocationManager

+ (instancetype)sharedUserLocationManager{
    static UserLocationManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[UserLocationManager alloc] init];
        instance.manager = [[CLLocationManager alloc] init];
        instance.manager.delegate = instance;
    });
    return instance;
}

- (void)getUserLocation{
    if ([CLLocationManager locationServicesEnabled]) {
        [self.manager requestAlwaysAuthorization];
        [self.manager requestWhenInUseAuthorization];
        self.manager.desiredAccuracy = kCLLocationAccuracyBest;
        self.manager.distanceFilter = 5.0;
        [self.manager startUpdatingLocation];
    }
}

#pragma mark - CLLocationManagerDelegateMethod

//定位失败后调用此代理方法
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    //设置提示提醒用户打开定位服务
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"允许定位提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:nil];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *currentLocation = locations.lastObject;
    NSLog(@"经纬度: la = %f , lng = %f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    self.currentLaction = currentLocation;
    self.currentCoordinate = self.currentLaction.coordinate;
}

@end
