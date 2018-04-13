//
//  UserLocationManager.m
//  ZXProject
//
//  Created by Me on 2018/2/17.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "UserLocationManager.h"
#import <UIKit/UIKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "NOTIFICATION_HEADER.h"


@interface UserLocationManager()<AMapLocationManagerDelegate>

@property (nonatomic, strong) AMapLocationManager *manager;
@property (nonatomic, assign) BOOL hasUpdateLocation;



@end

@implementation UserLocationManager

+ (instancetype)sharedUserLocationManager{
    static UserLocationManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[UserLocationManager alloc] init];
        instance.manager = [[AMapLocationManager alloc] init];
        instance.manager.delegate = instance;
    });
    return instance;
}

- (void)getUserLocation{
    self.manager.distanceFilter = 20.0;
    [self.manager startUpdatingLocation];
    [self.manager setLocatingWithReGeocode:YES];
}

- (void)reverseGeocodeLocationWithAdressBlock:(void(^)(NSDictionary *))adressBlock{
    CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];
    [clGeoCoder reverseGeocodeLocation:self.currentLaction completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placemark = placemarks.lastObject;
        NSDictionary *addressDic = placemark.addressDictionary;
        if (adressBlock) {
            adressBlock(addressDic);
        }
    }];
}

#pragma mark - CLLocationManagerDelegateMethod

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    
    CLLocation *currentLocation = location;
    NSLog(@"经纬度: la = %f , lng = %f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    self.currentLaction = currentLocation;
    self.currentCoordinate = self.currentLaction.coordinate;
    self.position = [NSString stringWithFormat:@"%f,%f",currentLocation.coordinate.longitude,currentLocation.coordinate.latitude];
    
    if (reGeocode)
    {
        self.positionAdress = reGeocode.formattedAddress;
        self.city = reGeocode.city;
        if (self.hasUpdateLocation == NO) {
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFI_GETLOCATIONINFO object:nil];
            self.hasUpdateLocation = YES;
        }
       
    }else{
        CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];
        [clGeoCoder reverseGeocodeLocation:self.currentLaction completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            CLPlacemark *placemark = placemarks.lastObject;
            NSDictionary *addressDic = placemark.addressDictionary;
            self.city = addressDic[@"City"];
            if (self.hasUpdateLocation == NO) {
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFI_GETLOCATIONINFO object:nil];
                self.hasUpdateLocation = YES;
            }
        }];
    }
}

- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error{
    //设置提示提醒用户打开定位服务
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"允许定位提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:nil];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:okAction];
    [alert addAction:cancelAction];
}

#pragma mark - setter && getter

- (NSString *)position{
    if (_position == nil) {
        return @"长沙";
    }else{
        return _position;
    }
}

- (NSString *)city{
    if (_city == nil) {
        return @"";
    }else{
        return _city;
    }
}

@end
