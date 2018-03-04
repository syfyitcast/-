//
//  AttendanceController.m
//  ZXProject
//
//  Created by Me on 2018/2/26.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "AttendanceController.h"
#import "AttenceHeaderView.h"
#import "GobHeaderFile.h"
#import "FButton.h"
#import <Masonry.h>
#import "AttenceTimeView.h"
#import "AttenceDKController.h"

@interface AttendanceController ()

@property (nonatomic, strong) AttenceHeaderView *headerView;
@property (nonatomic, strong) FButton *workBtn;
@property (nonatomic, strong) FButton *offBtn;
@property (nonatomic, strong) UIView *oneLineView;
@property (nonatomic, strong) AttenceTimeView *timeView;
@property (nonatomic, strong) AttenceTimeView *twoTimeView;
@property (nonatomic, strong) UIView *twoLineView;
@property (nonatomic, strong) UIView *threeLineView;


@end

@implementation AttendanceController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"考勤打卡";
    [self setUpSubViews];
}

- (void)setUpSubViews{
    __weak typeof(self) weakself = self;
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.workBtn];
    [self.view addSubview:self.offBtn];
    [self.view addSubview:self.oneLineView];
    [self.view addSubview:self.timeView];
    [self.view addSubview:self.twoLineView];
    [self.view addSubview:self.twoTimeView];
    [self.view addSubview:self.threeLineView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.top.equalTo(weakself.view.mas_top);
        make.height.mas_equalTo(130);
    }];
    CGFloat width = 85;
    CGFloat padding = (self.view.width - width * 2 - 45)*0.5;
    [self.workBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left).offset(padding);
        make.top.equalTo(weakself.headerView.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(width, width));
    }];
    [self.offBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.view.mas_right).offset(-padding);
        make.top.equalTo(weakself.headerView.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(width, width));
    }];
    [self.oneLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.top.equalTo(weakself.workBtn.mas_bottom).offset(20);
        make.height.mas_equalTo(1);
    }];
    [self.timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.top.equalTo(weakself.oneLineView.mas_bottom);
        make.height.mas_equalTo(100);
    }];
    [self.twoLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.top.equalTo(weakself.timeView.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    [self.twoTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.top.equalTo(weakself.twoLineView.mas_bottom);
        make.height.mas_equalTo(100);
    }];
    [self.threeLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.top.equalTo(weakself.twoTimeView.mas_bottom);
        make.height.mas_equalTo(1);
    }];
}


#pragma mark - setter && getter

- (AttenceHeaderView *)headerView{
    if (_headerView == nil) {
        _headerView = [AttenceHeaderView attenceHeaderView];
        __weak typeof(self) weakself = self;
        [_headerView setClickDKBtnBlock:^{
            AttenceDKController *vc = [[AttenceDKController alloc] init];
            [weakself.navigationController pushViewController:vc animated:YES];
        }];
    }
    return _headerView;
}

- (FButton *)workBtn{
    if (_workBtn == nil) {
        _workBtn = [FButton fbtnWithFBLayout:FBLayoutTypeTextFull andPadding:0];
        _workBtn.backgroundColor = UIColorWithRGB(120, 200, 55);
        [_workBtn setTitle:@"上班" forState:UIControlStateNormal];
        [_workBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _workBtn.layer.cornerRadius = 85*0.5;
        
    }
    return _workBtn;
}

- (FButton *)offBtn{
    if (_offBtn == nil) {
        _offBtn = [FButton fbtnWithFBLayout:FBLayoutTypeTextFull andPadding:0];
        [_offBtn  setTitle:@"下班" forState:UIControlStateNormal];
        [_offBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _offBtn.backgroundColor =  UIColorWithRGB(120, 200, 55);
        _offBtn.layer.cornerRadius = 85 *0.5;
    }
    return _offBtn;
}

- (UIView *)oneLineView{
    if (_oneLineView == nil) {
        _oneLineView = [[UIView alloc] init];
        _oneLineView.backgroundColor = UIColorWithRGB(215, 215, 215);
    }
    return _oneLineView;
}

- (AttenceTimeView *)timeView{
    if (_timeView == nil) {
        _timeView = [AttenceTimeView attenceTimeView];
    }
    return _timeView;
}

- (AttenceTimeView *)twoTimeView{
    if (_twoTimeView == nil) {
        _twoTimeView = [AttenceTimeView attenceTimeView];
        [_twoTimeView setType:@"中班"];
    }
    return _twoTimeView;
}

- (UIView *)twoLineView{
    if (_twoLineView == nil) {
        _twoLineView = [[UIView alloc] init];
        _twoLineView.backgroundColor = UIColorWithRGB(215, 215, 215);
    }
    return _twoLineView;
}

- (UIView *)threeLineView{
    if (_threeLineView == nil) {
        _threeLineView = [[UIView alloc] init];
        _threeLineView.backgroundColor =  UIColorWithRGB(215, 215, 215);
    }
    return _threeLineView;
}

@end
