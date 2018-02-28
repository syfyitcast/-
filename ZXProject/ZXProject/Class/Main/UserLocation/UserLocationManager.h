//
//  UserLocationManager.h
//  ZXProject
//
//  Created by Me on 2018/2/17.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface UserLocationManager : NSObject

@property (nonatomic, strong) CLLocation *currentLaction;
@property (nonatomic, assign) CLLocationCoordinate2D currentCoordinate;

+ (instancetype)sharedUserLocationManager;


- (void)getUserLocation;

@end
