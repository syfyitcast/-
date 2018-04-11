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


@interface EventsViewController ()<NotificationBarDelegate>

@property (nonatomic, strong) NotificationBar *topBar;
@property (nonatomic, strong) NSArray *unfnishedModels;
@property (nonatomic, strong) NSArray *finishedModels;
@property (nonatomic, strong) NSArray *draftModels;
@property (nonatomic, strong) NSArray *allModels;

@end

@implementation EventsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"环卫事件";
    [self setSubviews];
}

- (void)setNetworkRequest{
    dispatch_group_t group = dispatch_group_create();
    // 队列
    dispatch_queue_t queue = dispatch_queue_create("zj", DISPATCH_QUEUE_CONCURRENT);
    // 将任务添加到队列和调度组
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        [HttpClient zx_httpClientToGetProjectEventsWithProjectId:[ProjectManager sharedProjectManager].currentProjectid andEventsStatus:@"0" andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
            if (code == 0) {
                NSArray *source_arr = data[@"getprojectevents"];
               // self.unfnishedModels = [WorkTaskModel workTaskModelsWithSource_arr:source_arr];
            }
            dispatch_group_leave(group);
        }];
    });
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        [HttpClient zx_httpClientToGetProjectEventsWithProjectId:[ProjectManager sharedProjectManager].currentProjectid andEventsStatus:@"2" andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
            if (code == 0) {
                NSArray *source_arr = data[@"getprojectevents"];
                //self.finishedModels = [WorkTaskModel workTaskModelsWithSource_arr:source_arr];
            }
            dispatch_group_leave(group);
        }];
    });
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        [HttpClient zx_httpClientToGetProjectEventsWithProjectId:[ProjectManager sharedProjectManager].currentProjectid andEventsStatus:@"99" andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
            if (code == 0) {
                NSArray *source_arr = data[@"getprojectevents"];
               // self.draftModels = [WorkTaskModel workTaskModelsWithSource_arr:source_arr];
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
    });
}

- (void)setSubviews{
    [self.view addSubview:self.topBar];
}

- (void)notificationBarDidTapIndexLabel:(NSInteger)index{
    
}

#pragma mark - setter && getter

- (NotificationBar *)topBar{
    if (_topBar == nil) {
        _topBar = [NotificationBar notificationBarWithItems:@[@"草稿",@"未完成",@"已完成",@"全部"] andFrame:CGRectMake(0, 0, self.view.width, 60)];
        _topBar.delegate = self;
    }
    return _topBar;
}

@end
