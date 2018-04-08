//
//  WorkTaskDetailController.m
//  ZXProject
//
//  Created by Me on 2018/3/9.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "WorkTaskDetailController.h"
#import "WorkTaskAddImagePickView.h"
#import "GobHeaderFile.h"


@interface WorkTaskDetailController ()

@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) WorkTaskAddImagePickView *pickView;

@property (nonatomic, strong) UIView *lineOne;
@property (nonatomic, strong) UILabel *desLabel;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton  *VoiceBtn;
@property (nonatomic, strong) UIView *lineTwo;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIView *lineThree;
@property (nonatomic, strong) UILabel *positionLabel;
@property (nonatomic, strong) UIView *lineFour;
@property (nonatomic, strong) UILabel *localHandlerLabel;
@property (nonatomic, strong) UIView *lineFive;

@property (nonatomic, strong) UILabel *dutyRegionLabel;
@property (nonatomic, strong) UILabel *dutyPersonLabel;

@end

@implementation WorkTaskDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"作业详情";
    [self setSubViews];
}

- (void)setSubViews{
    self.mainScrollView.frame = self.view.bounds;
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.pickView];
    [self.mainScrollView addSubview:self.lineOne];
    [self.mainScrollView addSubview:self.desLabel];
    [self.mainScrollView addSubview:self.textView];
    [self.mainScrollView addSubview:self.VoiceBtn];
    [self.mainScrollView addSubview:self.lineTwo];
    [self.mainScrollView addSubview:self.timeLabel];
    [self.mainScrollView addSubview:self.lineThree];
    [self.mainScrollView addSubview:self.positionLabel];
    [self.mainScrollView addSubview:self.lineFour];
    [self.mainScrollView addSubview:self.localHandlerLabel];
    [self.mainScrollView addSubview:self.lineFive];
    [self.mainScrollView addSubview:self.dutyRegionLabel];
    [self.mainScrollView addSubview:self.dutyPersonLabel];
    self.lineOne.x = 0;
    self.lineOne.y = CGRectGetMaxY(self.pickView.frame);
    self.lineOne.width = self.view.width;
    self.lineOne.height = 1;
    self.desLabel.x = 15;
    self.desLabel.y = CGRectGetMaxY(self.lineOne.frame) + 15;
    self.desLabel.width = 100;
    self.desLabel.height = 15;
    self.textView.x = 14;
    self.textView.y = CGRectGetMaxY(self.desLabel.frame) + 10;
    self.textView.width = self.view.width - 30;
    self.textView.height = 80;
    self.lineTwo.x = 0;
    self.lineTwo.y = CGRectGetMaxY(self.textView.frame) + 10;
    self.lineTwo.width = self.view.width;
    self.lineTwo.height = 1;
    self.timeLabel.x  = 15;
    self.timeLabel.y = CGRectGetMaxY(self.lineTwo.frame) + 15;
    self.timeLabel.width = self.view.width - 30;
    self.timeLabel.height = 15;
    self.lineThree.x = 15;
    self.lineThree.y = CGRectGetMaxY(self.timeLabel.frame) + 15;
    self.lineThree.width = self.view.width;
    self.lineThree.height = 1;
    self.positionLabel.x = 15;
    self.positionLabel.y = CGRectGetMaxY(self.lineThree.frame) + 15;
    self.positionLabel.width = self.view.width - 30;
    self.positionLabel.height = 15;
    self.lineFour.x = 15;
    self.lineFour.y = CGRectGetMaxY(self.timeLabel.frame) + 15;
    self.lineFour.width = self.view.width;
    self.lineFour.height = 1;
    self.localHandlerLabel.x = 15;
    self.localHandlerLabel.y = CGRectGetMaxY(self.lineFour.frame) + 15;
    self.localHandlerLabel.width = self.view.width - 30;
    self.localHandlerLabel.height = 15;
    self.lineFive.x = 15;
    self.lineFive.y = CGRectGetMaxY(self.timeLabel.frame) + 15;
    self.lineFive.width = self.view.width;
    self.lineFive.height = 1;
    self.dutyRegionLabel.x = 15;
    self.dutyRegionLabel.y = CGRectGetMaxY(self.lineFive.frame) + 15;
    self.dutyRegionLabel.width = 120;
    self.dutyRegionLabel.height = 15;
    self.dutyPersonLabel.width = 120;
    self.dutyPersonLabel.height = 15;
    
//    [self.lineOne mas_makeConstraints:^(MASConstraintMaker * +make) {
//        make.left.equalTo(weakself.view.mas_left);
//        make.right.equalTo(weakself.view.mas_right);
//        make.top.equalTo(weakself.pickView.mas_bottom);
//        make.height.mas_equalTo(1);
//    }];
//    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakself.view.mas_left).offset(15);
//        make.top.equalTo(weakself.lineOne.mas_bottom).offset(15);
//    }];
//    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakself.desLabel.mas_left);
//        make.right.equalTo(weakself.view.mas_right).offset(-36);
//        make.top.equalTo(weakself.desLabel.mas_bottom).offset(15);
//        make.height.mas_equalTo(80);
//    }];
//    [self.VoiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakself.textView.mas_right).offset(5);
//        make.right.equalTo(weakself.view.mas_right).offset(-3);
//        make.bottom.equalTo(weakself.textView.mas_bottom);
//        make.height.mas_equalTo(26);
//    }];
//    [self.lineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakself.view.mas_left);
//        make.right.equalTo(weakself.view.mas_right);
//        make.top.equalTo(weakself.textView.mas_bottom).offset(15);
//        make.height.mas_equalTo(1);
//    }];
//    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakself.view.mas_left).offset(15);
//        make.top.equalTo(weakself.lineTwo.mas_bottom).offset(15);
//    }];
//    [self.lineThree mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakself.view.mas_left);
//        make.right.equalTo(weakself.view.mas_right);
//        make.top.equalTo(weakself.timeLabel.mas_bottom).offset(15);
//        make.height.mas_equalTo(1);
//    }];
//    [self.positionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakself.view.mas_left).offset(15);
//        make.top.equalTo(weakself.lineThree.mas_bottom).offset(15);
//    }];
    
}

#pragma mark - setter && getter

- (UIScrollView *)mainScrollView{
    if (_mainScrollView == nil) {
        _mainScrollView = [[UIScrollView alloc] init];
        _mainScrollView.backgroundColor = WhiteColor;
        _mainScrollView.showsVerticalScrollIndicator = YES;
        _mainScrollView.bounces = NO;
        if (@available(iOS 11.0, *)) {
            _mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _mainScrollView;
}

- (WorkTaskAddImagePickView *)pickView{
    if (_pickView == nil) {
        _pickView = [WorkTaskAddImagePickView workTaskAddImagePickViewWithFrame:CGRectMake(0, 0, self.view.width, 100)];
    }
    return _pickView;
}

- (UIView *)lineOne{
    if (_lineOne == nil) {
        _lineOne = [[UIView alloc] init];
        _lineOne.backgroundColor = UIColorWithFloat(239);
    }
    return _lineOne;
}

- (UILabel *)desLabel{
    if (_desLabel == nil) {
        _desLabel = [[UILabel alloc] init];
        _desLabel.textColor = UIColorWithFloat(79);
        _desLabel.font = [UIFont systemFontOfSize:15];
        _desLabel.text = @"说明:";
    }
    return _desLabel;
}

- (UITextView *)textView{
    if (_textView == nil) {
        _textView = [[UITextView alloc] init];
        _textView.layer.borderColor = UIColorWithFloat(239).CGColor;
        _textView.layer.borderWidth = 1;
    }
    return _textView;
}

- (UIButton *)VoiceBtn{
    if (_VoiceBtn == nil) {
        _VoiceBtn = [[UIButton alloc] init];
        [_VoiceBtn setBackgroundImage:[UIImage imageNamed:@"voiceIcon"] forState:UIControlStateNormal];
    }
    return _VoiceBtn;
}

- (UIView *)lineTwo{
    if (_lineTwo == nil) {
        _lineTwo = [[UIView alloc] init];
        _lineTwo.backgroundColor = UIColorWithFloat(239);
    }
    return _lineTwo;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = UIColorWithFloat(79);
        _timeLabel.font = [UIFont systemFontOfSize:15];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        _timeLabel.text = [NSString stringWithFormat:@"时间:   %@", [formatter stringFromDate:[NSDate date]]];
    }
    return _timeLabel;
}

- (UIView *)lineThree{
    if (_lineThree == nil) {
        _lineThree = [[UIView alloc] init];
        _lineThree.backgroundColor = UIColorWithFloat(239);
    }
    return _lineThree;
}

- (UILabel *)positionLabel{
    if (_positionLabel == nil) {
        _positionLabel = [[UILabel alloc] init];
        _positionLabel.textColor = UIColorWithFloat(79);
        _positionLabel.font = [UIFont systemFontOfSize:15];
    }
    return _positionLabel;
}

- (UIView *)lineFour{
    if (_lineFour == nil) {
        _lineFour = [[UIView alloc] init];
        _lineFour.backgroundColor = UIColorWithFloat(239);
    }
    return _lineFour;
}

- (UILabel *)localHandlerLabel{
    if (_localHandlerLabel == nil) {
        _localHandlerLabel = [[UILabel alloc] init];
        _localHandlerLabel.textColor = UIColorWithFloat(79);
        _localHandlerLabel.font = [UIFont systemFontOfSize:15];
    }
    return _localHandlerLabel;
}

- (UIView *)lineFive{
    if (_lineFive == nil) {
        _lineFive = [[UIView alloc] init];
        _lineFive.backgroundColor = UIColorWithFloat(239);
    }
    return _lineFive;
}

- (UILabel *)dutyRegionLabel{
    if (_dutyRegionLabel == nil) {
        _dutyRegionLabel = [[UILabel alloc] init];
        _dutyRegionLabel.textColor = UIColorWithFloat(79);
        _dutyRegionLabel.font = [UIFont systemFontOfSize:15];
        ;
//        _dutyRegionLabel.text = [NSString stringWithFormat:@"责任区:  %@",self.pointRegionDict[@"regionname"]?self.pointRegionDict[@"regionname"]:@"清扫1班"];
    }
    return _dutyRegionLabel;
}

- (UILabel *)dutyPersonLabel{
    if (_dutyPersonLabel == nil) {
        _dutyPersonLabel = [[UILabel alloc] init];
        _dutyPersonLabel.textColor = UIColorWithFloat(79);
        _dutyPersonLabel.font = [UIFont systemFontOfSize:15];
        _dutyPersonLabel.textAlignment = NSTextAlignmentRight;
//        _dutyPersonLabel.text = [NSString stringWithFormat:@"责任人:  %@",self.pointRegionDict[@"regionname"]?self.pointRegionDict[@"employername"]:@"小王"];
    }
    return _dutyPersonLabel;
}

@end
