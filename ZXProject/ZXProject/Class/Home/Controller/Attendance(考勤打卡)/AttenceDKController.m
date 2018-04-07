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
#import "HttpClient+DutyEvents.h"
#import "AttDutyCheckModel.h"
#import "AttenceCheckView.h"
#import "AttenceRecoderController.h"
#import "ZXCalendarManager.h"
#import "HttpClient+Common.h"

static CGFloat ITEMSPACEING = 20;
static CGFloat LINESPACEING = 10;

@interface AttenceDKController ()<ZXCalendarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) ZXCalendar *calendarView;
@property (nonatomic, strong) UILabel *weatherLabel;
@property (nonatomic, strong) UILabel *temperatureLabel;

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UITableView *recoderTable;
@property (nonatomic, strong) NSArray *attDutyCheckModels ;

@end

@implementation AttenceDKController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"考勤详情";
    [self setSubViews];
    [self setNetWorkRequest];
}

- (void)setNetWorkRequest{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    NSDate *startDate = [calendar dateFromComponents:components];
    NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
    [HttpClient zx_httpClientToQueryProjectDutyWithBeginTime:[startDate timeIntervalSince1970] * 1000.0 andEndTime:[endDate timeIntervalSince1970] * 1000.0 andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
        if (code == 0) {
            NSArray *datas = data[@"dutystatis"];
            self.attDutyCheckModels = [AttDutyCheckModel attdutyCheckModelsWithSource_arr:datas];
            [self.recoderTable reloadData];
        }
    }];
    [HttpClient  zx_httpCilentToGetWeatherWithCityName:@"长沙" andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
        if (code == 1000) {
            NSArray *arr = data[@"forecast"];
            NSDictionary *weatherDict = arr.firstObject;
            self.weatherLabel.text = weatherDict[@"type"];
            NSString *highDes = weatherDict[@"high"];
            NSString *lowDes = weatherDict[@"low"];
            if (highDes.length > 3 && lowDes.length > 3) {
                NSString *high = [highDes substringWithRange:NSMakeRange(3, highDes.length - 3)];
                NSString *low = [lowDes substringWithRange:NSMakeRange(3, lowDes.length - 3)];
                self.temperatureLabel.text = [NSString stringWithFormat:@"%@~%@",low,high];
            }
        }
    }];
}

- (void)setSubViews{
    [self.view addSubview:self.calendarView];
    [self.view addSubview:self.weatherLabel];
    [self.view addSubview:self.temperatureLabel];
    [self.view addSubview:self.lineView];
    [self.view addSubview:self.recoderTable];
    __weak typeof(self) weakself = self;
    [self.weatherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left).offset(10);
        make.top.equalTo(weakself.view.mas_top).offset(5);
    }];
    [self.temperatureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.view.mas_right).offset(-10);
        make.top.equalTo(weakself.view.mas_top).offset(5);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.top.equalTo(weakself.calendarView.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    [self.recoderTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.top.equalTo(weakself.lineView.mas_bottom);
        make.bottom.equalTo(weakself.view.mas_bottom);
    }];
}

- (void)calendarDelegateMethodWithStartTime:(long)startTime andEndTime:(long)endTime{
    ZXSHOW_LOADING(self.view, @"加载中...");
    [HttpClient zx_httpClientToQueryProjectDutyWithBeginTime:startTime andEndTime:endTime andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
        ZXHIDE_LOADING;
        if (code == 0) {
            NSArray *datas = data[@"dutystatis"];
            self.attDutyCheckModels = [AttDutyCheckModel attdutyCheckModelsWithSource_arr:datas];
            [self.recoderTable reloadData];
            
        }else{
            if (message.length != 0) {
                [MBProgressHUD showError:message toView:self.view];
            }
        }
    }];
}

#pragma mark - UITableViewDelegate && Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.attDutyCheckModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AttenceCheckView *cell = [AttenceCheckView attenceCheckCellWithTableView:tableView];
    cell.model = self.attDutyCheckModels[self.attDutyCheckModels.count -  indexPath.row - 1];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AttenceRecoderController *vc = [[AttenceRecoderController alloc] init];
    vc.model = self.attDutyCheckModels[self.attDutyCheckModels.count -  indexPath.row - 1];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - setter && getter

- (ZXCalendar *)calendarView{
    if (_calendarView == nil) {
        CGFloat itemHeight = (self.view.width - 6 * ITEMSPACEING) / 7;
        NSArray *items = [[[ZXCalendarManager alloc] init] zx_CalendarItemsWithDate:[NSDate date]];
        CGFloat height = (items.count / 7) * (itemHeight + LINESPACEING);
        _calendarView = [ZXCalendar zx_CalendarWithFrame:CGRectMake(0, 59, self.view.width , height + 50)];
        _calendarView.delegate = self;
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

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = UIColorWithFloat(239);
    }
    return _lineView;
}

- (UITableView *)recoderTable{
    if (_recoderTable == nil) {
        _recoderTable = [[UITableView alloc] init];
        _recoderTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _recoderTable.backgroundColor = WhiteColor;
        _recoderTable.delegate = self;
        _recoderTable.dataSource = self;
    }
    return _recoderTable;
}


@end
