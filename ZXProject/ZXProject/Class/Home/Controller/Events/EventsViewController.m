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
    [HttpClient zx_httpClientToGetProjectEventsWithProjectId:[ProjectManager sharedProjectManager].currentProjectid andEventsStatus:@"0" andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
        if (code == 0) {
           
        }
    }];
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
