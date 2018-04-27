//
//  MonitorAnnotationView.h
//  ZXProject
//
//  Created by 刘清 on 2018/4/26.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface MonitorAnnotationView : MAAnnotationView

@property (nonatomic, strong) UIImage *iconImage;
@property (nonatomic, copy) NSString *url;

+ (instancetype)monitorAnnotationViewWithFrame:(CGRect)frame;

+ (instancetype)monitorAnnotationViewWithAnnotation:(MAPointAnnotation *)ann andMapView:(MAMapView *)mapView;

@end
