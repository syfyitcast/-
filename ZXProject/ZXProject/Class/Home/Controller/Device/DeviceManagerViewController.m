//
//  DeviceManagerViewController.m
//  ZXProject
//
//  Created by 刘清 on 2018/4/20.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "DeviceManagerViewController.h"
#import "NotificationBar.h"
#import "GobHeaderFile.h"
#import "SearchBar.h"
#import <Masonry.h>
#import "DeviceInfoModel.h"
#import "DeviceInfoCell.h"
#import "HttpClient+Device.h"
#import "ProjectManager.h"
#import "DeviceCollectionController.h"

@interface DeviceManagerViewController ()<NotificationBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) UIView *bottomBar;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) FButton *addButton;

@property (nonatomic, strong) SearchBar *searchBar;

@property (nonatomic, strong) NSArray *models;


@end

@implementation DeviceManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设备管理";
    self.view.backgroundColor = UIColorWithFloat(239);
    [self setupSubViews];
    [self setNetWorkRequet];
}

- (void)setNetWorkRequet{
    ZXSHOW_LOADING(self.view, @"加载中");
    [HttpClient zx_httpClientToGetProjectDeviceInfoWithProjectid:[ProjectManager sharedProjectManager].currentModel.projectid andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
        ZXHIDE_LOADING;
        if (code == 0) {
            NSArray *datas = data[@"facilitylocation"];
            self.models = [DeviceInfoModel deviceInfoModelsWithSource_arr:datas];
            [self.myTableView reloadData];
        }
    }];
}

- (void)setupSubViews{
     __weak typeof(self)  weakself = self;
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.myTableView];
    [self.view addSubview:self.bottomBar];
    [self.view addSubview:self.bottomLine];
    [self.view addSubview:self.addButton];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.searchBar.mas_bottom).offset(5);
        make.left.and.right.equalTo(weakself.view);
        make.bottom.equalTo(weakself.view.mas_bottom).offset(-85);
    }];
    [self.bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.bottom.equalTo(weakself.view.mas_bottom);
        make.height.mas_equalTo(80);
    }];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.bottomBar.mas_top);
        make.left.equalTo(weakself.bottomBar.mas_left);
        make.right.equalTo(weakself.bottomBar.mas_right);
        make.height.mas_equalTo(1);
    }];
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.bottomBar.mas_centerX);
        make.centerY.equalTo(weakself.bottomBar.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
}

#pragma mark - clickAction

- (void)clickAddAction{
    DeviceCollectionController *vc = [[DeviceCollectionController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma UITableViewDelegate && DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DeviceInfoCell *cell = [DeviceInfoCell deviceInfoCellWithTableView:tableView];
    cell.model = self.models[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


#pragma mark - setter && getter

- (SearchBar *)searchBar{
    if (_searchBar == nil) {
        CGRect frame = CGRectMake(0, 0, self.view.width, 65);
        _searchBar = [SearchBar zx_SearchBarWithPlaceHolder:@"设备名称/编号" andFrame:frame andType:SearchBarTypeCategory andSearchBlock:^(NSString *macth) {
            
        }];
    }
    return _searchBar;
}

- (UITableView *)myTableView{
    if (_myTableView == nil) {
        _myTableView = [[UITableView alloc] init];
        _myTableView.backgroundColor = WhiteColor;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
        if (@available(iOS 11.0, *)) {
            _myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _myTableView;
}

- (UIView *)bottomBar{
    if (_bottomBar == nil) {
        _bottomBar = [[UIView alloc] init];
        _bottomBar.backgroundColor = WhiteColor;
    }
    return _bottomBar;
}

- (UIView *)bottomLine{
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = UIColorWithFloat(239);
    }
    return _bottomLine;
}

- (FButton *)addButton{
    if (_addButton == nil) {
        _addButton = [FButton fbtnWithFBLayout:FBLayoutTypeImageFull andPadding:0];
        [_addButton setImage:[UIImage imageNamed:@"addEvent"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(clickAddAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

@end
