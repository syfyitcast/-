//
//  DeviceCollectionController.m
//  ZXProject
//
//  Created by 刘清 on 2018/4/20.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "DeviceCollectionController.h"
#import "DeviceCollectionView.h"
#import "UserLocationManager.h"
#import "GobHeaderFile.h"

@interface DeviceCollectionController ()

@property (nonatomic, strong) DeviceCollectionView *collectionView;

@end

@implementation DeviceCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设备采集";
    self.collectionView.frame = self.view.bounds;
    [self setPositionAdress];
    [self.view addSubview:self.collectionView];
}

- (void)setPositionAdress{
    if ([UserLocationManager sharedUserLocationManager].positionAdress != nil) {
        ZXHIDE_LOADING;
        [self.collectionView  setPositionAdress:[UserLocationManager sharedUserLocationManager].positionAdress];
    }else{
        [[UserLocationManager sharedUserLocationManager] reverseGeocodeLocationWithAdressBlock:^(NSDictionary *addressDic) {
            ZXHIDE_LOADING;
            NSString *state=[addressDic objectForKey:@"State"];
            NSString *city=[addressDic objectForKey:@"City"];
            NSString *subLocality=[addressDic objectForKey:@"SubLocality"];
            NSString *street=[addressDic objectForKey:@"Street"];
            [self.collectionView  setPositionAdress:[NSString stringWithFormat:@"%@%@%@%@",state,city, subLocality, street]];
        }];
    }
}


#pragma mark - setter && getter

- (DeviceCollectionView *)collectionView{
    if (_collectionView == nil) {
        _collectionView = [DeviceCollectionView deviceCollectionView];
    }
    return _collectionView;
}

@end
