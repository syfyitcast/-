//
//  RecordView.m
//  ZXProject
//
//  Created by 刘清 on 2018/4/10.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "RecordView.h"
#import "GobHeaderFile.h"
#import <Masonry.h>
#import "ZXRecoderVideoManager.h"

@interface RecordView()<ZXRecordVideoManagerDelegate>

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIImageView *videoConutView;
@property (nonatomic, strong) UILabel *desLabel;

@property (nonatomic, strong) UILabel *longPressLabel;

@property (nonatomic, strong) ZXRecoderVideoManager *manager;

@property (nonatomic, assign) BOOL isCancelled;


@end

@implementation RecordView

+ (instancetype)recordViewWithFrame:(CGRect)frame{
    RecordView *recordView = [[RecordView alloc] initWithFrame:frame];
    recordView.backgroundColor = UIColorWithFloat(68);
    recordView.layer.cornerRadius = 12;
    recordView.manager.delegate = recordView;
    [recordView setSubViews];
    return recordView;
}

- (void)setSubViews{
     __weak typeof(self)  weakself = self;
    [self addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.mas_centerX);
        make.centerY.equalTo(weakself.mas_centerY).offset(-32);
    }];
    [self addSubview:self.videoConutView];
    [self.videoConutView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.iconImageView.mas_right).offset(10);
        make.bottom.equalTo(weakself.iconImageView.mas_bottom);
    }];
    [self addSubview:self.longPressLabel];
    [self.longPressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.mas_left).offset(10);
        make.right.equalTo(weakself.mas_right).offset(-10);
        make.bottom.equalTo(weakself.mas_bottom).offset(-10);
        make.height.mas_equalTo(44);
    }];
    [self addSubview:self.desLabel];
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.mas_centerX);
        make.bottom.mas_equalTo(weakself.longPressLabel.mas_top).offset(-30);
    }];
}

- (void)longPressAction:(UILongPressGestureRecognizer *)longPress{
    CGPoint point;
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan://开始录音
            [ZXRecoderVideoManager startRecordVideo];//开始
            self.longPressLabel.text = @"松开结束";
            self.desLabel.text = @"手指上滑,取消发送";
            self.desLabel.hidden = NO;
            break;
        case UIGestureRecognizerStateChanged://手指移动
            point = [longPress locationInView:self.longPressLabel];
            if (point.y < -10) {
                self.isCancelled = YES;
                self.desLabel.text = @"松开手指，取消发送";
                self.iconImageView.image = [UIImage imageNamed:@"chexiao"];
                self.videoConutView.hidden = YES;
                self.desLabel.backgroundColor = [UIColor redColor];
            }else{
                self.isCancelled = NO;
                self.desLabel.text = @"手指上滑,取消发送";
                self.iconImageView.image = [UIImage imageNamed:@"yuyin"];
                self.videoConutView.hidden = NO;
                self.desLabel.backgroundColor = [UIColor clearColor];
            }
            break;
        case UIGestureRecognizerStateEnded: {
            [ZXRecoderVideoManager stopRecordVideo];
            if (self.isCancelled) {
                self.manager.recordFileUrl = nil;
                [ZXRecoderVideoManager deleteFile];//删除文件
            }
            self.desLabel.hidden = YES;
            self.longPressLabel.text = @"长按录音";
            self.desLabel.backgroundColor = [UIColor clearColor];
            self.iconImageView.image = [UIImage imageNamed:@"yuyin"];
            self.videoConutView.hidden = NO;
            self.videoConutView.image = nil;
            [self endRecord];
            break;
        }
        case UIGestureRecognizerStateFailed: {
        
            break;
        }
        default:
            break;
    }
}

- (void)endRecord{
    if (self.isCancelled) {
        return;
    }else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(recordViewDidEndRecord)]) {
            [self.delegate recordViewDidEndRecord];
        }
    }
}


- (void)zx_RecordVideoManagerReturnVideoCount:(float)count{
    if (0<count<=0.27) {
        self.videoConutView.image = [UIImage imageNamed:@"yinjie（1）"];
    }else if (0.27<count<=0.34) {
        self.videoConutView.image = [UIImage imageNamed:@"yinjie（2）"];
    }else if (0.34<count<=0.41) {
        self.videoConutView.image = [UIImage imageNamed:@"yinjie（3）"];
    }else if (0.41<count<=0.48) {
        self.videoConutView.image = [UIImage imageNamed:@"yinjie（4）"];
    }else if (0.48<count<=0.55) {
        self.videoConutView.image = [UIImage imageNamed:@"yinjie（5）"];
    }else if (0.55<count) {
        self.videoConutView.image = [UIImage imageNamed:@"yinjie（6）"];
    }
}

#pragma mark - setter && getter

- (ZXRecoderVideoManager *)manager{
    if (_manager == nil) {
        _manager = [ZXRecoderVideoManager sharedRecoderManager];
    }
    return _manager;
}

- (UIImageView *)iconImageView{
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yuyin"]];
    }
    return _iconImageView;
}

- (UIImageView *)videoConutView{
    if (_videoConutView == nil) {
        _videoConutView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    }
    return _videoConutView;
}

- (UILabel *)longPressLabel{
    if (_longPressLabel == nil) {
        _longPressLabel = [[UILabel alloc] init];
        _longPressLabel.backgroundColor = BTNBackgroudColor;
        _longPressLabel.textColor = WhiteColor;
        _longPressLabel.text = @"长按录音";
        _longPressLabel.textAlignment = NSTextAlignmentCenter;
        _longPressLabel.layer.cornerRadius = 12;
        _longPressLabel.clipsToBounds = YES;
        _longPressLabel.userInteractionEnabled = YES;
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        longPress.minimumPressDuration = 0.2;
        [_longPressLabel addGestureRecognizer:longPress];
    }
    return _longPressLabel;
}

- (UILabel *)desLabel{
    if (_desLabel == nil) {
        _desLabel = [[UILabel alloc] init];
        _desLabel.textAlignment = NSTextAlignmentCenter;
        _desLabel.textColor = WhiteColor;
        _desLabel.hidden = YES;
        _desLabel.font = [UIFont systemFontOfSize:13];
        _desLabel.layer.cornerRadius = 6;
        _desLabel.clipsToBounds = YES;
    }
    return _desLabel;
}

@end
