//
//  ProjectReviewController.m
//  ZXProject
//
//  Created by 刘清 on 2018/3/16.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "ProjectReviewController.h"
#import "NotificationBar.h"
#import "GobHeaderFile.h"
#import "ProjectReviewPersonCell.h"
#import <Masonry.h>
#import "HttpClient+Monitor.h"
#import "HttpClient+Device.h"
#import "ProjectReviewDeviceCell.h"
#import "DeviceInfoCell.h"
#import "DeviceInfoModel.h"
#import "TrackViewController.h"
#import "CarWorkStatusViewController.h"



@interface ProjectReviewController ()<NotificationBarDelegate,UITableViewDelegate,UITableViewDataSource,ProjectReviewDeviceCellDelegate>

@property (nonatomic, strong) NotificationBar *topBar;
@property (nonatomic, strong) UITableView *myTableView;

@property (nonatomic, strong) NSArray *personInfoDicts;
@property (nonatomic, strong) NSArray *carInfoDicts;
@property (nonatomic, strong) NSArray *deviceInfoDicts;

@property (nonatomic, assign) int currentIndex;

@end

@implementation ProjectReviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"项目总览";
    [self setupSubViews];
    self.currentIndex = 0;
    [self setNetworkRequest];
}

- (void)setNetworkRequest{
    ZXSHOW_LOADING(self.view, @"加载中...");
    dispatch_group_t group = dispatch_group_create();
    // 队列
    dispatch_queue_t queue = dispatch_queue_create("zj", DISPATCH_QUEUE_CONCURRENT);
    // 将任务添加到队列和调度组
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{//人员
        [HttpClient zx_httpClientToGetProjectPersonInfoWithProjectid:@"55" andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {//employeelocation
            if (code == 0) {
                self.personInfoDicts = data[@"employeelocation"];
            }
            dispatch_group_leave(group);
        }];
    });
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        [HttpClient zx_httpClientToGetProjectCarInfoWithProjectid:@"55" andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
            if (code == 0) {//vehiclelocation
                self.carInfoDicts = data[@"vehiclelocation"];
            }
            dispatch_group_leave(group);
        }];
    });
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        [HttpClient zx_httpClientToGetProjectDeviceInfoWithProjectid:@"55" andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
            if (code == 0) {//facilitylocation
                self.deviceInfoDicts = data[@"facilitylocation"];
            }
            dispatch_group_leave(group);
        }];
    });
    // 异步 : 调度组中的所有异步任务执行结束之后,在这里得到统一的通知
    dispatch_queue_t mQueue = dispatch_get_main_queue();
    dispatch_group_notify(group, mQueue, ^{
        ZXHIDE_LOADING;
        [self.myTableView reloadData];
    });
}


- (void)setupSubViews{
    [self.view addSubview:self.topBar];
    [self.view addSubview:self.myTableView];
    __weak typeof(self)  weakself = self;
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.top.equalTo(weakself.topBar.mas_bottom);
        make.bottom.equalTo(weakself.view.mas_bottom);
    }];
}

#pragma mark - NavigationBarDelegate

- (void)notificationBarDidTapIndexLabel:(NSInteger)index{
    self.currentIndex = (int)index;
    [self.myTableView reloadData];
}

#pragma mark - ProjectDeviceCellDelegate Method

- (void)projectReviewDeviceCellDidClickBtnTag:(int)index andModelDict:(NSDictionary *)modelDict{
    if (index == 0) {//轨迹
        TrackViewController *vc = [[TrackViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (index == 1){//工况
        CarWorkStatusViewController *vc = [[CarWorkStatusViewController alloc] init];
        vc.modelDict = modelDict;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (index == 2){//统计
        
    }
}

#pragma mark - UITableViewDelegate && dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.currentIndex == 0) {
        return self.personInfoDicts.count;
    }else if (self.currentIndex == 1){
        return self.carInfoDicts.count;
    }else if (self.currentIndex == 2){
        return self.deviceInfoDicts.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.currentIndex == 0) {
        ProjectReviewPersonCell *cell = [ProjectReviewPersonCell projectReviewPersonCellWithTabelView:tableView];
        cell.modelDict = self.personInfoDicts[indexPath.row];
        return cell;
    }else if (self.currentIndex == 1){//车信息
        ProjectReviewDeviceCell *cell = [ProjectReviewDeviceCell projectReviewDeviceCellWithTableView:tableView];
        cell.delegate = self;
        cell.modelDict = self.carInfoDicts[indexPath.row];
        return cell;
    }else if(self.currentIndex == 2){
        DeviceInfoCell *cell = [DeviceInfoCell deviceInfoCellWithTableView:tableView];
        cell.model = [DeviceInfoModel deviceInfoModelWithDict:self.deviceInfoDicts[indexPath.row]];
        return cell;
    }
    return [[UITableViewCell alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.currentIndex == 0) {
        return 138;
    }else if (self.currentIndex == 1){
        return 115;
    }else if (self.currentIndex == 2){
        return 90;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.currentIndex == 0) {
        
    }else if (self.currentIndex == 1){
        
    }else if (self.currentIndex == 2){
        
    }
}

#pragma mark - setter && getter

- (NotificationBar *)topBar{
    if (_topBar == nil) {
        CGRect frame = CGRectMake(0, 0, self.view.width, 60);
        _topBar = [NotificationBar notificationBarWithItems:@[@"人员",@"车辆",@"设施"] andFrame:frame];
        _topBar.delegate = self;
        _topBar.backgroundColor = WhiteColor;
        _topBar.delegate = self;
    }
    return _topBar;
}

- (UITableView *)myTableView{
    if (_myTableView == nil) {
        _myTableView = [[UITableView alloc] init];
        _myTableView.backgroundColor = WhiteColor;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}


@end
