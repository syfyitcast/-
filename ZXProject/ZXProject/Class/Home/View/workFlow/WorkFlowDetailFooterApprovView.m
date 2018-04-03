//
//  WorkFlowDetailFooterApprovView.m
//  ZXProject
//
//  Created by 刘清 on 2018/4/3.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "WorkFlowDetailFooterApprovView.h"
#import "GobHeaderFile.h"
#import <Masonry.h>
#import "WorkFlowDetailItemView.h"

@interface WorkFlowDetailFooterApprovView()<WorkFlowApprovItemViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;


@property (weak, nonatomic) IBOutlet UILabel *nextStepLabel;
@property (weak, nonatomic) IBOutlet UILabel *nextStepPersonLabel;

@property (nonatomic, strong) FButton *nextStepBtn;
@property (nonatomic, strong) FButton *nextStepPersonBtn;

@property (nonatomic, strong) FButton *backBtn;
@property (nonatomic, strong) FButton *submitBtn;

@end

@implementation WorkFlowDetailFooterApprovView

+ (instancetype)workFlowDetailFooterApprovView{
    return [[NSBundle mainBundle] loadNibNamed:@"WorkFlowDetailFooterApprovView" owner:nil options:nil].lastObject;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.reasonTextView.layer.borderColor = UIColorWithFloat(239).CGColor;
    self.reasonTextView.layer.borderWidth = 1;
     __weak typeof(self)  weakself = self;
    [self addSubview:self.nextStepBtn];
    [self.nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.nextStepLabel.mas_centerY);
        make.left.equalTo(weakself.nextStepLabel.mas_right).offset(20);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(180);
    }];
    [self addSubview:self.nextStepPersonBtn];
    [self.nextStepPersonBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.nextStepPersonLabel.mas_centerY);
        make.left.equalTo(weakself.nextStepPersonLabel.mas_right).offset(20);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(180);
    }];
    [self addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.mas_left).offset(60 * kScreenRatioWidth);
        make.bottom.equalTo(weakself.mas_bottom).offset(-30);
        make.size.mas_equalTo(CGSizeMake(100, 44));
    }];
    [self addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.mas_right).offset(-60 * kScreenRatioWidth);
        make.bottom.equalTo(weakself.mas_bottom).offset(-30);
        make.size.mas_equalTo(CGSizeMake(100, 44));
    }];
}

- (void)setApprovItem{
    //第一个item是申请人
    WorkFlowDetailItemView *item_0 = [WorkFlowDetailItemView workFlowDetailItemView];
    item_0.model = self.submitModel;
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 2 * 58.5 ) / 3.0;
    CGFloat height = 100;
    item_0.x = 0;
    item_0.y = 0;
    item_0.width = width;
    item_0.height = height;
    [self.myScrollView addSubview:item_0];
    UIImageView *imageView_0 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apprvoFlowAworr"]];
    imageView_0.x = CGRectGetMaxX(item_0.frame);
    imageView_0.width = 58.5;
    imageView_0.height = 28.5;
    imageView_0.y = (self.myScrollView.height - imageView_0.height) * 0.5;
    [self.myScrollView addSubview:imageView_0];
    for (int i = 1; i <= self.models.count; i ++) {
        if (i == self.models.count) {
            WorkFlowDetailItemView *item = [WorkFlowDetailItemView workFlowDetailEndItemView];
            item.x = CGRectGetMaxX(imageView_0.frame) + (i - 1) * (width + 58.5);
            item.y = 0;
            item.height = height;
            item.width = width;
            [self.myScrollView addSubview:item];
            self.myScrollView.contentSize = CGSizeMake(CGRectGetMaxX(item.frame), 0);
            break;
        }
        WorkFlowApprovModel *model = self.models[i];
        WorkFlowDetailItemView *item = [WorkFlowDetailItemView workFlowDetailItemView];
        item.model = model;
        item.x = CGRectGetMaxX(imageView_0.frame) + (i - 1) * (width + 58.5);
        if (model.isCurrentModel) {
            self.myScrollView.contentOffset = CGPointMake(item.x - self.width * 0.5 + width * 0.5  , 0);
        }
        item.y = 0;
        item.height = height;
        item.width = width;
        item.index = i;
        [self.myScrollView addSubview:item];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apprvoFlowAworr"]];
        imageView.x = CGRectGetMaxX(item.frame);
        imageView.y = (self.myScrollView.height - imageView_0.height) * 0.5;
        imageView.width = 58.5;
        imageView.height = 28.5;
        [self.myScrollView addSubview:imageView];
    }
}

- (void)setModels:(NSArray *)models{
    _models = models;
    self.submitModel = models.firstObject;
    for (WorkFlowApprovModel *model in _models) {
        if (model.submittime == 0 || model.submittimeStrin == nil) {
            self.currentModel = model;
            self.currentModel.isCurrentModel = YES;
        }
    }
    [self setApprovItem];
}

- (void)clickAction:(FButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(WorkFlowApprovDetailViewDidClickIndex:andBtn:andView:)]) {
        [self.delegate WorkFlowApprovDetailViewDidClickIndex:(int)btn.tag andBtn:btn andView:self];
    }
}

#pragma make setter && getter


- (FButton *)nextStepBtn{
    if (_nextStepBtn == nil) {
        _nextStepBtn = [FButton fbtnWithFBLayout:FBLayoutTypeRight andPadding:5];
        _nextStepBtn.layer.borderWidth = 1;
        [_nextStepBtn setTitle:@"请选择" forState:UIControlStateNormal];
        _nextStepBtn.layer.borderColor = UIColorWithFloat(239).CGColor;
        _nextStepBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_nextStepBtn setTitleColor:UIColorWithFloat(108) forState:UIControlStateNormal];
        [_nextStepBtn setImage:[UIImage imageNamed:@"rightArrow"] forState:UIControlStateNormal];
        [_nextStepBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _nextStepBtn.tag = 1;
    }
    return _nextStepBtn;
}

- (FButton *)nextStepPersonBtn{
    if (_nextStepPersonBtn == nil) {
        _nextStepPersonBtn = [FButton fbtnWithFBLayout:FBLayoutTypeRight andPadding:5];
        _nextStepPersonBtn.layer.borderWidth = 1;
        [_nextStepPersonBtn setTitle:@"请选择" forState:UIControlStateNormal];
        _nextStepPersonBtn.layer.borderColor = UIColorWithFloat(239).CGColor;
        _nextStepPersonBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_nextStepPersonBtn setTitleColor:UIColorWithFloat(108) forState:UIControlStateNormal];
        [_nextStepPersonBtn setImage:[UIImage imageNamed:@"rightArrow"] forState:UIControlStateNormal];
        [_nextStepPersonBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _nextStepPersonBtn.tag = 2;
    }
    return _nextStepPersonBtn;
}

- (FButton *)backBtn{
    if (_backBtn == nil) {
        _backBtn = [FButton fbtnWithFBLayout:FBLayoutTypeTextFull andPadding:0];
        [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [_backBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _backBtn.backgroundColor = UIColorWithFloat(239);
        _backBtn.layer.cornerRadius = 6;
        [_backBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _backBtn.tag = 4;
    }
    return _backBtn;
}

- (FButton *)submitBtn{
    if (_submitBtn == nil) {
        _submitBtn = [FButton fbtnWithFBLayout:FBLayoutTypeTextFull andPadding:0];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _submitBtn.backgroundColor = BTNBackgroudColor;
        _submitBtn.layer.cornerRadius = 6;
        [_submitBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _submitBtn.tag = 3;
    }
    return _submitBtn;
}

@end
