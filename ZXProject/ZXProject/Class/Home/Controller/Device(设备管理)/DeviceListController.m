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

@interface DeviceListController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation DeviceListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设备类型";
    [self setNetworkRequest];
}

- (void)setNetworkRequest{
    ZXSHOW_LOADING(self.view, @"加载中...");
    [HttpClient zx_httpClientToGetDeviceTypeListWithSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
        if (code == 0) {
            
        }
    }];
}


#pragma mark - UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
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
