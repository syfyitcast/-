//
//  EventsViewController.m
//  ZXProject
//
//  Created by 刘清 on 2018/3/27.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "EventsViewController.h"
#import "GobHeaderFile.h"
#import "NotificationBar.h"
#import "ProjectManager.h"
#import "HttpClient+DutyEvents.h"
#import "eventsMdoel.h"
#import "WorkFlowCell.h"
#import <Masonry.h>
#import "WorkTaskCell.h"
#import "AddEventsViewController.h"


@interface EventsViewController ()<NotificationBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NotificationBar *topBar;
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) UIView *bottomBar;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) FButton *addButton;
@property (nonatomic, strong) NSArray *unfnishedModels;
@property (nonatomic, strong) NSArray *finishedModels;
@property (nonatomic, strong) NSArray *draftModels;
@property (nonatomic, strong) NSArray *allModels;

@property (nonatomic, assign) int currentIndex;


@end

@implementation EventsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"环卫事件";
    self.currentIndex = 1;
    [self.topBar bottomLineMoveWithIndex:1];
    [self setNetworkRequest];
    [self setSubviews];
}

- (void)setNetworkRequest{
    ZXSHOW_LOADING(self.view, @"加载中...");
    dispatch_group_t group = dispatch_group_create();
    // 队列
    dispatch_queue_t queue = dispatch_queue_create("zj", DISPATCH_QUEUE_CONCURRENT);
    // 将任务添加到队列和调度组
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        [HttpClient zx_httpClientToGetProjectEventsWithProjectId:[ProjectManager sharedProjectManager].currentProjectid andEventsStatus:@"0" andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
            if (code == 0) {
                NSArray *source_arr = data[@"getprojectevents"];
                self.unfnishedModels = [eventsMdoel eventsModelsWithSource_arr:source_arr];
            }
            dispatch_group_leave(group);
        }];
    });
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        [HttpClient zx_httpClientToGetProjectEventsWithProjectId:[ProjectManager sharedProjectManager].currentProjectid andEventsStatus:@"2" andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
            if (code == 0) {
                NSArray *source_arr = data[@"getprojectevents"];
                self.finishedModels = [eventsMdoel eventsModelsWithSource_arr:source_arr];
            }
            dispatch_group_leave(group);
        }];
    });
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        [HttpClient zx_httpClientToGetProjectEventsWithProjectId:[ProjectManager sharedProjectManager].currentProjectid andEventsStatus:@"99" andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
            if (code == 0) {
                NSArray *source_arr = data[@"getprojectevents"];
                self.draftModels = [eventsMdoel eventsModelsWithSource_arr:source_arr];
            }
            dispatch_group_leave(group);
        }];
    });
    // 异步 : 调度组中的所有异步任务执行结束之后,在这里得到统一的通知
    dispatch_queue_t mQueue = dispatch_get_main_queue();
    dispatch_group_notify(group, mQueue, ^{
        ZXHIDE_LOADING;
        NSMutableArray *tem_arr = [NSMutableArray array];
        [tem_arr addObjectsFromArray:self.draftModels];
        [tem_arr addObjectsFromArray:self.unfnishedModels];
        [tem_arr addObjectsFromArray:self.finishedModels];
        self.allModels = tem_arr;
        [self.myTableView reloadData];
    });
}

- (void)setSubviews{
    __weak typeof(self) weakself = self;
    [self.view addSubview:self.topBar];
    [self.view addSubview:self.myTableView];
    [self.view addSubview:self.bottomBar];
    [self.view addSubview:self.bottomLine];
    [self.view addSubview:self.addButton];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.topBar.mas_bottom);
        make.left.and.right.equalTo(weakself.view);
        make.bottom.equalTo(weakself.view.mas_bottom).offset(-80);
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

- (void)notificationBarDidTapIndexLabel:(NSInteger)index{
    self.currentIndex = (int)index;
    [self.myTableView reloadData];
}

#pragma mark - setter && getter

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.currentIndex == 0) {
        return  [self.draftModels count];
    }else if (self.currentIndex == 3){
        return  [self.allModels count];
    }else if (self.currentIndex == 2){
        return  [self.finishedModels count];
    }else if (self.currentIndex == 1){
        return  [self.unfnishedModels count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WorkTaskCell *cell = [WorkTaskCell workTaskCellWithTableView:tableView];
    eventsMdoel *model = nil;
    if (self.currentIndex == 0) {
        model = self.draftModels[indexPath.row];
    }else if (self.currentIndex == 3){
        model = self.allModels[indexPath.row];
    }else if (self.currentIndex == 2){
        model = self.finishedModels[indexPath.row];
    }else if (self.currentIndex == 1){
        model = self.unfnishedModels[indexPath.row];
    }
    cell.eventModel = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125;
}

#pragma mark - Action

- (void)clickAddAction{
    AddEventsViewController *vc = [[AddEventsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - setter && getter

- (NotificationBar *)topBar{
    if (_topBar == nil) {
        _topBar = [NotificationBar notificationBarWithItems:@[@"草稿",@"未完成",@"已完成",@"全部"] andFrame:CGRectMake(0, 0, self.view.width, 60)];
        _topBar.delegate = self;
    }
    return _topBar;
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
