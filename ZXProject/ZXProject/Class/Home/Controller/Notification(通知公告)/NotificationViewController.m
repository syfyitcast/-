//
//  NotificationViewController.m
//  ZXProject
//
//  Created by Me on 2018/2/25.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "NotificationViewController.h"
#import "GobHeaderFile.h"
#import "NotificationBar.h"
#import "NotificationNewsModel.h"
#import "NotificationNewsCell.h"
#import "NewsDetailViewController.h"
#import "HttpClient.h"
#import "UserManager.h"

@interface NotificationViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,NotificationBarDelegate>

@property (nonatomic, strong) NotificationBar *topBar;
@property (nonatomic, strong) UIScrollView *myScrollView;

@property (nonatomic, strong) UITableView *systemTable;
@property (nonatomic, strong) UITableView *notifiTable;
@property (nonatomic, strong) UITableView *newsTable;

@property (nonatomic, strong) NSArray *notificationNewsModels;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    self.title = @"通知公告";
    [self setSubViews];
    [self networkRequest];
}

- (void)networkRequest{
    User *user = [UserManager sharedUserManager].user;
    [HttpClient zx_getAppNoticeinfoWithProjectid:user.projectids andEmployedId:user.employerid andPublishType:@"0" andpublishLevel:@"1" andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
        
    }];
}

- (void)setSubViews{
    CGRect topBarFrame = CGRectMake(0, 0, self.view.width, 60);
    self.topBar = [NotificationBar notificationBarWithItems:@[@"系统消息",@"通知公告",@"新闻资讯"] andFrame:topBarFrame];
    self.topBar.delegate = self;
    [self.view addSubview:self.topBar];
    self.myScrollView.x = 0;
    self.myScrollView.y = 60;
    self.myScrollView.width = self.view.width;
    self.myScrollView.height = self.view.height - 60;
    [self.view addSubview:self.myScrollView];
    self.systemTable.frame = CGRectMake(0, 0, self.view.width, self.myScrollView.height);
    self.notifiTable.frame = CGRectMake(self.view.width, 0, self.view.width, self.myScrollView.height);
    self.newsTable.frame = CGRectMake(self.view.width * 2, 0, self.view.width, self.myScrollView.height);
    [self.myScrollView addSubview:self.systemTable];
    [self.myScrollView addSubview:self.notifiTable];
    [self.myScrollView addSubview:self.newsTable];
}

- (void)notificationBarDidTapIndexLabel:(NSInteger)index{
    self.myScrollView.contentOffset = CGPointMake(index * self.view.width, 0);
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.newsTable) {
        NotificationNewsCell *cell = [NotificationNewsCell notificationCellWithTableView:tableView];
        cell.model = self.notificationNewsModels[indexPath.row];
        return cell;
    }
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.newsTable) {
        return 82.5;
    }
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == self.newsTable) {
        NewsDetailViewController *vc = [[NewsDetailViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - UIScrollViewDelegateMethod


#pragma mark - setter && getter

- (UIScrollView *)myScrollView{
    if (_myScrollView == nil) {
        _myScrollView = [[UIScrollView alloc] init];
        _myScrollView.backgroundColor = WhiteColor;
        _myScrollView.showsHorizontalScrollIndicator = NO;
        _myScrollView.contentSize = CGSizeMake(3 * self.view.width, 0);
        _myScrollView.bounces = NO;
        _myScrollView.scrollEnabled = NO;
    }
    return _myScrollView;
}

- (UITableView *)systemTable{
    if (_systemTable == nil) {
        _systemTable = [[UITableView alloc] init];
        _systemTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _systemTable;
}

- (UITableView *)notifiTable{
    if (_notifiTable == nil) {
        _notifiTable = [[UITableView alloc] init];
        _notifiTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _notifiTable;
}

- (UITableView *)newsTable{
    if (_newsTable == nil) {
        _newsTable = [[UITableView alloc] init];
        _newsTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _newsTable.delegate = self;
        _newsTable.dataSource = self;
    }
    return _newsTable;
}

- (NSArray *)notificationNewsModels{
    if (_notificationNewsModels == nil) {
        NSArray *source_arr = @[
                                @{
                                    @"imageName":@"newsIcon",
                                    @"title":@"日方借赈灾之名制造\"一中一台\"",
                                    @"des":@"问我们注意到,日前,台湾花莲发生地震后,日...",
                                    @"time":@"17/12/27"
                                    },
                                @{
                                  @"imageName":@"newsIcon",
                                  @"title":@"日方借赈灾之名制造\"一中一台\"",
                                  @"des":@"问我们注意到,日前,台湾花莲发生地震后,日...",
                                  @"time":@"17/12/27",
                                  },
                                @{
                                    @"imageName":@"newsIcon",
                                    @"title":@"日方借赈灾之名制造\"一中一台\"",
                                    @"des":@"问我们注意到,日前,台湾花莲发生地震后,日...",
                                    @"time":@"17/12/27"
                                    }
                                ];
        _notificationNewsModels = [NotificationNewsModel notificationNewsModelsWithSource_arr:source_arr];
    }
    return _notificationNewsModels;
}

@end
