//
//  NotificationNewsCell.m
//  ZXProject
//
//  Created by Me on 2018/2/26.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "NotificationNewsCell.h"
#import "GobHeaderFile.h"
#import <Masonry.h>

@interface NotificationNewsCell()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titlelabel;
@property (nonatomic, strong) UILabel *desLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation NotificationNewsCell

+ (instancetype)notificationCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"NotificationNewsCell";
    NotificationNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NotificationNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell setSubViews];
    }
    return cell;
}

- (void)setSubViews{
    [self addSubview:self.iconView];
    [self addSubview:self.titlelabel];
    [self addSubview:self.desLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.bottomLine];
    __weak typeof(self) weakself = self;
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.mas_right).offset(-15);
        make.top.equalTo(weakself.mas_top).offset(10);
    }];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.mas_left).offset(15);
        make.centerY.equalTo(weakself.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(72.5, 55));
    }];
    [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.iconView.mas_right).offset(6);
        make.top.equalTo(weakself.timeLabel.mas_bottom);
        make.right.equalTo(weakself.mas_right).offset(-15);
        make.height.mas_equalTo(20);
    }];
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.iconView.mas_right).offset(6);
        make.top.equalTo(weakself.titlelabel.mas_bottom).offset(6);
    }];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.mas_left);
        make.right.equalTo(weakself.mas_right);
        make.bottom.equalTo(weakself.mas_bottom);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark - setter && getter

- (void)setModel:(NotificationNewsModel *)model{
    _model = model;
    self.iconView.image = [UIImage imageNamed:model.imageName];
    self.timeLabel.text = model.time;
    self.titlelabel.text = model.title;
    self.desLabel.text = model.des;
}

- (UIImageView *)iconView{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.textColor = UIColorWithRGB(146, 146, 146);
        _timeLabel.font = [UIFont systemFontOfSize:11];
    }
    return _timeLabel;
}

- (UILabel *)titlelabel{
    if (_titlelabel == nil) {
        _titlelabel = [[UILabel alloc] init];
        _titlelabel.textColor = UIColorWithRGB(49, 49, 49);
        _titlelabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    }
    return _titlelabel;
}

- (UILabel *)desLabel{
    if (_desLabel == nil) {
        _desLabel = [[UILabel alloc] init];
        _desLabel.textColor = UIColorWithRGB(146, 146, 146);
        _desLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
    }
    return _desLabel;
}

- (UIView *)bottomLine{
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = UIColorWithRGB(225, 225, 225);
    }
    return _bottomLine;
}

@end
