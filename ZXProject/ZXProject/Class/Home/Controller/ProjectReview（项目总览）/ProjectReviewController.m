//
//  ProjectReviewController.m
//  ZXProject
//
//  Created by 刘清 on 2018/3/16.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "ProjectReviewController.h"
#import "NotificationBar.h"
#import "GobHeaderFile.h"
#import "ProjectReviewPersonCell.h"
#import <Masonry.h>


@interface ProjectReviewController ()<NotificationBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NotificationBar *topBar;
@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation ProjectReviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"项目总览";
    [self setupSubViews];
}

- (void)setupSubViews{
    [self.view addSubview:self.topBar];
    [self.view addSubview:self.myTableView];
    __weak typeof(self)  weakself = self;
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.top.equalTo(weakself.topBar.mas_bottom);
        make.bottom.equalTo(weakself.view.mas_bottom);
    }];
}

#pragma mark - UITableViewDelegate && dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProjectReviewPersonCell *cell = [ProjectReviewPersonCell projectReviewPersonCellWithTabelView:tableView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 138;
}

#pragma mark - setter && getter

- (NotificationBar *)topBar{
    if (_topBar == nil) {
        CGRect frame = CGRectMake(0, 0, self.view.width, 60);
        _topBar = [NotificationBar notificationBarWithItems:@[@"人员",@"车辆",@"设施"] andFrame:frame];
        _topBar.backgroundColor = WhiteColor;
        _topBar.delegate = self;
    }
    return _topBar;
}

- (UITableView *)myTableView{
    if (_myTableView == nil) {
        _myTableView = [[UITableView alloc] init];
        _myTableView.backgroundColor = WhiteColor;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}


@end
