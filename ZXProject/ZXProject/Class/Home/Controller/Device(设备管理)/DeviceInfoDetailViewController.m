//
//  DeviceInfoDetailViewController.m
//  ZXProject
//
//  Created by 刘清 on 2018/4/23.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "DeviceInfoDetailViewController.h"
#import "GobHeaderFile.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "UserLocationManager.h"
#import <MAMapKit/MAMapKit.h>
#import "CGXPickerView.h"
#import "HttpClient+Device.h"


@interface DeviceInfoDetailViewController ()<MAMapViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) NSArray *models;

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UITextField  *deviceCodeFiled;
@property (nonatomic, strong) UITextField *deviceNameFiled;
@property (nonatomic, strong) UITextField *deviceTypeFiled;
@property (nonatomic, strong) UITextField *deviceStatusFiled;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *positionLabel;
@property (nonatomic, strong) UIButton *reCollectionBtn;
@property (nonatomic, strong) UIImageView *mapIcon;

@property (nonatomic, strong) UIButton *isFoucsBtn;
@property (nonatomic, strong) UIButton *isVideoBtn;
@property (nonatomic, strong) UIButton *isPublicBtn;

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) UITextView *remarkView;

@property (nonatomic, assign) int workStatus;
@property (nonatomic, copy) NSString *typeCode;

@property (nonatomic, strong) FButton *saveBtn;
@property (nonatomic, strong) FButton *submitBtn;

@property (nonatomic, assign) CLLocationCoordinate2D location;

@end

@implementation DeviceInfoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设施详情";
    self.workStatus = self.model.workstatus;
    self.location = CLLocationCoordinate2DMake([self.model.positionlat doubleValue], [self.model.positionlon doubleValue]);
    [self setNetworkRequest];
}

- (void)setNetworkRequest{
    ZXSHOW_LOADING(self.view, @"加载中...");
    [HttpClient zx_httpClientToGetDeviceTypeListWithSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
        if (code == 0) {
            self.models = data[@"facilitytype"];
            [self setSubViews];
        }else{
            if (message.length != 0) {
                [MBProgressHUD showError:message toView:self.view];
            }
        }
    }];
}

- (void)setSubViews{
    UIScrollView *mainScorllView = [[UIScrollView alloc] init];
    mainScorllView.backgroundColor = WhiteColor;
    mainScorllView.bounces = NO;
    mainScorllView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mainScorllView];
     __weak typeof(self)  weakself = self;
    [mainScorllView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakself.view);
    }];
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = WhiteColor;
    [mainScorllView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(mainScorllView);
        make.width.equalTo(mainScorllView);
    }];
    [contentView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentView.mas_right).offset(-10);
        make.top.equalTo(contentView.mas_top).offset(10);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(100);
    }];
    UILabel *deviceNameLabel = [[UILabel alloc] init];
    deviceNameLabel.text = @"设施名称:";
    deviceNameLabel.font = [UIFont systemFontOfSize:14];
    deviceNameLabel.textColor = BlackColor;
    [contentView addSubview:deviceNameLabel];
    [deviceNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(15);
        make.top.equalTo(contentView.mas_top).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    [contentView addSubview:self.deviceNameFiled];
    [self.deviceNameFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(deviceNameLabel.mas_right).offset(10);
        make.centerY.equalTo(deviceNameLabel.mas_centerY);
        make.right.equalTo(weakself.iconImageView.mas_left).offset(-25);
    }];
    UIView *lineView_0 = [[UIView alloc] init];
    lineView_0.backgroundColor =  UIColorWithFloat(239);
    [contentView addSubview:lineView_0];
    [lineView_0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left);
        make.top.equalTo(deviceNameLabel.mas_bottom).offset(10);
        make.right.equalTo(self.iconImageView.mas_left).offset(-10);
        make.height.mas_equalTo(1);
    }];
    UILabel *deviceCodeLabel = [[UILabel alloc] init];
    deviceCodeLabel.text = @"设备编码:";
    deviceCodeLabel.font = [UIFont systemFontOfSize:14];
    deviceCodeLabel.textColor = BlackColor;
    [contentView addSubview:deviceCodeLabel];
    [deviceCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(15);
        make.top.equalTo(lineView_0.mas_top).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    [contentView addSubview:self.deviceCodeFiled];
    [self.deviceCodeFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(deviceCodeLabel.mas_right).offset(10);
        make.centerY.equalTo(deviceCodeLabel.mas_centerY);
        make.right.equalTo(weakself.iconImageView.mas_left).offset(-25);
    }];
    UIView *lineView_other = [[UIView alloc] init];
    lineView_other.backgroundColor =  UIColorWithFloat(239);
    [contentView addSubview:lineView_other];
    [lineView_other mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left);
        make.top.equalTo(deviceCodeLabel.mas_bottom).offset(10);
        make.right.equalTo(self.iconImageView.mas_left).offset(-10);
        make.height.mas_equalTo(1);
    }];
    UILabel *deviceTypeLabel = [[UILabel alloc] init];
    deviceTypeLabel.text = @"设施类型:";
    deviceTypeLabel.font = [UIFont systemFontOfSize:14];
    deviceTypeLabel.textColor = BlackColor;
    [contentView addSubview:deviceTypeLabel];
    [deviceTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(15);
        make.top.equalTo(lineView_other.mas_top).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    [contentView addSubview:self.deviceTypeFiled];
    [self.deviceTypeFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(deviceTypeLabel.mas_right).offset(10);
        make.centerY.equalTo(deviceTypeLabel.mas_centerY);
    }];
    UIView *lineView_1 = [[UIView alloc] init];
    lineView_1.backgroundColor =  UIColorWithFloat(239);
    [contentView addSubview:lineView_1];
    [lineView_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left);
        make.top.equalTo(deviceTypeLabel.mas_bottom).offset(10);
        make.right.equalTo(contentView.mas_right);
        make.height.mas_equalTo(1);
    }];
    UILabel *deviceStatusLabel = [[UILabel alloc] init];
    deviceStatusLabel.text = @"设施状态:";
    deviceStatusLabel.font = [UIFont systemFontOfSize:14];
    deviceStatusLabel.textColor = BlackColor;
    [contentView addSubview:deviceStatusLabel];
    [deviceStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(15);
        make.top.equalTo(lineView_1.mas_top).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    [contentView addSubview:self.deviceStatusFiled];
    [self.deviceStatusFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(deviceTypeLabel.mas_right).offset(10);
        make.centerY.equalTo(deviceStatusLabel.mas_centerY);
    }];
    UIView *lineView_2 = [[UIView alloc] init];
    lineView_2.backgroundColor =  UIColorWithFloat(239);
    [contentView addSubview:lineView_2];
    [lineView_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left);
        make.top.equalTo(deviceStatusLabel.mas_bottom).offset(10);
        make.right.equalTo(contentView.mas_right);
        make.height.mas_equalTo(1);
    }];
    UILabel *timeDesLabel = [[UILabel alloc] init];
    timeDesLabel.text = @"采集时间:";
    timeDesLabel.font = [UIFont systemFontOfSize:14];
    timeDesLabel.textColor = BlackColor;
    [contentView addSubview:timeDesLabel];
    [timeDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(15);
        make.top.equalTo(lineView_2.mas_top).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    [contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeDesLabel.mas_right).offset(10);
        make.centerY.equalTo(timeDesLabel.mas_centerY);
    }];
    UIView *lineView_3 = [[UIView alloc] init];
    lineView_3.backgroundColor =  UIColorWithFloat(239);
    [contentView addSubview:lineView_3];
    [lineView_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left);
        make.top.equalTo(timeDesLabel.mas_bottom).offset(10);
        make.right.equalTo(contentView.mas_right);
        make.height.mas_equalTo(1);
    }];
    UILabel *positionDesLabel = [[UILabel alloc] init];
    positionDesLabel.text = @"采集位置:";
    positionDesLabel.font = [UIFont systemFontOfSize:14];
    positionDesLabel.textColor = BlackColor;
    [contentView addSubview:positionDesLabel];
    [positionDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(15);
        make.top.equalTo(lineView_3.mas_top).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    [contentView addSubview:self.positionLabel];
    [self.positionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(positionDesLabel.mas_right).offset(10);
        make.centerY.equalTo(positionDesLabel.mas_centerY);
        make.width.mas_equalTo(140);
    }];
    UIView *lineView_4 = [[UIView alloc] init];
    lineView_4.backgroundColor =  UIColorWithFloat(239);
    [contentView addSubview:lineView_4];
    [lineView_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left);
        make.top.equalTo(positionDesLabel.mas_bottom).offset(10);
        make.right.equalTo(contentView.mas_right);
        make.height.mas_equalTo(1);
    }];
    [contentView addSubview:self.reCollectionBtn];
    [self.reCollectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentView.mas_right).offset(-15);
        make.centerY.equalTo(positionDesLabel.mas_centerY);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(25);
    }];
    [contentView addSubview:self.mapIcon];
    [self.mapIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.reCollectionBtn.mas_left).offset(-15);
        make.centerY.equalTo(weakself.reCollectionBtn.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(13, 19));
    }];
    UILabel *foucsLabel = [[UILabel alloc] init];
    foucsLabel.text = @"重点关注:";
    foucsLabel.font = [UIFont systemFontOfSize:14];
    foucsLabel.textColor = BlackColor;
    [contentView addSubview:foucsLabel];
    [foucsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(15);
        make.top.equalTo(lineView_4.mas_top).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    [contentView addSubview:self.isFoucsBtn];
    [self.isFoucsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(foucsLabel.mas_right).offset(10);
        make.centerY.equalTo(foucsLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    UIView *lineView_5 = [[UIView alloc] init];
    lineView_5.backgroundColor =  UIColorWithFloat(239);
    [contentView addSubview:lineView_5];
    [lineView_5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left);
        make.top.equalTo(foucsLabel.mas_bottom).offset(10);
        make.right.equalTo(contentView.mas_right);
        make.height.mas_equalTo(1);
    }];
    UILabel *videoLabel = [[UILabel alloc] init];
    videoLabel.text = @"视频监控:";
    videoLabel.font = [UIFont systemFontOfSize:14];
    videoLabel.textColor = BlackColor;
    [contentView addSubview:videoLabel];
    [videoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(15);
        make.top.equalTo(lineView_5.mas_top).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    [contentView addSubview:self.isVideoBtn];
    [self.isVideoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(videoLabel.mas_right).offset(10);
        make.centerY.equalTo(videoLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    UIView *lineView_6 = [[UIView alloc] init];
    lineView_6.backgroundColor =  UIColorWithFloat(239);
    [contentView addSubview:lineView_6];
    [lineView_6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left);
        make.top.equalTo(videoLabel.mas_bottom).offset(10);
        make.right.equalTo(contentView.mas_right);
        make.height.mas_equalTo(1);
    }];
    UILabel *publicLabel = [[UILabel alloc] init];
    publicLabel.text = @"公共设施:";
    publicLabel.font = [UIFont systemFontOfSize:14];
    publicLabel.textColor = BlackColor;
    [contentView addSubview:publicLabel];
    [publicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(15);
        make.top.equalTo(lineView_6.mas_top).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    [contentView addSubview:self.isPublicBtn];
    [self.isPublicBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(publicLabel.mas_right).offset(10);
        make.centerY.equalTo(publicLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    UIView *lineView_7 = [[UIView alloc] init];
    lineView_7.backgroundColor =  UIColorWithFloat(239);
    [contentView addSubview:lineView_7];
    [lineView_7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left);
        make.top.equalTo(publicLabel.mas_bottom).offset(10);
        make.right.equalTo(contentView.mas_right);
        make.height.mas_equalTo(1);
    }];
    UILabel *deslabel = [[UILabel alloc] init];
    deslabel.text = @"备注:";
    deslabel.font = [UIFont systemFontOfSize:14];
    deslabel.textColor = BlackColor;
    [contentView addSubview:deslabel];
    [deslabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(15);
        make.top.equalTo(lineView_7.mas_bottom).offset(15);
    }];
    [contentView addSubview:self.remarkView];
    [self.remarkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(15);
        make.right.equalTo(contentView.mas_right).offset(-15);
        make.top.equalTo(deslabel.mas_bottom).offset(10);
        make.height.mas_equalTo(100);
    }];
    [contentView addSubview:self.saveBtn];
    [contentView addSubview:self.submitBtn];
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(60);
        make.top.equalTo(self.remarkView.mas_bottom).offset(20);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(44);
    }];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentView.mas_right).offset(-60);
        make.top.equalTo(self.remarkView.mas_bottom).offset(20);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(44);
    }];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.submitBtn.mas_bottom).offset(30);
    }];
}

#pragma mark - Action
- (void)tapAction:(UITapGestureRecognizer *)tap{
    UIView *view = tap.view;
    NSArray *datasource = @[@"在用",@"停用",@"报废",@"维修"];
    if (view == self.deviceStatusFiled) {
        [CGXPickerView showStringPickerWithTitle:@"设备状态" DataSource:datasource DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
            self.workStatus = [selectRow intValue];
            NSString *holderText = (NSString *)selectValue;
            NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
            [placeholder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14 weight:UIFontWeightRegular] range:NSMakeRange(0, holderText.length)];
            _deviceStatusFiled.attributedPlaceholder = placeholder;
        }];
    }else if (view == self.deviceTypeFiled){
        NSMutableArray *tem_arr = [NSMutableArray array];
        for (NSDictionary *dict in self.models) {
            NSString *name = dict[@"dataname"];
            [tem_arr addObject:name];
        }
        [CGXPickerView showStringPickerWithTitle:@"设备类型" DataSource:tem_arr.mutableCopy DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
            NSString *holderText = (NSString *)selectValue;
            int index = [selectRow intValue];
            NSDictionary *dict = self.models[index];
            self.typeCode = dict[@"datacode"];
            NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
            [placeholder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14 weight:UIFontWeightRegular] range:NSMakeRange(0, holderText.length)];
            _deviceTypeFiled.attributedPlaceholder = placeholder;
        }];
    }
}

- (void)clickAction:(UIButton *)btn{
    if (btn.tag == 7) {//提交修改
        [HttpClient zx_httpClientToModifyFacilityWithFacilityid:self.model.facilityid andFacilityCode:self.deviceCodeFiled.text?self.deviceCodeFiled.text:self.model.facilitycode andFacilityname:self.deviceNameFiled.text?self.deviceNameFiled.text:self.model.facilityname  andFacilitytype:self.deviceTypeFiled.text?self.deviceTypeFiled.text:self.model.facilitytype  andWorkStatus:self.workStatus andPhotourl:self.model.photourl andPositionaddress:self.positionLabel.text andPositionlon:self.location.longitude andPositionlat:self.location.latitude andIsfocus:self.isFoucsBtn.selected andIsvideo:self.isVideoBtn.selected andIspublic:self.isPublicBtn.selected andRFIDtag:nil andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
            if (code == 0) {
                [MBProgressHUD showError:@"提交成功" toView:self.view];
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFI_DEVICEINFORELOADDATA object:nil];
                [self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:@(YES) afterDelay:1.2];
            }else{
                if (message.length != 0) {
                    [MBProgressHUD showError:message toView:self.view];
                }else{
                    [MBProgressHUD showError:@"提交失败" toView:self.view];
                }
            }
        }];
    }else if(btn.tag == 8){//取消
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)reCollectionAction:(UIButton *)btn{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.timeLabel.text = [formatter stringFromDate:date];
    self.positionLabel.text = [UserLocationManager sharedUserLocationManager].positionAdress;
    self.location = [UserLocationManager sharedUserLocationManager].currentCoordinate;
}

#pragma mark - UITextFiledDelegateMethod

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == self.deviceNameFiled) {
        self.deviceNameFiled.text = self.model.facilityname;
    }else if (textField == self.deviceCodeFiled){
        self.deviceCodeFiled.text = self.model.facilitycode;
    }
}

#pragma mark - setter && getter

- (UIImageView *)iconImageView{
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc] init];
        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:self.model.photoUrls.firstObject]];
    }
    return _iconImageView;
}

- (UITextField *)deviceCodeFiled{
    if (_deviceCodeFiled == nil) {
        _deviceCodeFiled = [[UITextField alloc] init];
        _deviceCodeFiled.textColor = UIColorWithFloat(199);
        _deviceCodeFiled.delegate = self;
        NSString *holderText = self.model.facilitycode;
        NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
        [placeholder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14 weight:UIFontWeightRegular] range:NSMakeRange(0, holderText.length)];
        _deviceCodeFiled.attributedPlaceholder = placeholder;
        _deviceCodeFiled.font = [UIFont systemFontOfSize:14];
        
    }
    return _deviceCodeFiled;
}

- (UITextField *)deviceNameFiled{
    if (_deviceNameFiled == nil) {
        _deviceNameFiled = [[UITextField alloc] init];
        _deviceNameFiled.textColor = UIColorWithFloat(199);
        _deviceNameFiled.delegate = self;
        NSString *holderText = self.model.facilityname ;
        NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
        [placeholder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14 weight:UIFontWeightRegular] range:NSMakeRange(0, holderText.length)];
        _deviceNameFiled.attributedPlaceholder = placeholder;
        _deviceNameFiled.font = [UIFont systemFontOfSize:14];
    }
    return _deviceNameFiled;
}

- (UITextField *)deviceTypeFiled{
    if (_deviceTypeFiled == nil) {
        _deviceTypeFiled = [[UITextField alloc] init];
        NSString *holderText = nil;
        for (NSDictionary *dict in self.models) {
            if ([dict[@"datacode"] isEqualToString:self.model.facilitytype]) {
                holderText = dict[@"dataname"];
                break;
            }
        }
        NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
        [placeholder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14 weight:UIFontWeightRegular] range:NSMakeRange(0, holderText.length)];
        _deviceTypeFiled.attributedPlaceholder = placeholder;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        _deviceTypeFiled.userInteractionEnabled = YES;
        [_deviceTypeFiled addGestureRecognizer:tap];
    }
    return _deviceTypeFiled;
}

- (UITextField *)deviceStatusFiled{
    if (_deviceStatusFiled == nil) {
        _deviceStatusFiled = [[UITextField alloc] init];
        NSString *holderText = nil;
        switch (self.model.workstatus) {
            case 0:
                holderText = @"在用";
                break;
            case 1:
                holderText = @"停用";
                break;
            case 2:
                holderText = @"报废";
                break;
            case 3:
                holderText = @"维修";
                break;
            default:
                break;
        }
        NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
        [placeholder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14 weight:UIFontWeightRegular] range:NSMakeRange(0, holderText.length)];
        _deviceStatusFiled.attributedPlaceholder = placeholder;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        _deviceStatusFiled.userInteractionEnabled = YES;
        [_deviceStatusFiled addGestureRecognizer:tap];
    }
    return _deviceStatusFiled;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = UIColorWithFloat(199);
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.text = self.model.updateTimeString;
    }
    return _timeLabel;
}

- (UILabel *)positionLabel{
    if (_positionLabel == nil) {
        _positionLabel = [[UILabel alloc] init];
        _positionLabel.text = self.model.positionaddress;
        _positionLabel.textColor = UIColorWithFloat(199);
        _positionLabel.font = [UIFont systemFontOfSize:14];
        _positionLabel.numberOfLines = 0;
    }
    return _positionLabel;
}

- (UIButton *)reCollectionBtn{
    if (_reCollectionBtn == nil) {
        _reCollectionBtn = [[UIButton alloc] init];
        _reCollectionBtn.backgroundColor = BTNBackgroudColor;
        [_reCollectionBtn setTitle:@"重新采集" forState:UIControlStateNormal];
        [_reCollectionBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _reCollectionBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        _reCollectionBtn.layer.cornerRadius = 6;
        [_reCollectionBtn addTarget:self action:@selector(reCollectionAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reCollectionBtn;
}

- (UIImageView *)mapIcon{
    if (_mapIcon == nil) {
        _mapIcon = [[UIImageView alloc] init];
        _mapIcon.image = [UIImage imageNamed:@"mapIcon"];
    }
    return _mapIcon;
}

- (UIButton *)isFoucsBtn{
    if (_isFoucsBtn == nil) {
        _isFoucsBtn = [[UIButton alloc] init];
        [_isFoucsBtn setImage:[UIImage imageNamed:@"eventSelectNomal"] forState:UIControlStateNormal];
        [_isFoucsBtn setImage:[UIImage imageNamed:@"eventSelectHighted"] forState:UIControlStateSelected];
    }
    return _isFoucsBtn;
}

- (UIButton *)isVideoBtn{
    if (_isVideoBtn == nil) {
        _isVideoBtn = [[UIButton alloc] init];
        [_isVideoBtn setImage:[UIImage imageNamed:@"eventSelectNomal"] forState:UIControlStateNormal];
        [_isVideoBtn setImage:[UIImage imageNamed:@"eventSelectHighted"] forState:UIControlStateSelected];
    }
    return _isVideoBtn;
}

- (UIButton *)isPublicBtn{
    if (_isPublicBtn == nil) {
        _isPublicBtn = [[UIButton alloc] init];
        [_isPublicBtn setImage:[UIImage imageNamed:@"eventSelectNomal"] forState:UIControlStateNormal];
        [_isPublicBtn setImage:[UIImage imageNamed:@"eventSelectHighted"] forState:UIControlStateSelected];
    }
    return _isPublicBtn;
}

- (MAMapView *)mapView{
    if (_mapView == nil) {
        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 200)];
        _mapView.delegate = self;
        _mapView.zoomLevel = 17.5;
    }
    return _mapView;
}

- (UITextView *)remarkView{
    if (_remarkView == nil) {
        _remarkView = [[UITextView alloc] init];
        _remarkView.layer.borderWidth = 1;
        _remarkView.layer.borderColor = UIColorWithFloat(239).CGColor;
    }
    return _remarkView;
}

- (FButton *)saveBtn{
    if (_saveBtn == nil) {
        _saveBtn = [FButton fbtnWithFBLayout:FBLayoutTypeTextFull andPadding:0];
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _saveBtn.backgroundColor = BTNBackgroudColor;
        _saveBtn.layer.cornerRadius = 6;
        [_saveBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _saveBtn.tag = 8;
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
        _submitBtn.tag = 7;
    }
    return _submitBtn;
}


@end
