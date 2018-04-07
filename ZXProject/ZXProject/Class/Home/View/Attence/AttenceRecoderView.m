//
//  AttenceRecoderView.m
//  ZXProject
//
//  Created by Me on 2018/4/6.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "AttenceRecoderView.h"
#import "GobHeaderFile.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <Masonry.h>
#import <UIImageView+WebCache.h>

@interface AttenceRecoderView()

@property (nonatomic, strong) AttDutyCheckModel *model;
@property (nonatomic, assign) int type;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *positionLabel;
@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *bigImageBgView;

@property (nonatomic, assign) CGRect oldFrame;

@end

@implementation AttenceRecoderView

+ (instancetype)attenceRecoderViewWithModel:(AttDutyCheckModel *)model andType:(int)type{
    AttenceRecoderView *view = [[AttenceRecoderView alloc] init];
    [view setSubViews];
    view.type = type;
    view.model = model;
    return view;
}

- (void)setSubViews{
    __weak typeof(self) weakself = self;
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.mas_left).offset(15);
        make.top.equalTo(weakself.mas_top).offset(15);
        make.height.mas_equalTo(24);
    }];
    [self addSubview:self.statusLabel];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.titleLabel.mas_right).offset(40);
        make.centerY.equalTo(weakself.titleLabel.mas_centerY);
    }];
    [self addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.mas_left).offset(15);
        make.top.equalTo(weakself.titleLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(15);
    }];
    [self addSubview:self.positionLabel];
    [self.positionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.mas_left).offset(15);
        make.top.equalTo(weakself.timeLabel.mas_bottom).offset(10);
        make.right.equalTo(weakself.mas_right).offset(70);
        make.height.mas_equalTo(15);
    }];
    [self addSubview:self.mapView];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.mas_left).offset(15);
        make.right.equalTo(weakself.mas_right).offset(-15);
        make.top.equalTo(weakself.positionLabel.mas_bottom).offset(10);
        make.bottom.equalTo(weakself.mas_bottom).offset(-15);
    }];
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.mas_right).offset(-15);
        make.top.equalTo(weakself.mas_top).offset(15);
        make.bottom.equalTo(weakself.positionLabel.mas_bottom);
        make.width.mas_equalTo(60);
    }];
}

- (void)setModel:(AttDutyCheckModel *)model{
    _model = model;
    if (self.type == 1) {//上班打卡
        self.titleLabel.text = @"上班打卡";
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.beginphotourl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
             UITapGestureRecognizer *tapAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView)];
            [self.imageView addGestureRecognizer:tapAction];
        }];
        if (model.begintime == 0) {
            self.statusLabel.text = @"打卡状态: 无";
            self.timeLabel.text = @"时间:";
            self.positionLabel.text = @"位置:";
        }else{
            self.statusLabel.text = @"打卡状态: 正常";
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:model.begintime / 1000.0];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd  HH:mm:ss"];
            NSString *timeString = [formatter stringFromDate:date];
            self.timeLabel.text = [NSString stringWithFormat:@"时间:  %@",timeString];
            self.positionLabel.text = [NSString stringWithFormat:@"位置: %@",model.beginpositionaddress];
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(model.beginpositionlat, model.beginpositionlon);
            self.mapView.centerCoordinate = coordinate;
            MACoordinateSpan span = MACoordinateSpanMake(0.001, 0.001);
            MACoordinateRegion region = MACoordinateRegionMake(coordinate, span);
            [self.mapView setRegion:region animated:YES];
        }
    }else if(self.type == 2){
        self.titleLabel.text = @"下班打卡";
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.endphotourl]  completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            UITapGestureRecognizer *tapAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView)];
            [self.imageView addGestureRecognizer:tapAction];
        }];
        if (model.endtime == 0) {
            self.statusLabel.text = @"打卡状态: 无";
            self.timeLabel.text = @"时间:";
            self.positionLabel.text = @"位置:";
        }else{
            self.statusLabel.text = @"打卡状态: 正常";
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:model.endtime / 1000.0];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd  HH:mm:ss"];
            NSString *timeString = [formatter stringFromDate:date];
            self.timeLabel.text = [NSString stringWithFormat:@"时间:  %@",timeString];
            self.positionLabel.text = [NSString stringWithFormat:@"位置: %@",model.endpositionaddress];
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(model.endpositionlat, model.endpositionlon);
            MACoordinateSpan span = MACoordinateSpanMake(0.001, 0.001);
            MACoordinateRegion region = MACoordinateRegionMake(coordinate, span);
            [self.mapView setRegion:region animated:YES];
        }
    }
    
}

- (void)clickBtn{
    [self.bigImageBgView removeFromSuperview];
    self.bigImageBgView = nil;
}

- (void)tapImageView{
    self.oldFrame = self.imageView.frame;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.bigImageBgView.frame = window.bounds;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.imageView.image];
    imageView.x = 0;
    imageView.y = 50;
    imageView.width = self.bigImageBgView.width;
    imageView.height = self.bigImageBgView.height - 100;
    [self.bigImageBgView addSubview:imageView];
    [window addSubview:self.bigImageBgView];
}

#pragma mark - setter && getter

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _titleLabel.textColor = BlackColor;
    }
    return _titleLabel;
}

- (UILabel *)statusLabel{
    if (_statusLabel == nil) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.font =  [UIFont systemFontOfSize:14];
        _statusLabel.textColor = UIColorWithFloat(98);
    }
    return _statusLabel;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.textColor = UIColorWithFloat(98);
    }
    return _timeLabel;
}

- (UILabel *)positionLabel{
    if (_positionLabel == nil) {
        _positionLabel = [[UILabel alloc] init];
        _positionLabel.font = [UIFont systemFontOfSize:14];
        _positionLabel.textColor = UIColorWithFloat(98);
    }
    return _positionLabel;
}

- (MAMapView *)mapView{
    if (_mapView == nil) {
        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, self.width - 30, 200)];
    }
    return _mapView;
}

- (UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}

- (UIButton *)bigImageBgView{
    if (_bigImageBgView == nil) {
        _bigImageBgView = [[UIButton alloc] init];
        _bigImageBgView.backgroundColor = BlackColor;
        [_bigImageBgView addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bigImageBgView;
}

@end
