//
//  RecordPlayView.m
//  ZXProject
//
//  Created by 刘清 on 2018/4/11.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "RecordPlayView.h"
#import <Masonry.h>
#import "UIImage+NotStrech.h"
#import "ZXRecoderVideoManager.h"

@interface RecordPlayView()

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIImageView *animationImageView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, assign) BOOL isPlaying;


@property (nonatomic, assign) float playTime;

@end

@implementation RecordPlayView

+ (instancetype)recordPlayViewWithPlayTime:(CGFloat)playTime andFrame:(CGRect)frame{
    RecordPlayView *playView = [[RecordPlayView alloc] initWithFrame:frame];
    playView.playTime = playTime;
    [[ZXRecoderVideoManager sharedRecoderManager] setPlayerDidFinshedBlock:^{
        [playView animationStop];
        playView.isPlaying = NO;
    }];
    [playView setSubViews];
    return playView;
}

- (void)setSubViews{
     __weak typeof(self)  weakself = self;
    CGFloat width = 0;
    if (self.playTime >= 10) {
        width = 124;
    }else if (self.playTime <= 2){
        width = 60;
    }else{
        width = 60 + self.playTime * 8;
    }
    [self addSubview:self.bgImageView];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.mas_right);
        make.centerY.equalTo(weakself.mas_centerY);
        make.height.equalTo(weakself.mas_height);
        make.width.mas_equalTo(width);
    }];
    [self.bgImageView addSubview:self.animationImageView];
    [self.animationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.bgImageView.mas_right).offset(-20);
        make.centerY.equalTo(weakself.bgImageView.mas_centerY);
    }];
    [self addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.bgImageView.mas_left).offset(-10);
        make.centerY.equalTo(weakself.mas_centerY);
    }];
}

- (void)setPlayTime:(float)playTime{
    _playTime = playTime;
    _timeLabel.text = [NSString stringWithFormat:@"\"%.1f",self.playTime];
}

- (void)animationFire{
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 1; i < 5; i ++) {
        NSString *imageName = [NSString stringWithFormat:@"wifi%zd",i];
        UIImage *image = [UIImage imageNamed:imageName];
        [images addObject:image];
    }
    self.animationImageView.animationImages = images;
    //动画重复次数
    self.animationImageView.animationRepeatCount=0;
    //动画执行时间,多长时间执行完动画
    self.animationImageView.animationDuration=1.0;
    //开始动画
    [self.animationImageView startAnimating];
}

- (void)animationStop{
    [self.animationImageView stopAnimating];
}

- (void)tapAction{
    if (self.isPlaying) {
        [ZXRecoderVideoManager stopPlay];
        [self animationStop];
    }else{
        NSData *data = [NSData dataWithContentsOfURL:[ZXRecoderVideoManager sharedRecoderManager].recordFileUrl];
        [ZXRecoderVideoManager playVideoWithData:data];
        [self animationFire];
    }
    self.isPlaying = !self.isPlaying;
}

#pragma mark - setter && getter

- (UIImageView *)bgImageView{
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNotStrechWithNamed:@"videoPlayBg"]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        _bgImageView.userInteractionEnabled = YES;
        [_bgImageView addGestureRecognizer:tap];
    }
    return _bgImageView;
}

- (UIImageView *)animationImageView{
    if (_animationImageView == nil) {
        _animationImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wifi4"]];
        _animationImageView.userInteractionEnabled = YES;
    }
    return _animationImageView;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = [NSString stringWithFormat:@"%.1f\"",self.playTime];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.textColor = [UIColor lightGrayColor];
    }
    return _timeLabel;
}



@end
