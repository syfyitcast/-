//
//  MyPositionViewController.m
//  ZXProject
//
//  Created by 刘清 on 2018/4/11.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "MyPositionViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "UserLocationManager.h"

@interface MyPositionViewController ()<MAMapViewDelegate>

@property (nonatomic, strong) MAMapView *mapView;

@end

@implementation MyPositionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的位置";
    [self.view addSubview:self.mapView];
    self.mapView.centerCoordinate = [UserLocationManager sharedUserLocationManager].currentCoordinate;
    MAPointAnnotation *annotion = [[MAPointAnnotation alloc] init];
    annotion.coordinate = self.mapView.centerCoordinate;
    [self.mapView addAnnotation:annotion];
    self.mapView.delegate = self;
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAAnnotationView*annotationView = (MAAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil) {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.frame = CGRectMake(0, 0, 12.5, 27);
        annotationView.image = [UIImage imageNamed:@"annotionIcon"];
        return annotationView;
    }
    return nil;
}

- (MAMapView *)mapView{
    if (_mapView == nil) {
        _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
        _mapView.zoomLevel = 17.5;
    }
    return _mapView;
}







@end
