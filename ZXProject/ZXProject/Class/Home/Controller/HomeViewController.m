//
//  HomeViewController.m
//  ZXProject
//
//  Created by Me on 2018/2/8.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "HomeViewController.h"
#import "MainTabBarController.h"
#import "GobHeaderFile.h"
#import <Masonry.h>
#import "HomeHeaderView.h"
#import "HomeCollectionView.h"
#import "HomeLeftTableViewCell.h"
#import "HomeRightItems.h"
#import "HomeRightTableViewCell.h"
#import "WorkFlowController.h"
#import "AttendanceController.h"
#import "PersonInfoController.h"
#import "WorkManagerController.h"
#import "EventsViewController.h"
#import "InspectionViewComntroller.h"
#import "DeviceManagerViewController.h"
#import "UserLocationManager.h"
#import "ProjectReviewController.h"
#import "HttpClient.h"
#import "UserManager.h"
#import "APPNotificationManager.h"
#import "ProjectManager.h"
#import "eventsMdoel.h"
#import "EventsHomeCell.h"
#import "WorkFlowAddController.h"
#import "MainNavigationController.h"
#import "LoginViewController.h"
#import "HttpClient+Common.h"
#import "MonitorViewController.h"




@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,HomeHeaderViewDelegate,HomeCollectionViewDelegate>

@property (nonatomic, strong) NSNotificationCenter *notifiCenter;

@property (nonatomic, strong) UIScrollView *mainScollview;
@property (nonatomic, strong) HomeHeaderView *headerView;
@property (nonatomic, strong) HomeCollectionView *collectionView;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UITableView *bottomTable;
@property (nonatomic, strong) UITableView *leftTable;
@property (nonatomic, strong) UITableView *rightTable;
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) ProjectModel *currentModel;
@property (nonatomic, strong) HomeLeftTableViewCell *currentLeftCell;

@property (nonatomic, strong) NSArray *headerLeftItems;
@property (nonatomic, strong) NSArray *headerRightItems;

@property (nonatomic, strong) UITableView *bottomTabel;
@property (nonatomic, strong) NSArray *eventsModels;



@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    self.title = @"首页";
    self.currentModel = [ProjectManager sharedProjectManager].projects.firstObject;
    self.navigationController.navigationBar.hidden = YES;
    [[UserLocationManager sharedUserLocationManager] reverseGeocodeLocationWithAdressBlock:nil];
    [self isLocationAuthrize];
    [self setSubviews];
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getProjectsInfo) name:NOTIFI_PROJECTLISTDONE object:nil];
}

- (void)isLocationAuthrize{//判断有没有定位权限
    UIView *coverView = [[UIView alloc] init];
    coverView.backgroundColor = [UIColor blackColor];
    coverView.alpha = 0.75;
    coverView.frame = [UIApplication sharedApplication].keyWindow.bounds;
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor blackColor];
    label.text = @"智慧环卫app需要使用您手机的始终定位权限,否则app无法正常使用";
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor whiteColor];
    label.width = self.view.width *  0.8;
    label.x = self.view.width * 0.1;
    label.height = 50;
    label.y = (self.view.height - label.height)*0.5;
    [coverView addSubview:label];
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways) {
        //定位功能可用
       
        
    }else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {
        //定位不能用
        [[UIApplication sharedApplication].keyWindow addSubview:coverView];
    }
}

- (void)getProjectsInfo{
    [HttpClient zx_httpClientToGetProjectListWithProjectCode:@"" andProjectName:@"" andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
        if (code == 0) {
            NSArray *datas = data[@"projectList"];
            [ProjectManager sharedProjectManager].projects = [ProjectModel projectModelsWithsource_arr:datas];
            self.currentModel = [ProjectManager sharedProjectManager].currentModel;
            if (self.currentModel == nil) {
                self.currentModel = [ProjectManager sharedProjectManager].projects.firstObject;
            }
            [self.headerView setProjectLabelName:self.currentModel.projectname];
            [self getDutyEvents];
            [self getNotificationCount];
        }
    }];
    // 调度组
    dispatch_group_t group = dispatch_group_create();
    // 队列
    dispatch_queue_t queue = dispatch_queue_create("zj", DISPATCH_QUEUE_CONCURRENT);
    // 将任务添加到队列和调度组
    NSMutableArray *tem_arr = [NSMutableArray array];
    for (NSString *projectid in [UserManager sharedUserManager].user.allProjects) {
        dispatch_group_enter(group);
        dispatch_group_async(group, queue, ^{
            [HttpClient zx_httpClientToProjectDetailWithProjectid:projectid andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
                if (code == 0) {
                    NSDictionary *datas = data[@"projectInfo"];
                    ProjectModel *model = [ProjectModel projectsWithDict:datas];
                    model.projectid = projectid;
                    [tem_arr addObject:model];
                }
                dispatch_group_leave(group);
            }];
        });
    }
    // 异步 : 调度组中的所有异步任务执行结束之后,在这里得到统一的通知
    dispatch_queue_t mQueue = dispatch_get_main_queue();
    dispatch_group_notify(group, mQueue, ^{
        [ProjectManager sharedProjectManager].projectDetails = tem_arr.mutableCopy;
    });
}

- (void)getNotificationCount{
    User *user = [UserManager sharedUserManager].user;
    [HttpClient zx_httpClientToGetNotificationReadCountWithProjectid:[ProjectManager sharedProjectManager].currentProjectid andEmployerid:user.employerid andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
        if (code == 0) {
            NSArray *datas = data[@"appNoReadNoticeCount"];
            [APPNotificationManager sharedAppNotificationManager].notificationCounts = datas;
            [self.notifiCenter postNotificationName:NOTIFI_READCOUNT object:nil];//发送未读消息通知
        }
    }];
}

- (void)getDutyEvents{
    [HttpClient zx_httpClientToGetProjectEventsWithProjectId:[ProjectManager sharedProjectManager].currentProjectid andEventsStatus:@"0" andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
        if (code == 0) {
            NSArray *datas = data[@"getpatroleventassign"];
            self.eventsModels = [eventsMdoel eventsModelsWithSource_arr:datas];
            [self.bottomTabel reloadData];
            if (self.eventsModels.count != 0) {
                self.bottomTabel.height = self.eventsModels.count * 86;
                self.mainScollview.contentSize = CGSizeMake(0, CGRectGetMaxY(self.bottomTabel.frame) + 20 + 44);
                self.bottomTabel.backgroundColor = WhiteColor;
            }else{
                self.bottomTabel.backgroundColor = [UIColor clearColor];
            }
        }
    }];
}

- (void)getWeatherInformation{
    [HttpClient zx_httpCilentToGetWeatherWithCityName:[ProjectManager sharedProjectManager].currentModel.cityname andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
        if (code == 1000) {
            NSArray *weather_arr = data[@"forecast"];
            NSDictionary *weather_dict = weather_arr.firstObject;
            [self.headerView setWeatherDict:weather_dict];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    MainTabBarController *mTabBar = (MainTabBarController *)self.tabBarController;
    [mTabBar showTabBar];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)setSubviews{
    self.headerView = [HomeHeaderView homeHeaderView];
    self.headerView.delegate = self;
    [self.view addSubview:self.mainScollview];
    [self.mainScollview addSubview:self.bottomTabel];
    self.mainScollview.frame = self.navigationController.view.bounds;
    [self.mainScollview addSubview:self.headerView];
    self.headerView.x = 0;
    self.headerView.y = 0;
    self.headerView.width = self.mainScollview.width;
    self.headerView.height = 210;
    [self.mainScollview addSubview:self.collectionView];
    self.collectionView.x = 0;
    self.collectionView.y = CGRectGetMaxY(self.headerView.frame);
    self.collectionView.width = self.mainScollview.width;
    self.collectionView.height = 94 * 3;
    self.bottomTabel.y = CGRectGetMaxY(self.collectionView.frame) + 15;
    self.bottomTabel.x = 0;
    self.bottomTabel.width = self.mainScollview.width;
    self.bottomTabel.height = 86;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}

#pragma mark - HomeHeaderViewDelegateMethod

- (void)homeHeaderViewDidClickLeftBtn{
    if ([ProjectManager sharedProjectManager].projectDetails.count == 0) {
        [MBProgressHUD showError:@"正在获取数据请稍后"];
    }else{
        self.coverView.frame = self.view.bounds;
        [self.view addSubview:self.coverView];
        self.leftTable.frame = CGRectMake(5, 65, 150, [ProjectManager sharedProjectManager].projectDetails.count * 34);
        [self.view addSubview:self.leftTable];
    }
}

- (void)homeHeaderViewDidClickRightBtn{
    self.coverView.frame = self.view.bounds;
    [self.view addSubview:self.coverView];
    self.rightTable.frame = CGRectMake(self.view.width - 5 - 160 , 65, 160, 160);
    [self.view addSubview:self.rightTable];
}

- (void)homeHeadeerViewDidClickIconView{
    PersonInfoController *infoVc = [[PersonInfoController alloc] init];
    [self.navigationController pushViewController:infoVc animated:YES];
}

- (void)clickCoverView{
    [self.coverView removeFromSuperview];
    if (self.leftTable) {
        [self.leftTable removeFromSuperview];
    }
    if (self.rightTable) {
        [self.rightTable removeFromSuperview];
    }
}

#pragma mark - HomeCollectionViewDelegateMethod

- (void)homeCollectionViewDidClickBtnIndex:(NSInteger)index{
    NSString *controllerName = self.items[index];
    Class class =  NSClassFromString(controllerName);
    id controller = [[class alloc] init];
    if (controller != nil) {
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark - TableView DataSource && Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.leftTable) {
        return self.headerLeftItems.count;
    }else if (tableView == self.rightTable){
        return self.headerRightItems.count;
    }else if (tableView == self.bottomTabel){
        return self.eventsModels.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTable) {
        HomeLeftTableViewCell *cell = [HomeLeftTableViewCell homeLeftTableViewCellWithTableView:tableView];
        ProjectModel *model = self.headerLeftItems[indexPath.row];
        cell.title = model.projectname;
        if ([model.projectid isEqualToString:self.currentModel.projectid]) {
            [cell setTitleColor:WhiteColor];
            cell.backgroundColor = UIColorWithRGB(110, 199, 54);
            self.currentLeftCell = cell;
        }else{
            [cell setTitleColor:UIColorWithFloat(132)];
            cell.backgroundColor = WhiteColor;
        }
        return cell;
    }else if(tableView == self.rightTable){
        HomeRightTableViewCell *cell = [HomeRightTableViewCell homeRightTableViewCellWithTable:tableView];
        cell.item = self.headerRightItems[indexPath.row];
        return cell;
    }else if (tableView == self.bottomTabel){
        EventsHomeCell *cell = [EventsHomeCell eventsHomeCellWithTabelView:tableView];
        cell.model = self.eventsModels[indexPath.row];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTable) {
        return 34;
    }else if (tableView == self.rightTable){
        return 40;
    }else if (tableView == self.bottomTabel){
        return 86;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == self.leftTable) {
        ProjectModel *model = [ProjectManager sharedProjectManager].projectDetails[indexPath.row];
        if ([self.currentModel.projectid isEqualToString:model.projectid]) return;
        HomeLeftTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.backgroundColor = UIColorWithRGB(110, 199, 54);
        [cell setTitleColor:WhiteColor];
        self.currentLeftCell.backgroundColor = WhiteColor;
        [self.currentLeftCell setTitleColor:UIColorWithRGB(132, 132, 132)];
        self.currentLeftCell = cell;
        self.currentModel = [ProjectManager sharedProjectManager].projectDetails[indexPath.row];
        [ProjectManager sharedProjectManager].currentModel = self.currentModel;
        [ProjectManager sharedProjectManager].currentProjectid = self.currentModel.projectid;
        [self.headerView setProjectLabelName:self.currentModel.projectname];
        [self getDutyEvents];
        [self getWeatherInformation];
        [self clickCoverView];
    }else if (tableView == self.bottomTabel){
        
    }else if (tableView == self.rightTable){
        if (indexPath.row == 0) {//打卡
            AttendanceController *vc = [[AttendanceController  alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 1){//发起流程
            WorkFlowAddController *vc = [[WorkFlowAddController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 3){//退出登录
            ZXSHOW_LOADING(self.view, @"退出登录中...")
            [HttpClient zx_httpClientToLogoutWithUserName:[UserManager sharedUserManager].user.loginname andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
                ZXHIDE_LOADING
                if (code == 0) {//登出成功
                    [[UserManager sharedUserManager] deleteAccessToken];//删除token
                    UIWindow *window = [UIApplication sharedApplication].keyWindow;
                    window.rootViewController = [[MainNavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
                }else{
                    if (message.length != 0) {
                        [MBProgressHUD showError:message];
                    }else{
                        [MBProgressHUD showError:[NSString stringWithFormat:@"code = %d 登出异常",code]];
                    }
                }
            }];
            [self clickCoverView];
        }else if (indexPath.row == 2){//扫一扫
            
        }
    }
}

#pragma mark - setter && getter

- (UIScrollView *)mainScollview{
    if (_mainScollview == nil) {
        _mainScollview = [[UIScrollView alloc] init];
        _mainScollview.showsVerticalScrollIndicator = NO;
        _mainScollview.backgroundColor = UIColorWithRGB(240, 240, 240);
        if (@available(iOS 11.0, *)) {
            _mainScollview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _mainScollview;
}

- (HomeCollectionView *)collectionView{
    if (_collectionView == nil) {
        _collectionView = [HomeCollectionView HomeCollectionViewWithItems:self.items andFrame:CGRectMake(0, 0, self.view.width, 94 * 3)];
        _collectionView.backgroundColor = WhiteColor;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

- (NSArray *)items{
    if (_items == nil) {
        _items = @[@"NotificationViewController",@"WorkFlowController",@"AttendanceController",@"WorkManagerController",@"EventsViewController",@"InspectionViewComntroller",@"DeviceManagerViewController",@"MonitorViewController",@"ProjectReviewController",@"onFoucsController",@"onFoucsController",@"onFoucsController"];
    }
    return _items;
}

- (UITableView *)bottomTable{
    if (_bottomTable == nil) {
        _bottomTable = [[UITableView alloc] init];
        _bottomTable.delegate = self;
    }
    return _bottomTable;
}

- (UITableView *)leftTable{
    if (_leftTable == nil) {
        _leftTable = [[UITableView alloc]  init];
        _leftTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _leftTable.backgroundColor = WhiteColor;
        _leftTable.dataSource = self;
        _leftTable.delegate = self;
        _leftTable.layer.shadowColor = BlackColor.CGColor;
        _leftTable.layer.shadowOpacity = 0.7;
        _leftTable.layer.shadowOffset = CGSizeMake(1, 1);
        _leftTable.layer.shadowRadius = 3;
        _leftTable.clipsToBounds = NO;
        _leftTable.bounces = NO;
    }
    return _leftTable;
}

- (UITableView *)rightTable{
    if (_rightTable == nil) {
        _rightTable = [[UITableView alloc]  init];
        _rightTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _rightTable.backgroundColor = WhiteColor;
        _rightTable.dataSource = self;
        _rightTable.delegate = self;
        _rightTable.layer.shadowColor = BlackColor.CGColor;
        _rightTable.layer.shadowOpacity = 0.7;
        _rightTable.layer.shadowOffset = CGSizeMake(1, 1);
        _rightTable.layer.shadowRadius = 3;
        _rightTable.layer.borderColor = UIColorWithRGB(200, 200, 200).CGColor;
        _rightTable.layer.borderWidth = 1;
        _rightTable.clipsToBounds = NO;
    }
    return _rightTable;
}

- (UIView *)coverView{
    if (_coverView == nil) {
        _coverView = [[UIView alloc] init];
        _coverView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCoverView)];
        [_coverView addGestureRecognizer:tap];
    }
    return _coverView;
}

- (NSArray *)headerLeftItems{
    if (_headerLeftItems == nil) {
        _headerLeftItems = [ProjectManager sharedProjectManager].projectDetails;
    }
    return _headerLeftItems;
}

- (NSArray *)headerRightItems{
    if (_headerRightItems == nil) {
        NSArray *source_arr = @[
                                @{
                                    @"imageName":@"homeRightDK",
                                    @"title":@"打卡",
                                    },
                                @{
                                    @"imageName":@"homeRightFlow",
                                    @"title":@"发起流程",
                                    },
                                @{
                                    @"imageName":@"homeRightSS",
                                    @"title":@"扫一扫",
                                    },
                                @{
                                    @"imageName":@"homeRightLogout",
                                    @"title":@"退出",
                                    },
                                ];
        _headerRightItems = [HomeRightItems homeRightItemsWithSource_arr:source_arr];
    }
    return _headerRightItems;
}

- (NSNotificationCenter *)notifiCenter{
    if (_notifiCenter == nil) {
        _notifiCenter = [NSNotificationCenter defaultCenter];
    }
    return _notifiCenter;
}

- (UITableView *)bottomTabel{
    if (_bottomTabel == nil) {
        _bottomTabel = [[UITableView alloc] init];
        _bottomTabel.delegate = self;
        _bottomTabel.dataSource = self;
        _bottomTabel.separatorStyle = UITableViewCellSeparatorStyleNone;
        _bottomTabel.backgroundColor = [UIColor clearColor];
        _bottomTabel.bounces = NO;
        
    }
    return _bottomTabel;
}

@end
