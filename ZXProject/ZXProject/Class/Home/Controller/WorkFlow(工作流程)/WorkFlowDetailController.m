//
//  WorkFlowDetailController.m
//  ZXProject
//
//  Created by 刘清 on 2018/3/29.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "WorkFlowDetailController.h"
#import <Masonry.h>
#import "GobHeaderFile.h"
#import "WorkFlowDetailFooterView.h"
#import "HttpClient+DutyEvents.h"
#import "WorkFlowDetailModel.h"

@interface WorkFlowDetailController ()

@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) WorkFlowDetailFooterView *footerView;
@property (nonatomic, strong) WorkFlowDetailModel *detailModel;

@end

@implementation WorkFlowDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"流程详情";
    [self setRequestNetWork];
}

- (void)setRequestNetWork{
    ZXSHOW_LOADING(self.view, @"加载中...");
    [HttpClient zx_httpClientToQueryDutyEventsWithEventId:self.model.eventid andFlowType:self.model.flowtype andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
        if (code == 0) {
            self.detailModel = [WorkFlowDetailModel workFlowDetailModelWithDict:data];
            [HttpClient zx_httpClientToQueryEventFlowTasklistWithEventid:self.detailModel.eventid andflowtype:self.detailModel.flowtype andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {//查询审核人
                if (code == 0) {
                    
                }
            }];
            [self setSubViews];
        }else{
            if (message.length != 0) {
                [MBProgressHUD showError:message toView:self.view];
            }
        }
    }];
}

- (void)setSubViews{
     __weak typeof(self)  weakself = self;
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakself.view);
    }];
    UIImageView *contentImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"approFlowRect"]];
    [self.mainScrollView addSubview:contentImageView];
    [contentImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left).offset(15);
        make.top.equalTo(weakself.view.mas_top).offset(15);
        make.size.mas_equalTo(CGSizeMake(14, 16));
    }];
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.text = @"内容";
    contentLabel.textColor = UIColorWithFloat(33);
    contentLabel.font = [UIFont systemFontOfSize:14];
    [self.mainScrollView addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentImageView.mas_right).offset(10);
        make.centerY.equalTo(contentImageView.mas_centerY);
    }];
    UIView *lineOne = [[UIView alloc] init];
    lineOne.backgroundColor = UIColorWithFloat(239);
    [self.mainScrollView addSubview:lineOne];
    [lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.bottom.equalTo(contentImageView.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
    }];
    if (self.model.flowtype == 1) {//请假
        UILabel *eventTypeLabel = [[UILabel alloc] init];
        eventTypeLabel.textColor = UIColorWithFloat(49);
        
    }else if (self.model.flowtype ==4){//出差
        
    }else if (self.model.flowtype == 2){//报销
        
    }else if (self.model.flowtype == 3){//呈报
        
    }
    [self.mainScrollView addSubview:self.footerView];
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.bottom.equalTo(weakself.view.mas_bottom);
        make.height.mas_equalTo(420);
    }];
}

#pragma mark - setter && getter

- (UIScrollView *)mainScrollView{
    if (_mainScrollView == nil) {
        _mainScrollView = [[UIScrollView alloc] init];
        _mainScrollView.backgroundColor = WhiteColor;
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.bounces = NO;
    }
    return _mainScrollView;
}

- (WorkFlowDetailFooterView *)footerView{
    if (_footerView == nil) {
        _footerView = [WorkFlowDetailFooterView workFlowDetailFooterView];
    }
    return _footerView;
}


@end
