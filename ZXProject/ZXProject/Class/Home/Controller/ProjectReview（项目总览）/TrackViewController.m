//
//  TrackViewController.m
//  ZXProject
//
//  Created by Me on 2018/5/7.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "TrackViewController.h"
#import <MAMapKit/MAMapKit.h>

@interface TrackViewController ()

@property (nonatomic, strong) MAMapView *mapView;

@end

@implementation TrackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"轨迹回放";
    [self setSubView];
}

- (void)setSubView{
    [self.view addSubview:self.mapView];
}

#pragma mark - setter && getter

- (MAMapView *)mapView{
    if (_mapView == nil) {
        _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    }
    return _mapView;
}


@end
