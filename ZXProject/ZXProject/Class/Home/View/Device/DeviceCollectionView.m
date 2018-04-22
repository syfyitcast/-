//
//  DeviceCollectionView.m
//  ZXProject
//
//  Created by 刘清 on 2018/4/20.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "DeviceCollectionView.h"
#import "WorkTaskAddImagePickView.h"
#import "GobHeaderFile.h"
#import <MAMapKit/MAMapKit.h>
#import <Masonry.h>
#import "UserLocationManager.h"


@interface DeviceCollectionView()<MAMapViewDelegate,WorkTaskAddImagePickViewDelegate>

@property (nonatomic, strong) WorkTaskAddImagePickView *pickView;

@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceTypeLabel;
@property (weak, nonatomic) IBOutlet UIView *lineImage;
@property (nonatomic, strong) FButton *saveBtn;
@property (nonatomic, strong) FButton *submitBtn;

@property (nonatomic, strong) MAMapView *mapView;

@end

@implementation DeviceCollectionView

+ (instancetype)deviceCollectionView{
    return [[NSBundle mainBundle] loadNibNamed:@"DeviceCollectionView" owner:nil options:nil].lastObject;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.positionLabel.numberOfLines = 0;
    [self addSubview:self.pickView];
     __weak typeof(self)  weakself = self;
    [self.pickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakself);
        make.top.equalTo(weakself.lineImage.mas_bottom);
        make.height.mas_equalTo(100);
    }];
    [self addSubview:self.mapView];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakself);
        make.top.equalTo(weakself.positionLabel.mas_bottom).offset(10);
        make.bottom.equalTo(weakself.mas_bottom);
    }];
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = [UserLocationManager sharedUserLocationManager].currentCoordinate;
    [self.mapView addAnnotation:pointAnnotation];
    [self addSubview:self.saveBtn];
    [self addSubview:self.submitBtn];
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.mas_left).offset(60);
        make.bottom.equalTo(weakself.mas_bottom).offset(-15);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.mas_right).offset(-60);
        make.bottom.equalTo(weakself.mas_bottom).offset(-15);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
}

- (void)setPositionAdress:(NSString *)positionAdress{
    self.positionLabel.text = positionAdress;
}

- (void)setDeviceDict:(NSDictionary *)deviceDict{
    self.deviceTypeLabel.text = deviceDict[@"dataname"];
}

- (IBAction)clickTag:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self clickAction:sender];
}

- (void)clickAction:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(deviceCollectionViewDidClickBtnTag:)]) {
        [self.delegate deviceCollectionViewDidClickBtnTag:btn];
    }
}

- (void)getPickImage:(UIImage *)image{
    [self.pickView getImage:image];
}

- (NSArray *)getImages{
    return [self.pickView images];
}

#pragma mark - workPickImageViewDelegate Method

- (void)WorkTaskAddImagePickViewDidTapImageView{
    UIButton *btn = [[UIButton alloc] init];
    btn.tag = 100;
    [self clickAction:btn];
}

#pragma mark - MAMapViewDelegate

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


#pragma mark- setter && getter

- (WorkTaskAddImagePickView *)pickView{
    if (_pickView == nil) {
        _pickView = [WorkTaskAddImagePickView workTaskAddImagePickViewWithFrame:CGRectMake(0, 0, self.width, 100)];
        _pickView.delegate = self;
    }
    return _pickView;
}

- (MAMapView *)mapView{
    if (_mapView == nil) {
        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, self.width, 200)];
        _mapView.centerCoordinate = [UserLocationManager sharedUserLocationManager].currentCoordinate;
        _mapView.zoomLevel = 17.5;
        _mapView.delegate = self;
    }
    return _mapView;
}

- (FButton *)saveBtn{
    if (_saveBtn == nil) {
        _saveBtn = [FButton fbtnWithFBLayout:FBLayoutTypeTextFull andPadding:0];
        [_saveBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _saveBtn.backgroundColor = BTNBackgroudColor;
        _saveBtn.layer.cornerRadius = 5;
        [_saveBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _saveBtn.tag = 5;
    }
    return _saveBtn;
}

- (FButton *)submitBtn{
    if (_submitBtn == nil) {
        _submitBtn = [FButton fbtnWithFBLayout:FBLayoutTypeTextFull andPadding:0];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _submitBtn.backgroundColor = BTNBackgroudColor;
        _submitBtn.layer.cornerRadius = 6;
        [_submitBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _submitBtn.tag = 6;
    }
    return _submitBtn;
}

@end
