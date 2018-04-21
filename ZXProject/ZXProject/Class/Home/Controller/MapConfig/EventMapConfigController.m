//
//  EventMapConfigController.m
//  ZXProject
//
//  Created by 刘清 on 2018/4/17.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "EventMapConfigController.h"
#import "SearchBar.h"
#import <MAMapKit/MAMapKit.h>
#import "ProjectManager.h"
#import "WorkTaskModel.h"
#import "ZXPointAnnotation.h"

@interface EventMapConfigController ()<MAMapViewDelegate>

@property (nonatomic, strong) SearchBar *searchBar;
@property (nonatomic, strong) MAMapView *mapView;


@end

@implementation EventMapConfigController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleStr;
    [self setSubViews];
    [self setConfigAnnation];
}

- (void)setConfigAnnation{
    NSMutableArray *tem_arr = [NSMutableArray array];
    for (WorkTaskModel *model in self.dataSource_arr) {
        ZXPointAnnotation *point = [[ZXPointAnnotation alloc] init];
        point.coordinate = CLLocationCoordinate2DMake(model.positionlat, model.positionlon);
        point.status = model.taskstatus;
        [tem_arr addObject:point];
    }
    [self.mapView addAnnotations:tem_arr.mutableCopy];
}

- (void)setSubViews{
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.mapView];
}

#pragma mark - MAMapViewDelegate Method

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    if ([annotation isKindOfClass:[ZXPointAnnotation class]]) {
        ZXPointAnnotation *ann = (ZXPointAnnotation *)annotation;
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAAnnotationView*annotationView = (MAAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil) {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        NSString *imageName = nil;
        switch (self.type) {
            case MapConfigTypeTask:
                if (ann.status == 0) {
                    imageName = @"mapConfigTaskUnfnish";
                }else if (ann.status == 2){
                    imageName = @"mapConfigTaskfnished";
                }
                break;
            default:
                break;
        }
        annotationView.image = [UIImage imageNamed:imageName];
        annotationView.canShowCallout = YES;
        return annotationView;
    }
    return nil;
}


#pragma mark - setter && getter

- (SearchBar *)searchBar{
    if (_searchBar == nil) {
        CGRect frame = CGRectMake(0, 0, self.view.width, 65);
        _searchBar = [SearchBar zx_SearchBarWithPlaceHolder:@"姓名" andFrame:frame andType:SearchBarTypeNormal andSearchBlock:^(NSString *macth) {
            
        }];
    }
    return _searchBar;
}

- (MAMapView *)mapView{
    if (_mapView == nil) {
        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 65, self.view.width, self.view.height - 65)];
        _mapView.centerCoordinate = CLLocationCoordinate2DMake([[ProjectManager sharedProjectManager].currentModel.positionlat doubleValue], [[ProjectManager sharedProjectManager].currentModel.positionlon doubleValue]);
        _mapView.zoomLevel = 12;
        _mapView.delegate = self;
    
    }
    return _mapView;
}


@end
