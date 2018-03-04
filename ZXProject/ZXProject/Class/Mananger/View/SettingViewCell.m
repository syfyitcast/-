//
//  SettingViewCell.m
//  ZXProject
//
//  Created by Me on 2018/3/2.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "SettingViewCell.h"
#import <Masonry.h>
#import "GobHeaderFile.h"

@interface SettingViewCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *rightView;
@property (nonatomic, strong) UIView *bottomLineView;

@end

@implementation SettingViewCell

+ (instancetype)settingViewCellWithTableView:(UITableView *)table{
    static NSString *ID = @"SettingViewCell";
    SettingViewCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SettingViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell setupSubViews];
    }
    return cell;
}

- (void)setupSubViews{
    self.bottomLineView.hidden = NO;
    [self addSubview:self.titleLabel];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.rightView];
    [self.contentView addSubview:self.bottomLineView];
    __weak typeof(self) weakself = self;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.mas_left).offset(15);
        make.centerY.equalTo(weakself.mas_centerY);
    }];
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.mas_right).offset(-15);
        make.centerY.equalTo(weakself.mas_centerY);
        make.size.mas_equalTo(weakself.rightView.image.size);
    }];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.mas_left);
        make.right.equalTo(weakself.mas_right);
        make.bottom.equalTo(weakself.mas_bottom);
        make.height.mas_equalTo(1);
    }];
}

- (void)hideBottomLine{
    self.bottomLineView.hidden = YES;
}

#pragma mark - setter && getter

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        _titleLabel.textColor = UIColorWithFloat(89);
    }
    return _titleLabel;
}

- (UIImageView *)rightView{
    if (_rightView == nil) {
        _rightView = [[UIImageView alloc] init];
        _rightView.image = [UIImage imageNamed:@"rightArrow"];
    }
    return _rightView;
}

- (UIView *)bottomLineView{
    if (_bottomLineView == nil) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = UIColorWithFloat(239);
    }
    return _bottomLineView;
}

@end
