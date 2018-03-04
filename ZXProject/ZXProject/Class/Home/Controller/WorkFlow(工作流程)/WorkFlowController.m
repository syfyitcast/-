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


@interface WorkFlowController ()

@property (nonatomic, strong) NotificationBar *topBar;
@property (nonatomic, strong) NSArray *childViews;
@property (nonatomic, strong) UIView *currentView;
@property (nonatomic, assign) int currentViewIndex;

@end

@implementation WorkFlowController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"工作流程";
    [self setSubViews];
}

- (void)setSubViews{
    [self.view addSubview:self.topBar];
    self.currentView = self.childViews[self.currentViewIndex];
    [self.view addSubview:self.currentView];
    __weak typeof(self) weakself = self;
    [self.currentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.top.equalTo(weakself.topBar.mas_bottom);
        make.bottom.equalTo(weakself.view.mas_bottom);
    }];
    
}

#pragma  mark - setter && getter

- (NotificationBar *)topBar{
    if (_topBar == nil) {
        CGRect frame = CGRectMake(0, 0, self.view.width, 50);
        _topBar = [NotificationBar notificationBarWithItems:@[@"请假",@"出差",@"报销",@"呈报"] andFrame:frame];
    }
    return _topBar;
}

- (NSArray *)childViews{
    if (_childViews == nil) {
        LeaveView *view_0 = [LeaveView leaveView];
        LeaveView *view_1 = [LeaveView leaveView];
        LeaveView *view_2 = [LeaveView leaveView];
        LeaveView *view_3 = [LeaveView leaveView];
        _childViews = @[view_0,view_1,view_2,view_3];
    }
    return _childViews;
}



@end
