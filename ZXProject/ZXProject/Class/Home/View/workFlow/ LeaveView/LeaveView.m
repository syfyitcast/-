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

@property (weak, nonatomic) IBOutlet UILabel *approvLabel;
@property (weak, nonatomic) IBOutlet UILabel *flowLabel;

@property (nonatomic, strong) FButton *typeBtn;
@property (nonatomic, strong) FButton *startBtn;
@property (nonatomic, strong) FButton *endBtn;
@property (nonatomic, strong) FButton *apprvoBtn;
@property (nonatomic, strong) FButton *selectApprvoBtn;
@property (nonatomic, strong) UILabel *meassgeNotiLabel;
@property (nonatomic, strong) FButton *flowBtn;

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
    [self addSubview:self.selectApprvoBtn];
    [self addSubview:self.meassgeNotiLabel];
    [self addSubview:self.saveBtn];
    [self addSubview:self.submitBtn];
    [self addSubview:self.flowBtn];
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
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    [self.flowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.flowLabel.mas_right).offset(15);
        make.centerY.equalTo(weakself.flowLabel.mas_centerY);
        make.right.equalTo(weakself.mas_right).offset(-15);
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

- (void)clickMeassageAction{
    self.selectApprvoBtn.selected = !self.selectApprvoBtn.selected;
    
}

- (void)clickAction:(FButton *)btn{
    NSInteger index = btn.tag;
    if (self.delegate && [self.delegate respondsToSelector:@selector(leaveViewDidClickBtnIndex:andView:andfbButton:)]) {
        if (btn.tag == 4) {
            [self.apprvoBtn setTitle:@"请选择" forState:UIControlStateNormal];
        }
        [self.delegate leaveViewDidClickBtnIndex:index andView:self andfbButton:btn];
    }
}


#pragma mark - setter && getter

- (void)setModel:(WorkFlowModel *)model{
    _model = model;
    
    
}

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

- (FButton *)startBtn{
    if (_startBtn == nil) {
        _startBtn = [FButton fbtnWithFBLayout:FBLayoutTypeLeftRight andPadding:5];
        _startBtn.layer.borderWidth = 1;
        _startBtn.layer.borderColor = UIColorWithFloat(239).CGColor;
        NSDate *date = [NSDate date];
        NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        [_startBtn setTitle:[dateformatter stringFromDate:date] forState:UIControlStateNormal];
        _startBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_startBtn setTitleColor:UIColorWithFloat(108) forState:UIControlStateNormal];
        [_startBtn setImage:[UIImage imageNamed:@"workFlowCalendar"] forState:UIControlStateNormal];
        [_startBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _startBtn.tag = 1;
    }
    return _startBtn;
}

- (FButton *)endBtn{
    if (_endBtn == nil) {
        _endBtn = [FButton fbtnWithFBLayout:FBLayoutTypeLeftRight andPadding:5];
        _endBtn.layer.borderWidth = 1;
        _endBtn.layer.borderColor = UIColorWithFloat(239).CGColor;
        NSDate *date = [NSDate date];
        NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        [_endBtn setTitle:[dateformatter stringFromDate:date] forState:UIControlStateNormal];
        _endBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_endBtn setTitleColor:UIColorWithFloat(108) forState:UIControlStateNormal];
        [_endBtn setImage:[UIImage imageNamed:@"workFlowCalendar"] forState:UIControlStateNormal];
        [_endBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _endBtn.tag = 2;
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
        [_apprvoBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _apprvoBtn.tag = 3;
    }
    return _apprvoBtn;
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
        _flowBtn.tag = 4;
    }
    return _flowBtn;
}

- (UITextField *)timeField{
    if (_timeField == nil) {
        _timeField = [[UITextField alloc] init];
        _timeField.keyboardType = UIKeyboardTypeNumberPad;
        _timeField.textColor = UIColorWithFloat(118);
        _timeField.font = [UIFont systemFontOfSize:13];
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
        _saveBtn.backgroundColor = BTNBackgroudColor;
        _saveBtn.layer.cornerRadius = 6;
        [_saveBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _saveBtn.tag = 5;
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
        _submitBtn.tag = 6;
    }
    return _submitBtn;
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



@end
