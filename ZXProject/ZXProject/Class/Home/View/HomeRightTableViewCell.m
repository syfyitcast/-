//
//  HomeRightTableViewCell.m
//  ZXProject
//
//  Created by Me on 2018/2/25.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "HomeRightTableViewCell.h"
#import "GobHeaderFile.h"
#import <Masonry.h>

@interface HomeRightTableViewCell()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation HomeRightTableViewCell

+ (instancetype)homeRightTableViewCellWithTable:(UITableView *)table{
    static NSString *ID = @"HomeRightTableViewCell";
    HomeRightTableViewCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[HomeRightTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (void)setSubViews{
    [self addSubview:self.iconView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.bottomLine];
    __weak typeof(self) weakself = self;
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.mas_centerY);
        make.left.equalTo(weakself.mas_left).offset(15);
        make.size.mas_equalTo(weakself.iconView.image.size);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.iconView.mas_right).offset(15);
        make.centerY.equalTo(weakself.mas_centerY);
    }];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.mas_left);
        make.right.equalTo(weakself.mas_right);
        make.bottom.equalTo(weakself.mas_bottom);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark - setter && getter

- (void)setItem:(HomeRightItems *)item{
    _item = item;
    self.iconView.image = [UIImage imageNamed:item.imageName];
    self.titleLabel.text = item.title;
    [self setSubViews];
}

- (UIImageView *)iconView{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = UIColorWithRGB(132, 132, 132);
        _titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    }
    return _titleLabel;
}

- (UIView *)bottomLine{
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = UIColorWithRGB(200, 200, 200);
    }
    return _bottomLine;
}



@end
