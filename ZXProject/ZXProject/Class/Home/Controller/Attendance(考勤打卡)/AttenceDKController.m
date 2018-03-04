//
//  AttenceDKController.m
//  ZXProject
//
//  Created by Me on 2018/3/1.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "AttenceDKController.h"
#import "ZXCalendar.h"
#import "GobHeaderFile.h"
#import <Masonry.h>

@interface AttenceDKController ()

@property (nonatomic, strong) ZXCalendar *calendarView;
@property (nonatomic, strong) UILabel *weatherLabel;
@property (nonatomic, strong) UILabel *temperatureLabel;

@end

@implementation AttenceDKController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"考勤详情";
    [self setSubViews];
   
}

- (void)setSubViews{
    [self.view addSubview:self.calendarView];
    [self.view addSubview:self.weatherLabel];
    [self.view addSubview:self.temperatureLabel];
    __weak typeof(self) weakself = self;
    [self.weatherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left).offset(10);
        make.top.equalTo(weakself.view.mas_top).offset(5);
    }];
    [self.temperatureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.view.mas_right).offset(-10);
        make.top.equalTo(weakself.view.mas_top).offset(5);
    }];
    
}

#pragma mark - setter && getter

- (ZXCalendar *)calendarView{
    if (_calendarView == nil) {
        _calendarView = [ZXCalendar zx_CalendarWithFrame:CGRectMake(0, 59, self.view.width , 300)];
    }
    return _calendarView;
}

- (UILabel *)weatherLabel{
    if (_weatherLabel == nil) {
        _weatherLabel = [[UILabel alloc] init];
        _weatherLabel.text = @"晴";
        _weatherLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        _weatherLabel.textColor = UIColorWithRGB(77, 77, 77);
    }
    return _weatherLabel;
}

- (UILabel *)temperatureLabel{
    if (_temperatureLabel == nil) {
        _temperatureLabel = [[UILabel alloc] init];
        _temperatureLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        _temperatureLabel.textColor = UIColorWithRGB(77, 77, 77);
        _temperatureLabel.text = @"-1℃～9℃";
    }
    return _temperatureLabel;
}


@end
