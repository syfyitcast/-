//
//  HomeViewController.m
//  ZXProject
//
//  Created by Me on 2018/2/8.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "HomeViewController.h"
#import "MainTabBarController.h"
#import "GobHeaderFile.h"
#import <Masonry.h>
#import "HomeHeaderView.h"
#import "HomeCollectionView.h"
#import "HomeLeftTableViewCell.h"
#import "HomeRightItems.h"
#import "HomeRightTableViewCell.h"
#import "WorkFlowController.h"
#import "AttendanceController.h"
#import "PersonInfoController.h"
#import "WorkManagerController.h"
#import "UserLocationManager.h"


@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,HomeHeaderViewDelegate,HomeCollectionViewDelegate>

@property (nonatomic, strong) UIScrollView *mainScollview;
@property (nonatomic, strong) HomeHeaderView *headerView;
@property (nonatomic, strong) HomeCollectionView *collectionView;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UITableView *bottomTable;
@property (nonatomic, strong) UITableView *leftTable;
@property (nonatomic, strong) UITableView *rightTable;
@property (nonatomic, strong) UIView *coverView;

@property (nonatomic, strong) NSArray *headerLeftItems;
@property (nonatomic, strong) NSArray *headerRightItems;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    self.title = @"首页";
    [self setSubviews];
    self.navigationController.navigationBar.hidden = YES;
    [[UserLocationManager sharedUserLocationManager] reverseGeocodeLocationWithAdressBlock:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    MainTabBarController *mTabBar = (MainTabBarController *)self.tabBarController;
    [mTabBar showTabBar];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)setSubviews{
    __weak typeof(self) weakself = self;
    self.headerView = [HomeHeaderView homeHeaderView];
    self.headerView.delegate = self;
    [self.view addSubview:self.mainScollview];
    [self.mainScollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakself.view);
        make.width.mas_equalTo(weakself.view.width);
    }];
    [self.mainScollview addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.view.mas_top);
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.height.mas_equalTo(232);
    }];
    [self.mainScollview addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.top.equalTo(weakself.headerView.mas_bottom);
        make.height.mas_equalTo(94 * 3);
    }];
}

#pragma mark - HomeHeaderViewDelegateMethod

- (void)homeHeaderViewDidClickLeftBtn{
    self.coverView.frame = self.view.bounds;
    [self.view addSubview:self.coverView];
    self.leftTable.frame = CGRectMake(5, 65, 100, 170);
    [self.view addSubview:self.leftTable];
}

- (void)homeHeaderViewDidClickRightBtn{
    self.coverView.frame = self.view.bounds;
    [self.view addSubview:self.coverView];
    self.rightTable.frame = CGRectMake(self.view.width - 5 - 160 , 65, 160, 160);
    [self.view addSubview:self.rightTable];
}

- (void)homeHeadeerViewDidClickIconView{
    PersonInfoController *infoVc = [[PersonInfoController alloc] init];
    [self.navigationController pushViewController:infoVc animated:YES];
}

- (void)clickCoverView{
    [self.coverView removeFromSuperview];
    if (self.leftTable) {
        [self.leftTable removeFromSuperview];
    }
    if (self.rightTable) {
        [self.rightTable removeFromSuperview];
    }
}

#pragma mark - HomeCollectionViewDelegateMethod

- (void)homeCollectionViewDidClickBtnIndex:(NSInteger)index{
    NSString *controllerName = self.items[index];
    Class class =  NSClassFromString(controllerName);
    id controller = [[class alloc] init];
    if (controller != nil) {
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark - TableView DataSource && Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.leftTable) {
        return self.headerLeftItems.count;
    }else if (tableView == self.rightTable){
        return self.headerRightItems.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTable) {
        HomeLeftTableViewCell *cell = [HomeLeftTableViewCell homeLeftTableViewCellWithTableView:tableView];
        cell.title = self.headerLeftItems[indexPath.row];
        return cell;
    }else if(tableView == self.rightTable){
        HomeRightTableViewCell *cell = [HomeRightTableViewCell homeRightTableViewCellWithTable:tableView];
        cell.item = self.headerRightItems[indexPath.row];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTable) {
        return 34;
    }else if (tableView == self.rightTable){
        return 40;
    }
    return 0;
}

#pragma mark - setter && getter

- (UIScrollView *)mainScollview{
    if (_mainScollview == nil) {
        _mainScollview = [[UIScrollView alloc] init];
        _mainScollview.showsVerticalScrollIndicator = NO;
        _mainScollview.backgroundColor = UIColorWithRGB(240, 240, 240);
        
    }
    return _mainScollview;
}

- (HomeCollectionView *)collectionView{
    if (_collectionView == nil) {
        _collectionView = [HomeCollectionView HomeCollectionViewWithItems:self.items andFrame:CGRectMake(0, 0, self.view.width, 94 * 3)];
        _collectionView.backgroundColor = WhiteColor;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

- (NSArray *)items{
    if (_items == nil) {
        _items = @[@"NotificationViewController",@"WorkFlowController",@"AttendanceController",@"WorkManagerController",@"onFoucsController",@"onFoucsController",@"onFoucsController",@"onFoucsController",@"onFoucsController",@"onFoucsController",@"onFoucsController",@"onFoucsController"];
    }
    return _items;
}

- (UITableView *)bottomTable{
    if (_bottomTable == nil) {
        _bottomTable = [[UITableView alloc] init];
        _bottomTable.delegate = self;
    }
    return _bottomTable;
}

- (UITableView *)leftTable{
    if (_leftTable == nil) {
        _leftTable = [[UITableView alloc]  init];
        _leftTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _leftTable.backgroundColor = WhiteColor;
        _leftTable.dataSource = self;
        _leftTable.delegate = self;
        _leftTable.layer.shadowColor = BlackColor.CGColor;
        _leftTable.layer.shadowOpacity = 0.7;
        _leftTable.layer.shadowOffset = CGSizeMake(1, 1);
        _leftTable.layer.shadowRadius = 3;
        _leftTable.clipsToBounds = NO;
    }
    return _leftTable;
}

- (UITableView *)rightTable{
    if (_rightTable == nil) {
        _rightTable = [[UITableView alloc]  init];
        _rightTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _rightTable.backgroundColor = WhiteColor;
        _rightTable.dataSource = self;
        _rightTable.delegate = self;
        _rightTable.layer.shadowColor = BlackColor.CGColor;
        _rightTable.layer.shadowOpacity = 0.7;
        _rightTable.layer.shadowOffset = CGSizeMake(1, 1);
        _rightTable.layer.shadowRadius = 3;
        _rightTable.layer.borderColor = UIColorWithRGB(200, 200, 200).CGColor;
        _rightTable.layer.borderWidth = 1;
        _rightTable.clipsToBounds = NO;
    }
    return _rightTable;
}

- (UIView *)coverView{
    if (_coverView == nil) {
        _coverView = [[UIView alloc] init];
        _coverView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCoverView)];
        [_coverView addGestureRecognizer:tap];
    }
    return _coverView;
}

- (NSArray *)headerLeftItems{
    if (_headerLeftItems == nil) {
        _headerLeftItems = @[@"石门项目",@"常德项目",@"益阳项目",@"安化项目",@"汉寿项目"];
    }
    return _headerLeftItems;
}

- (NSArray *)headerRightItems{
    if (_headerRightItems == nil) {
        NSArray *source_arr = @[
                                @{
                                    @"imageName":@"homeRightDK",
                                    @"title":@"打卡",
                                    },
                                @{
                                    @"imageName":@"homeRightFlow",
                                    @"title":@"发起流程",
                                    },
                                @{
                                    @"imageName":@"homeRightSS",
                                    @"title":@"扫一扫",
                                    },
                                @{
                                    @"imageName":@"homeRightLogout",
                                    @"title":@"退出",
                                    },
                                ];
        _headerRightItems = [HomeRightItems homeRightItemsWithSource_arr:source_arr];
    }
    return _headerRightItems;
}

@end
