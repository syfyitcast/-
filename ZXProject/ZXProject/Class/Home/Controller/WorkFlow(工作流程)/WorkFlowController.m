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


@interface WorkFlowController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NotificationBar *topBar;
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) UIView *bottomBar;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) FButton *addButton;
@property (nonatomic, strong) NSMutableArray *unFnishedModels;

@end

@implementation WorkFlowController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"工作流程";
    [self setSubViews];
    [self networkRequest];
}

- (void)networkRequest{
    ZXSHOW_LOADING(self.view, @"加载中...");
    User *user = [UserManager sharedUserManager].user;
    [HttpClient zx_httpClientToDutyEventlistWithProjectid:[ProjectManager sharedProjectManager].currentProjectid andEmployerid:user.employerid andFlowTaskStatus:@"0" andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
        ZXHIDE_LOADING;
        if (code == 0) {
            NSArray *datas = data[@"event"];
            self.unFnishedModels = [WorkFlowModel workFlowModelsWithSource_arr:datas];
            [self.myTableView reloadData];
        }else{
            if (message.length != 0) {
                [MBProgressHUD showMessage:message];
            }else{
                [MBProgressHUD showError:[NSString stringWithFormat:@"Code = %d 请求错误",code]];
            }
        }
    }];
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

#pragma mark - UITableViewDelegate && UITabelViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.unFnishedModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WorkFlowCell *cell = [WorkFlowCell workFlowCellWithTableView:tableView];
    cell.model = self.unFnishedModels[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 115;
}

#pragma  mark - setter && getter

- (NotificationBar *)topBar{
    if (_topBar == nil) {
        CGRect frame = CGRectMake(0, 0, self.view.width, 50);
        _topBar = [NotificationBar notificationBarWithItems:@[@"我的草稿",@"未完成",@"已完成",@"待办事项"] andFrame:frame];
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
