//
//  EvectionView.m
//  ZXProject
//
//  Created by 刘清 on 2018/3/26.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "EvectionView.h"
#import "GobHeaderFile.h"
#import <Masonry.h>

@interface EvectionView()

@property (nonatomic, strong) UITextField *placeField;
@property (nonatomic, strong) UITextField *desPlaceField;
@property (nonatomic, strong) FButton *startBtn;
@property (nonatomic, strong) FButton *endBtn;
@property (nonatomic, strong) FButton *toolBtn;
@property (nonatomic, strong) FButton *flowBtn;
@property (nonatomic, strong) FButton *approvBtn;
@property (nonatomic, strong) FButton *selectApprvoBtn;

@property (nonatomic, strong) FButton *saveBtn;
@property (nonatomic, strong) FButton *submitBtn;


@property (weak, nonatomic) IBOutlet UILabel *startLabel;
@property (weak, nonatomic) IBOutlet UILabel *endLabel;
@property (weak, nonatomic) IBOutlet UILabel *toolLabel;
@property (weak, nonatomic) IBOutlet UILabel *flowLabel;

@property (weak, nonatomic) IBOutlet UITextView *reasonLabel;
@property (weak, nonatomic) IBOutlet UILabel *approvLabel;
@property (nonatomic, strong) UILabel *meassgeNotiLabel;





@end

@implementation EvectionView

+ (instancetype)evectionView{
    return [[NSBundle mainBundle] loadNibNamed:@"EvectionView" owner:nil options:nil].lastObject;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.reasonLabel.layer.borderColor = UIColorWithFloat(239).CGColor;
    self.reasonLabel.layer.borderWidth = 1;
     __weak typeof(self)  weakself = self;
    [self addSubview:self.placeField];
    [self addSubview:self.desPlaceField];
    [self addSubview:self.startBtn];
    [self addSubview:self.endBtn];
    [self addSubview:self.toolBtn];
    [self addSubview:self.flowBtn];
    [self addSubview:self.approvBtn];
    [self addSubview:self.selectApprvoBtn];
    [self addSubview:self.meassgeNotiLabel];
    [self addSubview:self.saveBtn];
    [self addSubview:self.submitBtn];
    [self.placeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.placeLabel.mas_right).offset(8);
        make.centerY.equalTo(weakself.placeLabel.mas_centerY);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(30);
    }];
    [self.desPlaceField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.desPlaceLabel.mas_right).offset(8);
        make.centerY.equalTo(weakself.desPlaceLabel.mas_centerY);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(30);
    }];
    [self.startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.startLabel.mas_right).offset(8);
        make.centerY.equalTo(weakself.startLabel.mas_centerY);
        make.right.equalTo(weakself.mas_right).offset(-30);
        make.height.mas_equalTo(30);
    }];
    [self.endBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.endLabel.mas_right).offset(8);
        make.centerY.equalTo(weakself.endLabel.mas_centerY);
        make.right.equalTo(weakself.mas_right).offset(-30);
        make.height.mas_equalTo(30);
    }];
    [self.toolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.toolLabel.mas_right).offset(8);
        make.centerY.equalTo(weakself.toolLabel.mas_centerY);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(110);
    }];
    [self.flowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.flowLabel.mas_right).offset(8);
        make.centerY.equalTo(weakself.flowLabel.mas_centerY);
        make.height.mas_equalTo(30);
        make.right.equalTo(weakself.mas_right).offset(-10);
    }];
    [self.approvBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.approvLabel.mas_right).offset(8);
        make.centerY.equalTo(weakself.approvLabel.mas_centerY);
        make.right.equalTo(weakself.mas_right).offset(-130);
        make.height.mas_equalTo(30);
    }];
    [self.selectApprvoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.approvBtn.mas_right).offset(15);
        make.centerY.equalTo(weakself.approvBtn.mas_centerY);
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

- (void)clickAction:(FButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(evectionViewDidClickBtnIndex:andView:andfbButton:)]) {
        [self.delegate evectionViewDidClickBtnIndex:btn.tag andView:self andfbButton:btn];
    }
}

- (void)clickMeassageAction{
    self.selectApprvoBtn.selected = !self.selectApprvoBtn.selected;
}


#pragma mark - setter  && getter

- (UITextField *)placeField{
    if (_placeField == nil) {
        _placeField = [[UITextField alloc] init];
        _placeField.layer.borderWidth = 1;
        _placeField.layer.borderColor = UIColorWithFloat(239).CGColor;
        _placeField.font = [UIFont systemFontOfSize:14];
        
    }
    return _placeField;
}

- (UITextField *)desPlaceField{
    if (_desPlaceField == nil) {
        _desPlaceField = [[UITextField alloc] init];
        _desPlaceField.layer.borderColor = UIColorWithFloat(239).CGColor;
        _desPlaceField.layer.borderWidth = 1;
        _desPlaceField.font = [UIFont systemFontOfSize:14];
    }
    return _desPlaceField;
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

- (FButton *)toolBtn{
    if (_toolBtn == nil) {
        _toolBtn = [FButton fbtnWithFBLayout:FBLayoutTypeRight andPadding:5];
        _toolBtn.layer.borderWidth = 1;
        _toolBtn.layer.borderColor = UIColorWithFloat(239).CGColor;
        [_toolBtn setTitle:@"请选择" forState:UIControlStateNormal];
        _toolBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_toolBtn setTitleColor:UIColorWithFloat(108) forState:UIControlStateNormal];
        [_toolBtn setImage:[UIImage imageNamed:@"rightArrow"] forState:UIControlStateNormal];
        [_toolBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _toolBtn.tag = 3;
    }
    return _toolBtn;
}

- (FButton *)flowBtn{
    if (_flowBtn == nil) {
        _flowBtn = [FButton fbtnWithFBLayout:FBLayoutTypeRight andPadding:5];
        _flowBtn.layer.borderWidth = 1;
        _flowBtn.layer.borderColor = UIColorWithFloat(239).CGColor;
        [_flowBtn setTitle:@"请选择" forState:UIControlStateNormal];
        _flowBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_flowBtn setTitleColor:UIColorWithFloat(108) forState:UIControlStateNormal];
        [_flowBtn setImage:[UIImage imageNamed:@"rightArrow"] forState:UIControlStateNormal];
        [_flowBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _flowBtn.tag = 4;
    }
    return _flowBtn;
}

- (FButton *)approvBtn{
    if (_approvBtn == nil) {
        _approvBtn= [FButton fbtnWithFBLayout:FBLayoutTypeRight andPadding:5];
        _approvBtn.layer.borderWidth = 1;
        [_approvBtn setTitle:@"请选择" forState:UIControlStateNormal];
        _approvBtn.layer.borderColor = UIColorWithFloat(239).CGColor;
        _approvBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_approvBtn setTitleColor:UIColorWithFloat(108) forState:UIControlStateNormal];
        [_approvBtn setImage:[UIImage imageNamed:@"rightArrow"] forState:UIControlStateNormal];
        [_approvBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _approvBtn.tag = 5;
    }
    return _approvBtn;
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
