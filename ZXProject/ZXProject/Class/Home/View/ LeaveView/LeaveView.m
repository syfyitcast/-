//
//  LeaveView.m
//  ZXProject
//
//  Created by Me on 2018/3/2.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "LeaveView.h"
#import <Masonry.h>
#import "GobHeaderFile.h"

@interface LeaveView()

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *startLabel;
@property (weak, nonatomic) IBOutlet UILabel *endLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *reasonLabel;
@property (weak, nonatomic) IBOutlet UITextView *reasonTextView;
@property (weak, nonatomic) IBOutlet UILabel *approvLabel;

@property (nonatomic, strong) FButton *typeBtn;
@property (nonatomic, strong) FButton *startBtn;
@property (nonatomic, strong) FButton *endBtn;
@property (nonatomic, strong) FButton *apprvoBtn;
@property (nonatomic, strong) UITextField *timeField;

@property (nonatomic, strong) FButton *saveBtn;
@property (nonatomic, strong) FButton *submitBtn;

@end

@implementation LeaveView



+ (instancetype)leaveView{
    LeaveView *view = [[NSBundle mainBundle] loadNibNamed:@"LeaveView" owner:nil options:nil].lastObject;
    return view;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.reasonTextView.layer.borderWidth = 1;
    self.reasonTextView.layer.borderColor = UIColorWithFloat(239).CGColor;
    [self setupSubViews];
}

- (void)setupSubViews{
    [self addSubview:self.typeBtn];
    [self addSubview:self.startBtn];
    [self addSubview:self.endBtn];
    [self addSubview:self.timeField];
    [self addSubview:self.apprvoBtn];
    [self addSubview:self.saveBtn];
    [self addSubview:self.submitBtn];
    __weak typeof(self) weakself = self;
    [self.typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.typeLabel.mas_right).offset(15);
        make.centerY.equalTo(weakself.typeLabel.mas_centerY);
        make.right.equalTo(weakself.mas_right).offset(-30);
        make.height.mas_equalTo(30);
    }];
    [self.startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.startLabel.mas_right).offset(15);
        make.centerY.equalTo(weakself.startLabel.mas_centerY);
        make.right.equalTo(weakself.mas_right).offset(-30);
        make.height.mas_equalTo(30);
    }];
    [self.endBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.endLabel.mas_right).offset(15);
        make.centerY.equalTo(weakself.endLabel.mas_centerY);
        make.right.equalTo(weakself.mas_right).offset(-30);
        make.height.mas_equalTo(30);
    }];
    [self.timeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.timeLabel.mas_right).offset(15);
        make.centerY.equalTo(weakself.timeLabel.mas_centerY);
        make.right.equalTo(weakself.mas_right).offset(-100);
        make.height.mas_equalTo(30);
    }];
    [self.apprvoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.approvLabel.mas_right).offset(15);
        make.centerY.equalTo(weakself.approvLabel.mas_centerY);
        make.right.equalTo(weakself.mas_right).offset(-100);
        make.height.mas_equalTo(30);
    }];
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.mas_left).offset(60 * kScreenRatioWidth);
        make.bottom.equalTo(weakself.mas_bottom).offset(-30);
        make.size.mas_equalTo(CGSizeMake(100, 44));
    }];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.mas_right).offset(-60 * kScreenRatioWidth);
        make.bottom.equalTo(weakself.mas_bottom).offset(-30);
        make.size.mas_equalTo(CGSizeMake(100, 44));
    }];
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
    }
    return _typeBtn;
}

- (FButton *)startBtn{
    if (_startBtn == nil) {
        _startBtn = [FButton fbtnWithFBLayout:FBLayoutTypeLeftRight andPadding:5];
        _startBtn.layer.borderWidth = 1;
        _startBtn.layer.borderColor = UIColorWithFloat(239).CGColor;
        [_startBtn setTitle:@"2018-01-23 12:30" forState:UIControlStateNormal];
        _startBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_startBtn setTitleColor:UIColorWithFloat(108) forState:UIControlStateNormal];
        [_startBtn setImage:[UIImage imageNamed:@"workFlowCalendar"] forState:UIControlStateNormal];
    }
    return _startBtn;
}

- (FButton *)endBtn{
    if (_endBtn == nil) {
        _endBtn = [FButton fbtnWithFBLayout:FBLayoutTypeLeftRight andPadding:5];
        _endBtn.layer.borderWidth = 1;
        _endBtn.layer.borderColor = UIColorWithFloat(239).CGColor;
        [_endBtn setTitle:@"2018-01-23 16:30" forState:UIControlStateNormal];
        _endBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_endBtn setTitleColor:UIColorWithFloat(108) forState:UIControlStateNormal];
        [_endBtn setImage:[UIImage imageNamed:@"workFlowCalendar"] forState:UIControlStateNormal];
    }
    return _endBtn;
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
    }
    return _apprvoBtn;
}

- (UITextField *)timeField{
    if (_timeField == nil) {
        _timeField = [[UITextField alloc] init];
        _timeField.keyboardType = UIKeyboardTypeNumberPad;
        _timeField.layer.borderColor = UIColorWithFloat(239).CGColor;
        _timeField.layer.borderWidth = 1;
        _timeField.backgroundColor = WhiteColor;
    }
    return _timeField;
}

- (FButton *)saveBtn{
    if (_saveBtn == nil) {
        _saveBtn = [FButton fbtnWithFBLayout:FBLayoutTypeTextFull andPadding:0];
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _saveBtn.backgroundColor = UIColorWithFloat(239);
        _saveBtn.layer.cornerRadius = 6;
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
    }
    return _submitBtn;
}



@end
