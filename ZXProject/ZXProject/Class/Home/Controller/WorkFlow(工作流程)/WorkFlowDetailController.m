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
#import "WorkFlowApprovModel.h"

@interface WorkFlowDetailController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) WorkFlowDetailFooterView *footerView;
@property (nonatomic, strong) WorkFlowDetailModel *detailModel;
@property (nonatomic, strong) NSArray *approvModels;

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
                ZXHIDE_LOADING;
                if (code == 0) {
                    self.approvModels = [WorkFlowApprovModel workFlowApprovModelsWithSource_arr:data];
                    [self setSubViews];
                }else{
                    if (message.length != 0) {
                        [MBProgressHUD showError:message toView:self.view];
                    }
                }
            }];
            
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
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.top.equalTo(weakself.view.mas_top);
        make.bottom.equalTo(weakself.view.mas_bottom);
    }];
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = WhiteColor;
    [self.mainScrollView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakself.mainScrollView);
        make.width.equalTo(weakself.mainScrollView);
        make.height.equalTo(weakself.view);
    }];
    UIImageView *contentImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"approFlowRect"]];
    [contentView addSubview:contentImageView];
    [contentImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left).offset(15);
        make.top.equalTo(weakself.view.mas_top).offset(15);
        make.size.mas_equalTo(CGSizeMake(14, 16));
    }];
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.text = @"内容";
    contentLabel.textColor = UIColorWithFloat(33);
    contentLabel.font = [UIFont systemFontOfSize:14];
    [contentView addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentImageView.mas_right).offset(10);
        make.centerY.equalTo(contentImageView.mas_centerY);
    }];
    UIView *lineOne = [[UIView alloc] init];
    lineOne.backgroundColor = UIColorWithFloat(239);
    [contentView addSubview:lineOne];
    [lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.bottom.equalTo(contentImageView.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
    }];
    [contentView addSubview:self.footerView];
    if (self.model.flowtype == 1) {//请假
        UILabel *eventTypeLabel = [[UILabel alloc] init];
        eventTypeLabel.textColor = UIColorWithFloat(49);
        eventTypeLabel.font = [UIFont systemFontOfSize:13];
        NSString *evetTypeStr = nil;
        switch (self.detailModel.dutytype) {
            case 0:
                evetTypeStr = @"放假";
                break;
            case 1:
                evetTypeStr = @"事假";
                break;
            case 2:
                evetTypeStr = @"病假";
                break;
            case 3:
                evetTypeStr = @"带薪假";
                break;
            default:
                break;
        }
        eventTypeLabel.text = [NSString stringWithFormat:@"请假类型:  %@",evetTypeStr];
        [contentView addSubview:eventTypeLabel];
        [eventTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakself.view.mas_left).offset(15);
            make.top.equalTo(lineOne.mas_bottom).offset(15);
            make.height.mas_equalTo(15);
        }];
        UIView *lineTwo = [[UIView alloc] init];
        lineTwo.backgroundColor = UIColorWithFloat(239);
        [contentView addSubview:lineTwo];
        [lineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakself.view.mas_left);
            make.right.equalTo(weakself.view.mas_right);
            make.bottom.equalTo(eventTypeLabel.mas_bottom).offset(15);
            make.height.mas_equalTo(1);
        }];
        UILabel *beginLabel = [[UILabel alloc] init];
        beginLabel.textColor = UIColorWithFloat(49);
        beginLabel.font = [UIFont systemFontOfSize:13];
        beginLabel.text = [NSString stringWithFormat:@"开始时间:  %@",self.detailModel.beginTimeString];
        [contentView addSubview:beginLabel];
        [beginLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakself.view.mas_left).offset(15);
            make.top.equalTo(lineTwo.mas_bottom).offset(15);
            make.height.mas_equalTo(15);
        }];
        UIView *lineThree = [[UIView alloc] init];
        lineThree.backgroundColor = UIColorWithFloat(239);
        [contentView addSubview:lineThree];
        [lineThree mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakself.view.mas_left);
            make.right.equalTo(weakself.view.mas_right);
            make.bottom.equalTo(beginLabel.mas_bottom).offset(15);
            make.height.mas_equalTo(1);
        }];
        UILabel *endLabel = [[UILabel alloc] init];
        endLabel.textColor = UIColorWithFloat(49);
        endLabel.font = [UIFont systemFontOfSize:13];
        endLabel.text = [NSString stringWithFormat:@"结束时间:  %@",self.detailModel.endTimeString];
        [contentView addSubview:endLabel];
        [endLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakself.view.mas_left).offset(15);
            make.top.equalTo(lineThree.mas_bottom).offset(15);
            make.height.mas_equalTo(15);
        }];
        UIView *lineFour = [[UIView alloc] init];
        lineFour.backgroundColor = UIColorWithFloat(239);
        [contentView addSubview:lineFour];
        [lineFour mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakself.view.mas_left);
            make.right.equalTo(weakself.view.mas_right);
            make.bottom.equalTo(endLabel.mas_bottom).offset(15);
            make.height.mas_equalTo(1);
        }];
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.textColor = UIColorWithFloat(49);
        timeLabel.font = [UIFont systemFontOfSize:13];
        timeLabel.text = [NSString stringWithFormat:@"时长:     %@",self.detailModel.timeString];
        [contentView addSubview: timeLabel];
        [timeLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakself.view.mas_left).offset(15);
            make.top.equalTo(lineFour.mas_bottom).offset(15);
            make.height.mas_equalTo(15);
        }];
        UIView *lineFive = [[UIView alloc] init];
        lineFive.backgroundColor = UIColorWithFloat(239);
        [contentView addSubview:lineFive];
        [lineFive mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakself.view.mas_left);
            make.right.equalTo(weakself.view.mas_right);
            make.bottom.equalTo(timeLabel.mas_bottom).offset(15);
            make.height.mas_equalTo(1);
        }];
        UILabel *reasonDesLabel = [[UILabel alloc] init];
        reasonDesLabel.textColor = UIColorWithFloat(49);
        reasonDesLabel.font = [UIFont systemFontOfSize:13];
        reasonDesLabel.text = @"事由:";
        [contentView addSubview:reasonDesLabel];
        [reasonDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakself.view.mas_left).offset(15);
            make.top.equalTo(lineFive.mas_bottom).offset(15);
            make.height.mas_equalTo(15);
        }];
        UITextView *reasonTextView = [[UITextView alloc] init];
        reasonTextView.editable = NO;
        reasonTextView.font = [UIFont systemFontOfSize:13];
        reasonTextView.textColor = UIColorWithFloat(119);
        reasonTextView.layer.borderColor = UIColorWithFloat(239).CGColor;
        reasonTextView.layer.borderWidth = 1;
        reasonTextView.text = self.detailModel.eventremark;
        [contentView addSubview:reasonTextView];
        [reasonTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakself.view.mas_left).offset(15);
            make.right.equalTo(weakself.view.mas_right).offset(-15);
            make.top.equalTo(reasonDesLabel.mas_bottom).offset(10);
            make.height.mas_equalTo(80);
        }];
        UIView *lineSix= [[UIView alloc] init];
        lineSix.backgroundColor = UIColorWithFloat(239);
        [contentView addSubview:lineSix];
        [lineSix mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakself.view.mas_left);
            make.right.equalTo(weakself.view.mas_right);
            make.bottom.equalTo(reasonTextView.mas_bottom).offset(10);
            make.height.mas_equalTo(1);
        }];
        [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakself.view.mas_left);
            make.right.equalTo(weakself.view.mas_right);
            make.top.equalTo(lineSix.mas_bottom);
            make.height.mas_equalTo(420);
        }];
//        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(weakself.footerView.mas_bottom).offset(30);
//        }];

    }else if (self.model.flowtype ==4){//出差

    }else if (self.model.flowtype == 2){//报销

    }else if (self.model.flowtype == 3){//呈报

    }
    [self.view layoutIfNeeded];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.mainScrollView.contentSize = CGSizeMake(0, 1000);
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"123");
}

#pragma mark - setter && getter

- (UIScrollView *)mainScrollView{
    if (_mainScrollView == nil) {
        _mainScrollView = [[UIScrollView alloc] init];
        _mainScrollView.backgroundColor = WhiteColor;
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.bounces = NO;
        _mainScrollView.delegate = self;
        if (@available(iOS 11.0, *)) {
            _mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
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
