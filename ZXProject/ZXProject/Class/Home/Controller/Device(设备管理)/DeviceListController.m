//
//  DeviceListController.m
//  ZXProject
//
//  Created by Me on 2018/4/21.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "DeviceListController.h"
#import "HttpClient+Device.h"
#import "GobHeaderFile.h"
#import "DeviceTypeCell.h"
#import <Masonry.h>
#import "DeviceCollectionController.h"

@interface DeviceListController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSArray *models;

@end

@implementation DeviceListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设备类型";
    [self setNetworkRequest];
}

- (void)setSubViews{
    [self.view addSubview:self.myTableView];
    self.myTableView.frame = self.view.bounds;
}

- (void)setNetworkRequest{
    ZXSHOW_LOADING(self.view, @"加载中...");
    [HttpClient zx_httpClientToGetDeviceTypeListWithSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
        if (code == 0) {
            self.models = data[@"facilitytype"];
            [self setSubViews];
            [self.myTableView reloadData];
        }
    }];
}


#pragma mark - UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DeviceTypeCell *cell = [DeviceTypeCell deviceTypeCellWithTableView:tableView];
    cell.modelDict = self.models[indexPath.row];
    cell.index = (int)(indexPath.row + 1);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = WhiteColor;
    UILabel *indexLabel = [[UILabel alloc] init];
    indexLabel.text = @"序号";
    indexLabel.textColor = BlackColor;
    indexLabel.font = [UIFont systemFontOfSize:16];
    [view addSubview:indexLabel];
    [indexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(15);
        make.centerY.equalTo(view.mas_centerY);
    }];
    UILabel *desLabel = [[UILabel alloc] init];
    desLabel.textColor = BlackColor;
    desLabel.font =  [UIFont systemFontOfSize:16];
    desLabel.text = @"设备类别";
    [view addSubview:desLabel];
    [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(indexLabel.mas_right).offset(30);
        make.centerY.equalTo(view.mas_centerY);
    }];
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = UIColorWithFloat(239);
    [view addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left);
        make.right.equalTo(view.mas_right);
        make.bottom.equalTo(view.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DeviceCollectionController *vc = [[DeviceCollectionController alloc] init];
    vc.deviceTypeDict = self.models[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - setter && getter

- (UITableView *)myTableView{
    if (_myTableView == nil) {
        _myTableView = [[UITableView alloc] init];
        _myTableView.backgroundColor = [UIColor whiteColor];
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
    }
    return _myTableView;
}


@end
