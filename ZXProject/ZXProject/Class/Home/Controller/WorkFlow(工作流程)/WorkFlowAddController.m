//
//  WorkFlowAddController.m
//  ZXProject
//
//  Created by 刘清 on 2018/3/22.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "WorkFlowAddController.h"
#import "NotificationBar.h"
#import "GobHeaderFile.h"
#import "LeaveView.h"
#import <Masonry.h>

@interface WorkFlowAddController ()<NotificationBarDelegate>

@property (nonatomic, strong)  NotificationBar *topBar;
@property (nonatomic, strong) UIView *currentView;
@property (nonatomic, strong) NSArray *chidViews;

@end

@implementation WorkFlowAddController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发起流程";
    [self.view addSubview:self.topBar];
    self.currentView = [LeaveView leaveView];
    [self setupSubViews];
}

- (void)setupSubViews{
     __weak typeof(self)  weakself = self;
    [self.view addSubview:self.currentView];
    [self.currentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.topBar.mas_bottom);
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.bottom.equalTo(weakself.view.mas_bottom);
    }];
}

- (void)notificationBarDidTapIndexLabel:(NSInteger)index{
    
}

#pragma mark - setter & getter

- (NotificationBar *)topBar{
    if (_topBar == nil) {
        _topBar = [NotificationBar notificationBarWithItems:@[@"请假",@"出差",@"报销",@"呈报"] andFrame: CGRectMake(0, 0, self.view.width, 50)];
        _topBar.delegate = self;
    }
    return _topBar;
}

@end
