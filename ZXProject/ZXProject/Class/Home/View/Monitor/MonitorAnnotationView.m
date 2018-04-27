//
//  MonitorAnnotationView.m
//  ZXProject
//
//  Created by 刘清 on 2018/4/26.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "MonitorAnnotationView.h"
#import <UIImageView+WebCache.h>

@interface MonitorAnnotationView()

@property (nonatomic, strong) UIImageView *iconView;

@end

@implementation MonitorAnnotationView

+ (instancetype)monitorAnnotationViewWithFrame:(CGRect)frame{
    MonitorAnnotationView *view = [[MonitorAnnotationView alloc] initWithFrame:frame];
    [view setSubViews];
    return view;
}

+ (instancetype)monitorAnnotationViewWithAnnotation:(MAPointAnnotation *)ann andMapView:(MAMapView *)mapView{
    static NSString *ID = @"MonitorAnnotationView";
    MonitorAnnotationView *view = (MonitorAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    if (view == nil) {
        view = [[MonitorAnnotationView alloc] initWithAnnotation:ann reuseIdentifier:ID];
    }
    return view;
}

- (void)setSubViews{
    self.iconView = [[UIImageView alloc] init];
    self.iconView.frame = self.bounds;
    [self addSubview:self.iconView];
}


- (void)setIconImage:(UIImage *)iconImage{
    _iconImage = iconImage;
    self.iconView.image = iconImage;
}

- (void)setUrl:(NSString *)url{
    _url = url;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.image = image;
    }];
}

#pragma mark - setter && getter

- (UIImageView *)iconView{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}

@end
