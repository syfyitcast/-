//
//  ManagerViewController.m
//  ZXProject
//
//  Created by Me on 2018/2/8.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "ManagerViewController.h"
#import "GobHeaderFile.h"
#import "SettingViewCell.h"
#import "HttpClient.h"
#import <Masonry.h>
#import "LoginViewController.h"
#import "MainNavigationController.h"

@interface ManagerViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *models;
@property (nonatomic, strong) FButton *logoutBtn;

@end

@implementation ManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.view.backgroundColor = UIColorWithRGB(240, 240, 240);
    self.navigationItem.leftBarButtonItem = nil;
    [self setupSubViews];
}

- (void)setupSubViews{
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.logoutBtn];
    __weak typeof(self) weakself = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.top.equalTo(weakself.view.mas_top);
        make.height.mas_equalTo(340);
    }];
    [self.logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.top.equalTo(weakself.tableView.mas_bottom).offset(40);
        make.height.mas_equalTo(44);
    }];
    
}

- (void)clickLogoOutAction{
    ZXSHOW_LOADING(self.view, @"退出登录中...")
    [HttpClient zx_httpClientToLogoutWithUserName:[UserManager sharedUserManager].user.loginname andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
        ZXHIDE_LOADING
        if (code == 0) {//登出成功
            [[UserManager sharedUserManager] deleteAccessToken];//删除token
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            window.rootViewController = [[MainNavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
        }else{
            if (message.length != 0) {
                [MBProgressHUD showError:message];
            }else{
                [MBProgressHUD showError:[NSString stringWithFormat:@"code = %d 登出异常",code]];
            }
        }
    }];
}

#pragma mark - UITableViewDelegate && DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 3;
    }else if (section == 2){
        return 3;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SettingViewCell *cell = [SettingViewCell settingViewCellWithTableView:tableView];
    cell.title =  self.models[indexPath.section][indexPath.row];
    cell.backgroundColor = WhiteColor;
    if (indexPath.section == 0) {
        [cell hideBottomLine];
    }else{
        if (indexPath.row == 2) {
            [cell hideBottomLine];
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = UIColorWithFloat(239);
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

#pragma mark setter && getter

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorWithRGB(239, 239, 239);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}

- (NSArray *)models{
    if (_models == nil) {
        _models = @[@[@"新消息提醒"],@[@"帮助与反馈",@"版本更新",@"关于APP"],@[@"功能添加",@"上传图片大小",@"手势密码设置"]];
    }
    return _models;
}

- (FButton *)logoutBtn{
    if (_logoutBtn == nil) {
        _logoutBtn = [FButton fbtnWithFBLayout:FBLayoutTypeTextFull andPadding:0];
        [_logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [_logoutBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        [_logoutBtn addTarget:self action:@selector(clickLogoOutAction) forControlEvents:UIControlEventTouchUpInside];
        _logoutBtn.backgroundColor = BTNBackgroudColor;
    }
    return _logoutBtn;
}

@end
