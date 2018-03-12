//
//  WorkTaskAddController.m
//  ZXProject
//
//  Created by Me on 2018/3/7.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "WorkTaskAddController.h"
#import "WorkTaskAddImagePickView.h"
#import "GobHeaderFile.h"
#import "UserLocationManager.h"
#import <Masonry.h>

@interface WorkTaskAddController()

@property (nonatomic, strong) WorkTaskAddImagePickView *pickView;
@property (nonatomic, strong) UIView *lineOne;
@property (nonatomic, strong) UILabel *desLabel;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton  *VoiceBtn;
@property (nonatomic, strong) UIView *lineTwo;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIView *lineThree;
@property (nonatomic, strong) UILabel *positionLabel;
@property (nonatomic, strong) UIImageView *positionIcon;
@property (nonatomic, strong) UIView *lineFour;


@end

@implementation WorkTaskAddController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增事件";
    [self setSubViews];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UserLocationManager sharedUserLocationManager] reverseGeocodeLocationWithAdressBlock:^(NSDictionary *addressDic) {
        NSString *state=[addressDic objectForKey:@"State"];
        NSString *city=[addressDic objectForKey:@"City"];
        NSString *subLocality=[addressDic objectForKey:@"SubLocality"];
        NSString *street=[addressDic objectForKey:@"Street"];
        self.positionLabel.text = [NSString stringWithFormat:@"位置:  %@%@%@%@",state,city, subLocality, street];
    }];
}

- (void)setSubViews{
    __weak typeof(self) weakself = self;
    [self.view addSubview:self.pickView];
    [self.view addSubview:self.lineOne];
    [self.view addSubview:self.desLabel];
    [self.view addSubview:self.textView];
    [self.view addSubview:self.VoiceBtn];
    [self.view addSubview:self.lineTwo];
    [self.view addSubview:self.timeLabel];
    [self.view addSubview:self.lineThree];
    [self.view addSubview:self.positionLabel];
    [self.view addSubview:self.positionIcon];
    [self.view addSubview:self.lineFour];
    [self.lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.top.equalTo(weakself.pickView.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left).offset(15);
        make.top.equalTo(weakself.lineOne.mas_bottom).offset(15);
    }];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.desLabel.mas_left);
        make.right.equalTo(weakself.view.mas_right).offset(-36);
        make.top.equalTo(weakself.desLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(80);
    }];
    [self.VoiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.textView.mas_right).offset(5);
        make.right.equalTo(weakself.view.mas_right).offset(-3);
        make.bottom.equalTo(weakself.textView.mas_bottom);
        make.height.mas_equalTo(26);
    }];
    [self.lineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.top.equalTo(weakself.textView.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left).offset(15);
        make.top.equalTo(weakself.lineTwo.mas_bottom).offset(15);
    }];
    [self.lineThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.top.equalTo(weakself.timeLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
    }];
    [self.positionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left).offset(15);
        make.top.equalTo(weakself.lineThree.mas_bottom).offset(15);
    }];
    [self.positionIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.positionLabel.mas_right).offset(5);
        make.centerY.equalTo(weakself.positionLabel.mas_centerY);
    }];
    [self.lineFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.top.equalTo(weakself.positionLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark - setter && getter

- (WorkTaskAddImagePickView *)pickView{
    if (_pickView == nil) {
        CGRect frame = CGRectMake(0, 0, self.view.width, 100);
        _pickView = [WorkTaskAddImagePickView workTaskAddImagePickViewWithFrame:frame];
    }
    return _pickView;
}

- (UIView *)lineOne{
    if (_lineOne == nil) {
        _lineOne = [[UIView alloc] init];
        _lineOne.backgroundColor = UIColorWithFloat(239);
    }
    return _lineOne;
}

- (UILabel *)desLabel{
    if (_desLabel == nil) {
        _desLabel = [[UILabel alloc] init];
        _desLabel.textColor = UIColorWithFloat(79);
        _desLabel.font = [UIFont systemFontOfSize:15];
        _desLabel.text = @"说明:";
    }
    return _desLabel;
}

- (UITextView *)textView{
    if (_textView == nil) {
        _textView = [[UITextView alloc] init];
        _textView.layer.borderColor = UIColorWithFloat(239).CGColor;
        _textView.layer.borderWidth = 1;
    }
    return _textView;
}

- (UIButton *)VoiceBtn{
    if (_VoiceBtn == nil) {
        _VoiceBtn = [[UIButton alloc] init];
        [_VoiceBtn setBackgroundImage:[UIImage imageNamed:@"voiceIcon"] forState:UIControlStateNormal];
    }
    return _VoiceBtn;
}

- (UIView *)lineTwo{
    if (_lineTwo == nil) {
        _lineTwo = [[UIView alloc] init];
        _lineTwo.backgroundColor = UIColorWithFloat(239);
    }
    return _lineTwo;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = UIColorWithFloat(79);
        _timeLabel.font = [UIFont systemFontOfSize:15];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        _timeLabel.text = [NSString stringWithFormat:@"时间:   %@", [formatter stringFromDate:[NSDate date]]];
    }
    return _timeLabel;
}

- (UIView *)lineThree{
    if (_lineThree == nil) {
        _lineThree = [[UIView alloc] init];
        _lineThree.backgroundColor = UIColorWithFloat(239);
    }
    return _lineThree;
}

- (UILabel *)positionLabel{
    if (_positionLabel == nil) {
        _positionLabel = [[UILabel alloc] init];
        _positionLabel.textColor = UIColorWithFloat(79);
        _positionLabel.font = [UIFont systemFontOfSize:15];
    }
    return _positionLabel;
}

- (UIImageView *)positionIcon{
    if (_positionIcon == nil) {
        _positionIcon = [[UIImageView alloc] init];
        _positionIcon.image = [UIImage imageNamed:@"mapIcon"];
    }
    return _positionIcon;
}

- (UIView *)lineFour{
    if (_lineFour == nil) {
        _lineFour = [[UIView alloc] init];
        _lineFour.backgroundColor = UIColorWithFloat(239);
    }
    return _lineFour;
}

@end
