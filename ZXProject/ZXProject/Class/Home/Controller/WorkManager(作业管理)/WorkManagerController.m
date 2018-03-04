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

@interface WorkManagerController ()

@property (nonatomic, strong) NotificationBar *topBar;
@property (nonatomic, strong) UITableView *myTable;

@end

@implementation WorkManagerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"作业任务";
    [self setSubViews];
}

- (void)setSubViews{
    [self.view addSubview:self.topBar];
}

#pragma mark - setter && getter

- (NotificationBar *)topBar{
    if (_topBar == nil) {
        CGRect frame = CGRectMake(0, 0, self.view.width, 60);
        _topBar = [NotificationBar notificationBarWithItems:@[@"我的草稿",@"未完成",@"已完成",@"全部"] andFrame:frame];
    }
    return _topBar;
}

@end
