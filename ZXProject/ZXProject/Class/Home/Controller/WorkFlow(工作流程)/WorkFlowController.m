//
//  WorkFlowController.m
//  ZXProject
//
//  Created by Me on 2018/2/26.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "WorkFlowController.h"
#import "NotificationBar.h"
#import "GobHeaderFile.h"
#import "LeaveView.h"
#import <Masonry.h>
#import "HttpClient.h"
#import "UserManager.h"
#import "WorkFlowModel.h"
#import "ProjectManager.h"
#import "WorkFlowAddController.h"
#import "WorkFlowCell.h"
#import "HttpClient+DutyEvents.h"
#import "WorkFlowDetailController.h"
#import "WorkFlowDraftViewController.h"


@interface WorkFlowController ()<UITableViewDelegate,UITableViewDataSource,NotificationBarDelegate>

@property (nonatomic, strong) NotificationBar *topBar;
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) UIView *bottomBar;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) FButton *addButton;
@property (nonatomic, strong) NSMutableArray *toComimtModels;
@property (nonatomic, strong) NSMutableArray *fnishedModels;
@property (nonatomic, strong) NSMutableArray *draftModels;
@property (nonatomic, strong) NSMutableArray *unfinishedModels;
@property (nonatomic, strong) NSMutableArray *finishedSelfModels;

@property (nonatomic, assign) int currentIndex;
@property (nonatomic, assign) dispatch_group_t group;


@end

@implementation WorkFlowController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"工作流程";
    self.currentIndex = 1;
    [self setSubViews];
    [self networkRequest];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:NOTIFI_WORKFLOWRELOADDATA object:nil];//刷新数据
}

- (void)refreshData{
    [self networkRequest];
}

- (void)networkRequest{
    User *user = [UserManager sharedUserManager].user;
    ZXSHOW_LOADING(self.view, @"加载中...");
    // 调度组
    dispatch_group_t group = dispatch_group_create();
    self.group = group;
    // 队列
    dispatch_queue_t queue = dispatch_queue_create("zj", DISPATCH_QUEUE_CONCURRENT);
    // 将任务添加到队列和调度组
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        [HttpClient zx_httpClientToDutyEventlistWithProjectid:[ProjectManager sharedProjectManager].currentProjectid andEmployerid:user.employerid andFlowTaskStatus:@"0" andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {//待办
            if (code == 0) {
                NSArray *datas = data[@"flowtask"];
                self.toComimtModels = [WorkFlowModel workFlowModelsWithSource_arr:datas];
                for (WorkFlowModel *model in self.toComimtModels) {
                    model.eventType = 3;
                }
            }else{
                if (message.length != 0) {
                    [MBProgressHUD showError:message];
                }else{
                    [MBProgressHUD showError:[NSString stringWithFormat:@"Code = %d 请求错误",code]];
                }
            }
            dispatch_group_leave(group);
        }];
    });
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        [HttpClient zx_httpClientToDutyEventlistWithProjectid:[ProjectManager sharedProjectManager].currentProjectid andEmployerid:user.employerid andFlowTaskStatus:@"1" andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
            if (code == 0) {
                NSArray *datas = data[@"flowtask"];
                self.fnishedModels = [WorkFlowModel workFlowModelsWithSource_arr:datas];
                for (WorkFlowModel *model in self.fnishedModels) {
                    model.eventType = 2;
                }
            }
            dispatch_group_leave(group);
        }];
    });
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{//未完成
        [HttpClient zx_httpClientToQueryEventListBySelfWithEventStatus:@"1" andFlowtype:@"" andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
            if (code == 0) {
                NSArray *datas = data[@"event"];
                self.unfinishedModels = [WorkFlowModel workFlowModelsWithSource_arr:datas];
                for (WorkFlowModel *model in self.unfinishedModels) {
                    model.eventType = 1;
                }
            }
            dispatch_group_leave(group);
        }];
    });
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{//草稿
        [HttpClient zx_httpClientToQueryEventListBySelfWithEventStatus:@"0" andFlowtype:@"" andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
            if (code == 0) {
                NSArray *datas = data[@"event"];
                self.draftModels = [WorkFlowModel workFlowModelsWithSource_arr:datas];
                for (WorkFlowModel *model in self.draftModels) {
                    model.eventType = 4;
                }
            }
            dispatch_group_leave(group);
        }];
    });
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{//自己发起的已完成
        [HttpClient zx_httpClientToQueryEventListBySelfWithEventStatus:@"2" andFlowtype:@"" andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
            if (code == 0) {
                NSArray *datas = data[@"event"];
                self.finishedSelfModels = [WorkFlowModel workFlowModelsWithSource_arr:datas];
                for (WorkFlowModel *model in self.finishedSelfModels) {
                    model.eventType = 2;
                }
            }
            dispatch_group_leave(group);
        }];
    });
    
    // 异步 : 调度组中的所有异步任务执行结束之后,在这里得到统一的通知
    dispatch_queue_t mQueue = dispatch_get_main_queue();
    dispatch_group_notify(group, mQueue, ^{
        ZXHIDE_LOADING;
        for (WorkFlowModel *model in self.finishedSelfModels) {
            [self.fnishedModels addObject:model];
        }
        [self.myTableView reloadData];
    });
}

- (void)setSubViews{
    [self.view addSubview:self.topBar];
    [self.view addSubview:self.bottomBar];
    [self.bottomBar addSubview:self.bottomLine];
    [self.view addSubview:self.myTableView];
    [self.bottomBar addSubview:self.addButton];
     __weak typeof(self)  weakself = self;
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.top.equalTo(weakself.topBar.mas_bottom);
        make.bottom.equalTo(weakself.view.mas_bottom).offset(-60);
    }];
    [self.bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.bottom.equalTo(weakself.view.mas_bottom);
        make.height.mas_equalTo(60);
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

- (void)clickAddAction{
    WorkFlowAddController *vc = [[WorkFlowAddController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)notificationBarDidTapIndexLabel:(NSInteger)index{
    self.currentIndex = (int)index;
    [self.myTableView reloadData];
}

#pragma mark - UITableViewDelegate && UITabelViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.currentIndex == 0) {
        return self.draftModels.count;
    }else if (self.currentIndex == 3){
        return self.toComimtModels.count;
    }else if (self.currentIndex == 2){
        return self.fnishedModels.count;
    }else if (self.currentIndex == 1){
        return self.unfinishedModels.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WorkFlowCell *cell = [WorkFlowCell workFlowCellWithTableView:tableView];
    WorkFlowModel *model = nil;
    if (self.currentIndex == 0) {
        model = self.draftModels[indexPath.row];
    }else if (self.currentIndex == 3){
        model = self.toComimtModels[indexPath.row];
    }else if (self.currentIndex == 2){
        model = self.fnishedModels[indexPath.row];
    }else if (self.currentIndex == 1){
        model = self.unfinishedModels[indexPath.row];
    }
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WorkFlowDetailController *vc = [[WorkFlowDetailController alloc] init];
    if (self.currentIndex == 0) {//草稿
        WorkFlowModel *model = self.draftModels[indexPath.row];
        WorkFlowDraftViewController *vc = [[WorkFlowDraftViewController alloc] init];
        vc.model = self.draftModels[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }else if (self.currentIndex == 1){
        vc.model = self.unfinishedModels[indexPath.row];
    }else if(self.currentIndex == 2){
        vc.model = self.fnishedModels[indexPath.row];
    }else if (self.currentIndex == 3){
        vc.model = self.toComimtModels[indexPath.row];
    }
    [self.navigationController pushViewController:vc animated:YES];
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}


- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath {
    WorkFlowModel *model = nil;
    if (self.currentIndex == 1) {
        model = self.unfinishedModels[indexPath.row];
    }else if (self.currentIndex == 2){
        model = self.fnishedModels[indexPath.row];
    }else if (self.currentIndex == 3){
        model = self.toComimtModels[indexPath.row];
    }else if (self.currentIndex == 0){
        model = self.draftModels[indexPath.row];
    }
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ZXSHOW_LOADING(self.view, @"删除中...");
        [HttpClient zx_httpClientToDeleteFlowEventWithEventid:model.eventid andFlowtype:model.flowtype andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
            ZXHIDE_LOADING
            if (code == 0) {
                [MBProgressHUD showError:@"删除成功" toView:self.view];
                if (self.currentIndex == 1) {
                    [self.unfinishedModels removeObject:model];
                }else if (self.currentIndex == 2){
                    [self.fnishedModels removeObject:model];
                }else if (self.currentIndex == 3){
                    [self.toComimtModels removeObject:model];
                }else if (self.currentIndex == 0){
                    [self.draftModels removeObject:model];
                }
                [self.myTableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath]
                                      withRowAnimation:UITableViewRowAnimationFade];
                [self.myTableView reloadData];
            }else{
                if (message.length != 0) {
                    [MBProgressHUD showError:message toView:self.view];
                }
            }
        }];
        
    }
}

#pragma  mark - setter && getter

- (NotificationBar *)topBar{
    if (_topBar == nil) {
        CGRect frame = CGRectMake(0, 0, self.view.width, 50);
        _topBar = [NotificationBar notificationBarWithItems:@[@"我的草稿",@"未完成",@"已完成",@"待办事项"] andFrame:frame];
        [_topBar bottomLineMoveWithIndex:1];
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

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFI_WORKFLOWRELOADDATA object:nil];
}


@end
