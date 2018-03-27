//
//  ReportView.m
//  ZXProject
//
//  Created by 刘清 on 2018/3/26.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "ReportView.h"
#import "GobHeaderFile.h"
#import <Masonry.h>

@interface ReportView()

@property (weak, nonatomic) IBOutlet UILabel *reportTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *approvLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *imagePickView;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UILabel *flowLabel;

@property (nonatomic, strong) FButton *typeBtn;
@property (nonatomic, strong) FButton *apprvoBtn;
@property (nonatomic, strong) FButton *selectApprvoBtn;
@property (nonatomic, strong) UILabel *meassgeNotiLabel;
@property (nonatomic, strong) FButton *flowBtn;

@property (nonatomic, strong) FButton *saveBtn;
@property (nonatomic, strong) FButton *submitBtn;


@end

@implementation ReportView

+ (instancetype)reportView{
    return [[NSBundle mainBundle] loadNibNamed:@"ReportView" owner:nil options:nil].lastObject;
}

- (void)awakeFromNib{
     __weak typeof(self) weakself = self;
    [super awakeFromNib];
    self.contentTextView.layer.borderColor = UIColorWithFloat(239).CGColor;
    self.contentTextView.layer.borderWidth = 1;
    [self addSubview:self.typeBtn];
    [self addSubview:self.apprvoBtn];
    [self addSubview:self.selectApprvoBtn];
    [self addSubview:self.meassgeNotiLabel];
    [self addSubview:self.flowBtn];
    [self addSubview:self.saveBtn];
    [self addSubview:self.submitBtn];
    [self.typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.reportTypeLabel.mas_right).offset(8);
        make.centerY.equalTo(weakself.reportTypeLabel.mas_centerY);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    [self.apprvoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.approvLabel.mas_right).offset(15);
        make.centerY.equalTo(weakself.approvLabel.mas_centerY);
        make.right.equalTo(weakself.mas_right).offset(-130);
        make.height.mas_equalTo(30);
    }];
    [self.selectApprvoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.apprvoBtn.mas_right).offset(15);
        make.centerY.equalTo(weakself.apprvoBtn.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(15,15));
    }];
    [self.meassgeNotiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.selectApprvoBtn.mas_right).offset(8);
        make.centerY.equalTo(weakself.selectApprvoBtn.mas_centerY);
    }];
    [self.flowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.flowLabel.mas_right).offset(15);
        make.centerY.equalTo(weakself.flowLabel.mas_centerY);
        make.right.equalTo(weakself.mas_right).offset(-15);
        make.height.mas_equalTo(30);
    }];
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.mas_left).offset(60 * kScreenRatioWidth);
        make.bottom.equalTo(weakself.mas_bottom).offset(-15);
        make.size.mas_equalTo(CGSizeMake(100, 44));
    }];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.mas_right).offset(-60 * kScreenRatioWidth);
        make.bottom.equalTo(weakself.mas_bottom).offset(-15);
        make.size.mas_equalTo(CGSizeMake(100, 44));
    }];
}

- (void)clickAction:(FButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(reportViewDidClickBtnIndex:andView:andfbButton:)]) {
        [self.delegate reportViewDidClickBtnIndex:btn.tag andView:self andfbButton:btn];
    }
}

- (void)clickMeassageAction{
    self.selectApprvoBtn.selected = !self.selectApprvoBtn.selected;
}

#pragma mark - setter && getter

- (FButton *)typeBtn{
    if (_typeBtn == nil) {
        _typeBtn = [FButton fbtnWithFBLayout:FBLayoutTypeRight andPadding:5];
        _typeBtn.layer.borderWidth = 1;
        [_typeBtn setTitle:@"请选择" forState:UIControlStateNormal];
        _typeBtn.layer.borderColor = UIColorWithFloat(239).CGColor;
        _typeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_typeBtn setTitleColor:UIColorWithFloat(108) forState:UIControlStateNormal];
        [_typeBtn setImage:[UIImage imageNamed:@"rightArrow"] forState:UIControlStateNormal];
        [_typeBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _typeBtn.tag = 0;
    }
    return _typeBtn;
}

- (FButton *)apprvoBtn{
    if (_apprvoBtn == nil) {
        _apprvoBtn = [FButton fbtnWithFBLayout:FBLayoutTypeRight andPadding:5];
        _apprvoBtn.layer.borderWidth = 1;
        [_apprvoBtn setTitle:@"请选择" forState:UIControlStateNormal];
        _apprvoBtn.layer.borderColor = UIColorWithFloat(239).CGColor;
        _apprvoBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_apprvoBtn setTitleColor:UIColorWithFloat(108) forState:UIControlStateNormal];
        [_apprvoBtn setImage:[UIImage imageNamed:@"rightArrow"] forState:UIControlStateNormal];
        [_apprvoBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _apprvoBtn.tag = 4;
    }
    return _apprvoBtn;
}

- (FButton *)selectApprvoBtn{
    if (_selectApprvoBtn == nil) {
        _selectApprvoBtn = [FButton fbtnWithFBLayout:FBLayoutTypeImageFull andPadding:0];
        [_selectApprvoBtn setImage:[UIImage imageNamed:@"eventSelectNomal"]
                          forState:UIControlStateNormal];
        [_selectApprvoBtn setImage:[UIImage imageNamed:@"eventSelectHighted"] forState:UIControlStateSelected];
        [_selectApprvoBtn addTarget:self action:@selector(clickMeassageAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectApprvoBtn;
}

- (UILabel *)meassgeNotiLabel{
    if (_meassgeNotiLabel == nil) {
        _meassgeNotiLabel = [[UILabel alloc] init];
        _meassgeNotiLabel.text = @"短信通知";
        _meassgeNotiLabel.textColor = BlackColor;
        _meassgeNotiLabel.font = [UIFont systemFontOfSize:14];
        _meassgeNotiLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _meassgeNotiLabel;
}

- (FButton *)flowBtn{
    if (_flowBtn == nil) {
        _flowBtn = [FButton fbtnWithFBLayout:FBLayoutTypeRight andPadding:5];
        _flowBtn.layer.borderWidth = 1;
        [_flowBtn setTitle:@"请选择" forState:UIControlStateNormal];
        _flowBtn.layer.borderColor = UIColorWithFloat(239).CGColor;
        _flowBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_flowBtn setTitleColor:UIColorWithFloat(108) forState:UIControlStateNormal];
        [_flowBtn setImage:[UIImage imageNamed:@"rightArrow"] forState:UIControlStateNormal];
        [_flowBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _flowBtn.tag = 3;
    }
    return _flowBtn;
}

- (FButton *)saveBtn{
    if (_saveBtn == nil) {
        _saveBtn = [FButton fbtnWithFBLayout:FBLayoutTypeTextFull andPadding:0];
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _saveBtn.backgroundColor = UIColorWithFloat(239);
        _saveBtn.layer.cornerRadius = 6;
        [_saveBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _saveBtn.tag = 6;
    }
    return _saveBtn;
}

- (FButton *)submitBtn{
    if (_submitBtn == nil) {
        _submitBtn = [FButton fbtnWithFBLayout:FBLayoutTypeTextFull andPadding:0];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _submitBtn.backgroundColor = BTNBackgroudColor;
        _submitBtn.layer.cornerRadius = 6;
        [_submitBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _submitBtn.tag = 7;
    }
    return _submitBtn;
}




@end
