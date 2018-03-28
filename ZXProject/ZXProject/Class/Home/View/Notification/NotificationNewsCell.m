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
@property (nonatomic, strong) UIView *badgeView;
@property (nonatomic, strong) FButton *readBtn;

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
    [self addSubview:self.readBtn];
    [self addSubview:self.desLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.bottomLine];
    [self addSubview:self.badgeView];
    __weak typeof(self) weakself = self;
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.mas_right).offset(-15);
        make.top.equalTo(weakself.mas_top).offset(10);
    }];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.mas_left).offset(15);
        make.centerY.equalTo(weakself.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.iconView.mas_right).offset(6);
        make.top.equalTo(weakself.timeLabel.mas_bottom);
        make.right.equalTo(weakself.mas_right).offset(-100);
        make.height.mas_equalTo(15);
    }];
    [self.readBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.mas_right).offset(-20);
        make.top.equalTo(weakself.timeLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.iconView.mas_right).offset(6);
        make.right.equalTo(weakself.mas_right).offset(-100);
        make.top.equalTo(weakself.titlelabel.mas_bottom).offset(6);
    }];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.mas_left);
        make.right.equalTo(weakself.mas_right);
        make.bottom.equalTo(weakself.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    [self.badgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.iconView.mas_left);
        make.bottom.equalTo(weakself.iconView.mas_top).offset(5);
        make.size.mas_equalTo(CGSizeMake(6, 6));
    }];
}

- (void)clickReadDetailAction{
    
}

#pragma mark - setter && getter

- (void)setModel:(NotificationModel *)model{
    _model = model;
    self.timeLabel.text = model.createtime;
    self.desLabel.text = model.title;
    if (model.notificationType == 0) {
        self.titlelabel.text = @"中联重科通知";
    }else if (model.notificationType == 1){
        self.titlelabel.text = @"项目通知";
    }else if (model.notificationType == 2){
        self.titlelabel.text = @"新闻通知";
    }
    self.badgeView.hidden = model.readstatus;
    if (model.readstatus) {
        self.titlelabel.textColor = UIColorWithFloat(189);
        self.desLabel.textColor = UIColorWithFloat(189);
    }else{
        self.titlelabel.textColor = BlackColor;
        self.desLabel.textColor = UIColorWithFloat(146);
    }
}

- (void)setCellType:(int)cellType{
    _cellType = cellType;
    if (cellType == 0) {
        self.iconView.image = [UIImage imageNamed:@"notificationIcon"];
    }else if (cellType == 1){
        self.iconView.image = [UIImage imageNamed:@"NotificationXmIcon"];
    }else if (cellType == 2){
        self.iconView.image = [UIImage imageNamed:@"NotificationNewsIcon"];
    }
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

- (UIView *)badgeView{
    if (_badgeView == nil) {
        _badgeView = [[UIView alloc] init];
        _badgeView.backgroundColor = UIColorWithRGB(255, 0, 0);
        _badgeView.layer.cornerRadius = 3;
    }
    return _badgeView;
}

- (FButton *)readBtn{
    if (_readBtn == nil) {
        _readBtn = [FButton fbtnWithFBLayout:FBLayoutTypeTextFull andPadding:0];
        [_readBtn setTitle:@"阅读详情" forState:UIControlStateNormal];
        _readBtn.backgroundColor = BTNBackgroudColor;
        _readBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        _readBtn.layer.cornerRadius = 4;
        [_readBtn addTarget:self action:@selector(clickReadDetailAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _readBtn;
}

@end
