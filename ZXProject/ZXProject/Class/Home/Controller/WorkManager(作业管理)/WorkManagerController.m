//
//  WorkManagerController.m
//  ZXProject
//
//  Created by Me on 2018/3/4.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "WorkManagerController.h"
#import "NotificationBar.h"
#import "GobHeaderFile.h"
#import "HttpClient.h"
#import <Masonry.h>
#import "WorkTaskModel.h"
#import "WorkTaskCell.h"
#import "WorkTaskAddImagePickView.h"
#import "WorkTaskAddController.h"
#import "ProjectManager.h"
#import "WorkTaskDetailController.h"


@interface WorkManagerController ()<UITableViewDelegate,UITableViewDataSource,NotificationBarDelegate>

@property (nonatomic, strong) NotificationBar *topBar;
@property (nonatomic, strong) UITableView *myTable;
@property (nonatomic, strong) UIView *bottomBar;

@property (nonatomic, strong) NSMutableArray *unfinishedmodels;
@property (nonatomic, strong) NSMutableArray *finishedModels;
@property (nonatomic, strong) NSMutableArray *draftModels;
@property (nonatomic, strong) NSMutableArray *allModels;
@property (nonatomic, assign) int currentype;

@property (nonatomic, strong) FButton *addEventBtn;

@end

@implementation WorkManagerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentype = 1;
    self.title = @"作业任务";
    self.view.backgroundColor = WhiteColor;
    [self setSubViews];
    [self setNetWorkRequest];
    [self.topBar bottomLineMoveWithIndex:1];
}

- (void)setNetWorkRequest{
    ZXSHOW_LOADING(self.view, @"加载中...");
    // 调度组
    dispatch_group_t group = dispatch_group_create();
    // 队列
    dispatch_queue_t queue = dispatch_queue_create("zj", DISPATCH_QUEUE_CONCURRENT);
    // 将任务添加到队列和调度组
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        [HttpClient zx_httpClientToGetProjectEventsWithProjectId:[ProjectManager sharedProjectManager].currentProjectid andEventsStatus:@"0" andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
            if (code == 0) {
                NSArray *source_arr = data[@"getprojectevents"];
                self.unfinishedmodels = [WorkTaskModel workTaskModelsWithSource_arr:source_arr];
            }
            dispatch_group_leave(group);
        }];
    });
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        [HttpClient zx_httpClientToGetProjectEventsWithProjectId:[ProjectManager sharedProjectManager].currentProjectid andEventsStatus:@"2" andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
            if (code == 0) {
                NSArray *source_arr = data[@"getprojectevents"];
                self.finishedModels = [WorkTaskModel workTaskModelsWithSource_arr:source_arr];
            }
             dispatch_group_leave(group);
        }];
    });
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        [HttpClient zx_httpClientToGetProjectEventsWithProjectId:[ProjectManager sharedProjectManager].currentProjectid andEventsStatus:@"99" andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
            if (code == 0) {
                NSArray *source_arr = data[@"getprojectevents"];
                self.draftModels = [WorkTaskModel workTaskModelsWithSource_arr:source_arr];
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
        [tem_arr addObjectsFromArray:self.unfinishedmodels];
        [tem_arr addObjectsFromArray:self.finishedModels];
        self.allModels = tem_arr;
        [self.myTable reloadData];
    });
}

- (void)setSubViews{
    [self.view addSubview:self.topBar];
    [self.view addSubview:self.myTable];
    [self.view addSubview:self.addEventBtn];
    __weak typeof(self) weakself = self;
    [self.myTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.top.equalTo(weakself.topBar.mas_bottom);
        make.height.mas_equalTo(460);
    }];
    [self.addEventBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.view.mas_centerX);
        make.bottom.equalTo(weakself.view.mas_bottom).offset(-15);
        make.size.mas_equalTo(weakself.addEventBtn.currentImage.size);
    }];
}

- (void)notificationBarDidTapIndexLabel:(NSInteger)index{
    if (self.currentype == index) return;
    self.currentype = (int)index;
    [self.myTable reloadData];
}

#pragma mark - UITableviewDelegate && dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.currentype == 0) {
        return self.draftModels.count;
    }else if (self.currentype == 1){
        return self.unfinishedmodels.count;
    }else if (self.currentype == 2){
        return self.finishedModels.count;
    }else{
        return self.allModels.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WorkTaskCell *cell = [WorkTaskCell workTaskCellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.currentype == 0) {
        cell.model = self.draftModels[indexPath.row];
    }else if (self.currentype == 1){
        cell.model = self.unfinishedmodels[indexPath.row];
    }else if (self.currentype == 2){
        cell.model = self.finishedModels[indexPath.row];
    }else{
        cell.model = self.allModels[indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 115;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WorkTaskModel *model = nil;
    if (self.currentype == 0) {//草稿
       model = self.draftModels[indexPath.row];
    }else if (self.currentype == 1){
        model = self.unfinishedmodels[indexPath.row];
    }else if (self.currentype == 2){
        model = self.finishedModels[indexPath.row];
    }else if (self.currentype == 3){
        model = self.allModels[indexPath.row];
    }
    WorkTaskDetailController *vc = [[WorkTaskDetailController alloc] init];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        WorkTaskModel *model = nil;
        if (self.currentype == 0) {
            [self.draftModels removeObjectAtIndex:indexPath.row];
            model = [self.draftModels objectAtIndex:indexPath.row];
        }else if (self.currentype == 1){
            [self.unfinishedmodels removeObjectAtIndex:indexPath.row];
             model = [self.unfinishedmodels objectAtIndex:indexPath.row];
        }else if (self.currentype == 2){
            [self.finishedModels removeObjectAtIndex:indexPath.row];
            model = [self.finishedModels objectAtIndex:indexPath.row];
        }else{
            model = [self.allModels objectAtIndex:indexPath.row];
            [self.unfinishedmodels removeObject:model];
            [self.finishedModels removeObject:model];
            [self.draftModels removeObject:model];
        }
        if (model) {
            [self.allModels removeObject:model];
        }
        [self.myTable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}



- (void)clickAddBtn{
    WorkTaskAddController *addVc = [[WorkTaskAddController alloc] init];
    [self.navigationController pushViewController:addVc animated:YES];
}

#pragma mark - setter && getter

- (NotificationBar *)topBar{
    if (_topBar == nil) {
        CGRect frame = CGRectMake(0, 0, self.view.width, 60);
        _topBar = [NotificationBar notificationBarWithItems:@[@"我的草稿",@"未完成",@"已完成",@"全部"] andFrame:frame];
        _topBar.backgroundColor = WhiteColor;
        _topBar.delegate = self;
      
    }
    return _topBar;
}

- (UITableView *)myTable{
    if (_myTable == nil) {
        _myTable = [[UITableView alloc] init];
        _myTable.backgroundColor = WhiteColor;
        _myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTable.delegate = self;
        _myTable.dataSource = self;
    }
    return _myTable;
}

- (FButton *)addEventBtn{
    if (_addEventBtn == nil) {
        _addEventBtn = [FButton fbtnWithFBLayout:FBLayoutTypeImageFull andPadding:0];
        [_addEventBtn setImage:[UIImage imageNamed:@"addEvent"] forState:UIControlStateNormal];
        [_addEventBtn addTarget:self action:@selector(clickAddBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addEventBtn;
}

@end
