//
//  AttenceRecoderController.m
//  ZXProject
//
//  Created by Me on 2018/4/6.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "AttenceRecoderController.h"
#import "GobHeaderFile.h"
#import "AttenceRecoderView.h"
#import <Masonry.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>


@interface AttenceRecoderController ()

@property (nonatomic, strong) AttenceRecoderView *workView;
@property (nonatomic, strong) AttenceRecoderView *offView;



@property (nonatomic, strong) UIView *lineView;

@end

@implementation AttenceRecoderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"考勤记录";
    [self setupSubViews];
}

- (void)setupSubViews{
    __weak typeof(self) weakself = self;
    [self.view addSubview:self.workView];
    [self.view addSubview:self.lineView];
    [self.view addSubview:self.offView];
    [self.workView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.top.equalTo(weakself.view.mas_top);
        make.height.mas_equalTo((weakself.view.height - 1 - 64) * 0.5);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.top.equalTo(weakself.workView.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    [self.offView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.top.equalTo(weakself.lineView.mas_bottom);
        make.bottom.equalTo(weakself.view.mas_bottom);
    }];
}

#pragma mark - setter && getter

- (AttenceRecoderView *)workView{
    if (_workView == nil) {
        _workView = [AttenceRecoderView attenceRecoderViewWithModel:self.model andType:1];
    }
    return _workView;
}

- (AttenceRecoderView *)offView{
    if (_offView == nil) {
        _offView = [AttenceRecoderView attenceRecoderViewWithModel:self.model andType:2];
    }
    return _offView;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = UIColorWithFloat(239);
    }
    return _lineView;
}



@end
