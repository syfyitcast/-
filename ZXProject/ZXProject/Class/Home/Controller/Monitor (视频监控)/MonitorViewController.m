//
//  MonitorViewController.m
//  ZXProject
//
//  Created by 刘清 on 2018/4/25.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "MonitorViewController.h"
#import "SearchBar.h"
#import "GobHeaderFile.h"
#import <MAMapKit/MAMapKit.h>
#import "MonitorSelectView.h"
#import "HttpClient+Monitor.h"
#import "ProjectManager.h"
#import "HttpClient+Device.h"
#import "UserLocationManager.h"
#import "MonitorAnnotationView.h"
#import "MonitorPointAnnotation.h"
#import "NetworkConfig.h"
#import "MonitorPersonInfoView.h"
#import <Masonry.h>
#import "MonitorDeviceInfoView.h"

@interface MonitorViewController ()<monitorSelectViewDelegate,MAMapViewDelegate>

@property (nonatomic, strong) SearchBar *searchBar;
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) MonitorSelectView *selectView;

@property (nonatomic, strong) NSArray *personInfoDicts;
@property (nonatomic, strong) NSArray *carInfoDicts;
@property (nonatomic, strong) NSArray *deviceInfoDict;

@property (nonatomic, strong) NSMutableArray *personInfoAns;
@property (nonatomic, strong) NSMutableArray *carInfoAns;
@property (nonatomic, strong) NSMutableArray *deviceInfoAns;

@property (nonatomic, assign) BOOL lower;
@property (nonatomic, assign) BOOL hasPersonIcon;
@property (nonatomic, assign) BOOL hasDeviceIcon;
@property (nonatomic, assign) BOOL hasCarIcon;

@property (nonatomic, strong) MonitorPersonInfoView *personInfoView;
@property (nonatomic, strong) MonitorDeviceInfoView *deviceInfoView;
@property (nonatomic, strong) MonitorPointAnnotation *selectedAnnotation;

@property (nonatomic, strong) UIView *currentView;
@property (nonatomic, strong) NSDictionary *deviceTypeDict;

@end

@implementation MonitorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"视频监控";
    [self setNetworkRequest];
}

- (void)setNetworkRequest{
    ZXSHOW_LOADING(self.view, @"加载中...");
    dispatch_group_t group = dispatch_group_create();
    // 队列
    dispatch_queue_t queue = dispatch_queue_create("zj", DISPATCH_QUEUE_CONCURRENT);
    // 将任务添加到队列和调度组
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{//人员
        [HttpClient zx_httpClientToGetProjectPersonInfoWithProjectid:@"55" andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {//employeelocation
            if (code == 0) {
                self.personInfoDicts = data[@"employeelocation"];
            }
            dispatch_group_leave(group);
        }];
    });
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        [HttpClient zx_httpClientToGetProjectCarInfoWithProjectid:@"55" andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
            if (code == 0) {//vehiclelocation
                self.carInfoDicts = data[@"vehiclelocation"];
            }
            dispatch_group_leave(group);
        }];
    });
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        [HttpClient zx_httpClientToGetProjectDeviceInfoWithProjectid:@"55" andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
            if (code == 0) {//facilitylocation
                self.deviceInfoDict = data[@"facilitylocation"];
            }
            dispatch_group_leave(group);
        }];
    });
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        [HttpClient zx_httpClientToGetDeviceTypeListWithSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
            if (code == 0) {
                self.deviceTypeDict = data[@"facilitytype"];
            }
             dispatch_group_leave(group);
        }];
    });
    
   
    // 异步 : 调度组中的所有异步任务执行结束之后,在这里得到统一的通知
    dispatch_queue_t mQueue = dispatch_get_main_queue();
    dispatch_group_notify(group, mQueue, ^{
        ZXHIDE_LOADING;
        [self setSubViews];
    });
}

- (void)setSubViews{
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.mapView];
    [self.view addSubview:self.selectView];
}

#pragma DelegateMethod

- (void)monitorSelectViewDidClickItem:(NSDictionary *)item{
    if ([item[@"title"] isEqualToString:@""]) {
        if (self.lower) {
            [UIView animateWithDuration:0.35 animations:^{
                self.selectView.x = self.view.width - 240;
            }];
            self.lower = NO;
        }else{
            [UIView animateWithDuration:0.35 animations:^{
                self.selectView.x = self.view.width - 60;
            }];
            self.lower = YES;
        }
    }else if([item[@"title"] isEqualToString:@"人员"]){
        if (self.hasPersonIcon) {
            [self.mapView removeAnnotations:self.personInfoAns];
            self.hasPersonIcon = NO;
        }else{
            if (self.personInfoAns.count != 0) {
                [self.mapView addAnnotations:self.personInfoAns];
                self.hasPersonIcon = YES;
                return;
            }
            for (NSDictionary *dict in self.personInfoDicts) {
                double lat = [dict[@"positionlat"] doubleValue];
                double lon = [dict[@"positionlon"] doubleValue];
                MonitorPointAnnotation *annotation = [[MonitorPointAnnotation alloc] init];
                annotation.coordinate = CLLocationCoordinate2DMake(lat, lon);
                annotation.type = 0;
                annotation.modelDict = dict;
                [self.personInfoAns addObject:annotation];
            }
            [self.mapView addAnnotations:self.personInfoAns];
            self.hasPersonIcon = YES;
        }
    }else if ([item[@"title"] isEqualToString:@"设施"]){
        if (self.hasDeviceIcon) {
            [self.mapView removeAnnotations:self.deviceInfoAns];
            self.hasDeviceIcon = NO;
        }else{
            if (self.deviceInfoAns.count != 0) {
                [self.mapView addAnnotations:self.deviceInfoAns];
                self.hasDeviceIcon = YES;
                return;
            }
            for (NSDictionary *dict in self.deviceInfoDict) {
                double lat = [dict[@"positionlat"] doubleValue];
                double lon = [dict[@"positionlon"] doubleValue];
                MonitorPointAnnotation *annotation = [[MonitorPointAnnotation alloc] init];
                annotation.coordinate = CLLocationCoordinate2DMake(lat, lon);
                annotation.type = 1;
                annotation.modelDict = dict;
                [self.deviceInfoAns addObject:annotation];
            }
            [self.mapView addAnnotations:self.deviceInfoAns];
            self.hasDeviceIcon = YES;
        }
    }else if ([item[@"title"] isEqualToString:@"车辆"]){
        if (self.hasCarIcon) {
            [self.mapView removeAnnotations:self.carInfoAns];
            self.hasCarIcon = NO;
        }else{
            if (self.carInfoAns.count != 0) {
                [self.mapView addAnnotations:self.carInfoAns];
                self.hasCarIcon = YES;
                return;
            }
            for (NSDictionary *dict in self.carInfoDicts) {
                double lat = [dict[@"positionlat"] doubleValue];
                double lon = [dict[@"positionlon"] doubleValue];
                MonitorPointAnnotation *annotation = [[MonitorPointAnnotation alloc] init];
                annotation.coordinate = CLLocationCoordinate2DMake(lat, lon);
                annotation.type = 2;
                annotation.modelDict = dict;
                [self.carInfoAns addObject:annotation];
            }
            [self.mapView addAnnotations:self.carInfoAns];
            self.hasCarIcon = YES;
        }
    }
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    if ([annotation isKindOfClass:[MonitorPointAnnotation class]]) {
        MonitorPointAnnotation *ann = (MonitorPointAnnotation *)annotation;
        MonitorAnnotationView *annotationView = [MonitorAnnotationView monitorAnnotationViewWithAnnotation:ann andMapView:mapView];
        annotationView.frame = CGRectMake(0, 0, 12.5, 27);
        NSString *imageName = nil;
        if (ann.type == 0) {
            if ([ann.modelDict[@"userrank"] isEqualToString:@"主管"]) {
                imageName = @"zgIcon";
            }else if ([ann.modelDict[@"userrank"] isEqualToString:@"经理"]){
                imageName = @"jlIcon";
            }else if ([ann.modelDict[@"userrank"] isEqualToString:@"司机"]){
                imageName = @"sjIcon";
            }else if ([ann.modelDict[@"userrank"] isEqualToString:@"副经理"]){
                imageName = @"fjlIcon";
            }else{
                imageName = @"qtIcon";
            }
        }else if (ann.type == 1){//设备
            NSString *url = [[NetworkConfig sharedNetworkingConfig].ipUrl stringByAppendingString:[NSString stringWithFormat:@"/hjwulian%@",ann.modelDict[@"icon"]]];
            [annotationView setUrl:url];
            return annotationView;
        }else if (ann.type == 2){//车辆
            
        }
        annotationView.image = [UIImage imageNamed:imageName];
        return annotationView;
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{
    MonitorPointAnnotation *ann = (MonitorPointAnnotation *)view.annotation;
    if (self.selectedAnnotation == ann) return;
    if (self.selectedAnnotation != nil) {
        [self.mapView deselectAnnotation:self.selectedAnnotation animated:YES];
        [self.currentView removeFromSuperview];
    }
    self.selectedAnnotation = ann;
    if (ann.type == 0) {//人员
        MonitorPersonInfoView *infoView = [MonitorPersonInfoView monitorPersonInfoView];
        [self.view addSubview:infoView];
         __weak typeof(self)  weakself = self;
        [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakself.view.mas_left).offset(10);
            make.right.equalTo(weakself.view.mas_right).offset(-10);
            make.bottom.equalTo(weakself.view.mas_bottom).offset(-15);
            make.height.mas_equalTo(192);
        }];
        [infoView.closeBtn addTarget:self action:@selector(clickCloseBtn) forControlEvents:UIControlEventTouchUpInside];
        self.personInfoView = infoView;
        infoView.dict = ann.modelDict;
        self.currentView = infoView;
    }else if (ann.type == 1){//设备
        MonitorDeviceInfoView *infoView = [MonitorDeviceInfoView monitorDeviceInfoView];
        [self.view addSubview:infoView];
        __weak typeof(self)  weakself = self;
        [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakself.view.mas_left).offset(10);
            make.right.equalTo(weakself.view.mas_right).offset(-10);
            make.bottom.equalTo(weakself.view.mas_bottom).offset(-15);
            make.height.mas_equalTo(160);
        }];
        [infoView.closeBtn addTarget:self action:@selector(clickCloseBtn) forControlEvents:UIControlEventTouchUpInside];
        self.deviceInfoView = infoView;
        infoView.dict = ann.modelDict;
        self.currentView = infoView;
    }
}

#pragma mark - Action

- (void)clickCloseBtn{
    [self.personInfoView removeFromSuperview];
    [self.deviceInfoView removeFromSuperview];
    [self.mapView deselectAnnotation:self.selectedAnnotation animated:YES];
    self.selectedAnnotation = nil;
}

#pragma mark - setter && getter

- (SearchBar *)searchBar{
    if (_searchBar == nil) {
        _searchBar = [SearchBar zx_SearchBarWithPlaceHolder:@"职员姓名" andFrame:CGRectMake(0, 0, self.view.width, 60) andType:SearchBarTypeNormal andSearchBlock:^(NSString *macth) {
            
        }];
    }
    return _searchBar;
}

- (MAMapView *)mapView{
    if (_mapView == nil) {
        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 60, self.view.width, self.view.height - 60)];
        _mapView.centerCoordinate = [UserLocationManager sharedUserLocationManager].currentCoordinate;
        _mapView.delegate = self;
        
    }
    return _mapView;
}

- (MonitorSelectView *)selectView{
    if (_selectView == nil) {
        NSArray *items = @[@{
                               @"title":@"",
                               @"imageName":@"rightArrow"
                               },@{
                               @"title":@"人员",
                               @"imageName":@"monitorPersonIcon"
                               },
                               @{
                               @"title":@"车辆",
                               @"imageName":@"monitorCarIcon"
                               },
                              @{
                               @"title":@"设施",
                               @"imageName":@"monitorDeviceIcon"
                               },
                           ];
        _selectView = [MonitorSelectView monitorSelectViewWithFrame:CGRectMake(self.view.width - 240,self.view.height - 250, 240, 30) andItems:items];
        _selectView.delegate = self;
    }
    return _selectView;
}

- (NSMutableArray *)personInfoAns{
    if (_personInfoAns == nil) {
        _personInfoAns = [NSMutableArray array];
    }
    return _personInfoAns;
}

- (NSMutableArray *)carInfoAns{
    if (_carInfoAns == nil) {
        _carInfoAns = [NSMutableArray array];
    }
    return _carInfoAns;
}

- (NSMutableArray *)deviceInfoAns{
    if (_deviceInfoAns == nil) {
        _deviceInfoAns = [NSMutableArray array];
    }
    return _deviceInfoAns;
}

@end
