//
//  NotificationViewController.m
//  ZXProject
//
//  Created by Me on 2018/2/25.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "NotificationViewController.h"
#import "GobHeaderFile.h"
#import "NotificationBar.h"
#import "NotificationNewsCell.h"
#import "NewsDetailViewController.h"
#import "HttpClient.h"
#import "UserManager.h"
#import "NotificationModel.h"
#import "ProjectManager.h"
#import "APPNotificationManager.h"
#import "NewsReadCountViewController.h"

@interface NotificationViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,NotificationBarDelegate,NotificaionNewsCellDelegate>

@property (nonatomic, strong) NotificationBar *topBar;
@property (nonatomic, strong) UIScrollView *myScrollView;

@property (nonatomic, strong) UITableView *systemTable;
@property (nonatomic, strong) UITableView *notifiTable;
@property (nonatomic, strong) UITableView *newsTable;

@property (nonatomic, strong) NSArray *notificationNewsModels;
@property (nonatomic, strong) NSArray *notificationJtModels;
@property (nonatomic, strong) NSArray *notificationXmModels;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    self.title = @"通知公告";
    [self setSubViews];
    [self networkRequest];
}

- (void)networkRequest{
    User *user = [UserManager sharedUserManager].user;
    ZXSHOW_LOADING(self.view, @"加载中...");
    // 调度组
    dispatch_group_t group = dispatch_group_create();
    // 队列
    dispatch_queue_t queue = dispatch_queue_create("zj", DISPATCH_QUEUE_CONCURRENT);
    // 将任务添加到队列和调度组
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{//集团通知
        [HttpClient zx_getAppNoticeinfoWithProjectid:[ProjectManager sharedProjectManager].currentProjectid andEmployedId:user.employerid andPublishType:@"0" andpublishLevel:@"0" andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
            if (code == 0) {
                NSArray *datas = data[@"appNoticeInfo"];
                self.notificationJtModels = [NotificationModel notificationModelsWithSource_arr:datas andType:0];
            }
            dispatch_group_leave(group);
        }];
    });
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{//项目通知
        [HttpClient zx_getAppNoticeinfoWithProjectid:[ProjectManager sharedProjectManager].currentProjectid andEmployedId:user.employerid andPublishType:@"0" andpublishLevel:@"1" andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
            if (code == 0) {
                NSArray *datas = data[@"appNoticeInfo"];
                self.notificationXmModels = [NotificationModel notificationModelsWithSource_arr:datas andType:1];
            }
            dispatch_group_leave(group);
        }];
    });
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{//新闻公告
        [HttpClient zx_getAppNoticeinfoWithProjectid:[ProjectManager sharedProjectManager].currentProjectid andEmployedId:user.employerid andPublishType:@"1" andpublishLevel:@"" andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
            if (code == 0) {
                NSArray *datas = data[@"appNoticeInfo"];
                self.notificationNewsModels = [NotificationModel notificationModelsWithSource_arr:datas andType:2];
            }
            dispatch_group_leave(group);
        }];
    });
    // 异步 : 调度组中的所有异步任务执行结束之后,在这里得到统一的通知
    dispatch_queue_t mQueue = dispatch_get_main_queue();
    dispatch_group_notify(group, mQueue, ^{
        ZXHIDE_LOADING;
        [self.systemTable reloadData];
        [self.newsTable reloadData];
        [self.notifiTable reloadData];
        [self.topBar setBadgeAtIndex:0 withCount:[APPNotificationManager sharedAppNotificationManager].jtCount];
        [self.topBar setBadgeAtIndex:1 withCount:[APPNotificationManager sharedAppNotificationManager].xmCount];
        [self.topBar setBadgeAtIndex:2 withCount:[APPNotificationManager sharedAppNotificationManager].newCount];
    });
}

- (void)setSubViews{
    CGRect topBarFrame = CGRectMake(0, 0, self.view.width, 60);
    self.topBar = [NotificationBar notificationBarWithItems:@[@"集团通知",@"项目通知",@"新闻公告"] andFrame:topBarFrame];
    self.topBar.delegate = self;
    [self.view addSubview:self.topBar];
    self.myScrollView.x = 0;
    self.myScrollView.y = 60;
    self.myScrollView.width = self.view.width;
    self.myScrollView.height = self.view.height - 60;
    [self.view addSubview:self.myScrollView];
    self.systemTable.frame = CGRectMake(0, 0, self.view.width, self.myScrollView.height);
    self.notifiTable.frame = CGRectMake(self.view.width, 0, self.view.width, self.myScrollView.height);
    self.newsTable.frame = CGRectMake(self.view.width * 2, 0, self.view.width, self.myScrollView.height);
    [self.myScrollView addSubview:self.systemTable];
    [self.myScrollView addSubview:self.notifiTable];
    [self.myScrollView addSubview:self.newsTable];
}

- (void)notificationBarDidTapIndexLabel:(NSInteger)index{
    self.myScrollView.contentOffset = CGPointMake(index * self.view.width, 0);
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.systemTable) {
        return self.notificationJtModels.count;
    }else if (tableView == self.notifiTable){
        return self.notificationXmModels.count;
    }else{
        return self.notificationNewsModels.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NotificationNewsCell *cell = [NotificationNewsCell notificationCellWithTableView:tableView];
    cell.delegate = self;
    NotificationModel *model = nil;
    if (tableView == self.newsTable) {
        model = self.notificationNewsModels[indexPath.row];
        cell.cellType = 2;
    }else if (tableView == self.systemTable){
        model = self.notificationJtModels[indexPath.row];
        cell.cellType = 0;
    }else if (tableView == self.notifiTable){
        model = self.notificationXmModels[indexPath.row];
        cell.cellType = 1;
    }
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 82.5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NewsDetailViewController *vc = [[NewsDetailViewController alloc] init];
    NotificationModel *model = nil;
    if (tableView == self.newsTable) {
        model = self.notificationNewsModels[indexPath.row];
    }else if (tableView == self.systemTable){
        model = self.notificationJtModels[indexPath.row];
    }else if (tableView == self.notifiTable){
        model = self.notificationXmModels[indexPath.row];
    }
    vc.url = model.url;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - cellDelegate

- (void)notificationNewsCellDidClickReadInfoWithNotificationModel:(NotificationModel *)model{
    NewsReadCountViewController *vc = [[NewsReadCountViewController alloc] init];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UIScrollViewDelegateMethod


#pragma mark - setter && getter

- (UIScrollView *)myScrollView{
    if (_myScrollView == nil) {
        _myScrollView = [[UIScrollView alloc] init];
        _myScrollView.backgroundColor = WhiteColor;
        _myScrollView.showsHorizontalScrollIndicator = NO;
        _myScrollView.contentSize = CGSizeMake(3 * self.view.width, 0);
        _myScrollView.bounces = NO;
        _myScrollView.scrollEnabled = NO;
    }
    return _myScrollView;
}

- (UITableView *)systemTable{
    if (_systemTable == nil) {
        _systemTable = [[UITableView alloc] init];
        _systemTable.delegate = self;
        _systemTable.dataSource = self;
        _systemTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _systemTable;
}

- (UITableView *)notifiTable{
    if (_notifiTable == nil) {
        _notifiTable = [[UITableView alloc] init];
        _notifiTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _notifiTable.delegate = self;
        _notifiTable.dataSource = self;
    }
    return _notifiTable;
}

- (UITableView *)newsTable{
    if (_newsTable == nil) {
        _newsTable = [[UITableView alloc] init];
        _newsTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _newsTable.delegate = self;
        _newsTable.dataSource = self;
    }
    return _newsTable;
}

@end
