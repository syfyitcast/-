//
//  ProjectReviewDetailViewController.m
//  ZXProject
//
//  Created by Me on 2018/5/9.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "ProjectReviewDetailViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "ProjectReviewPersonDetailView.h"
#import <Masonry.h>
#import "ProjectReviewCarInfoView.h"

@interface ProjectReviewDetailViewController ()<MAMapViewDelegate>

@property (nonatomic, strong) MAMapView *mapView;

@end

@implementation ProjectReviewDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mapView];
    double lat = [self.modelDict[@"positionlat"] doubleValue];
    double lon = [self.modelDict[@"positionlon"] doubleValue];
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(lat, lon);
    self.mapView.centerCoordinate = location;
    [self setSubViews];
}

- (void)setSubViews{
    __weak typeof(self) weakself = self;
    if (self.type == 0) {//人员详情
        ProjectReviewPersonDetailView *personView = [ProjectReviewPersonDetailView projectReviewPersonDetailView];
        personView.modelDict = self.modelDict;
        [self.view addSubview:personView];
        [personView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.top.equalTo(weakself.view);
            make.height.mas_equalTo(137);
        }];
    }else if (self.type == 1){//车辆详情
        ProjectReviewCarInfoView *carView = [ProjectReviewCarInfoView projectReviewCarInfoView];
        carView.modelDict = self.modelDict;
        [self.view addSubview:carView];
        [carView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.top.equalTo(weakself.view);
            make.height.mas_equalTo(122);
        }];
    }else if (self.type == 2){//设备详情
        
    }
}

- (MAMapView *)mapView{
    if (_mapView == nil) {
        _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
        _mapView.delegate = self;
        _mapView.zoomLevel = 15;
    }
    return _mapView;
}



@end
