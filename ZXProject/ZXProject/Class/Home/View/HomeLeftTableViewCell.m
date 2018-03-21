//
//  HomeLeftTableViewCell.m
//  ZXProject
//
//  Created by Me on 2018/2/25.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "HomeLeftTableViewCell.h"
#import "GobHeaderFile.h"
#import <Masonry.h>

@interface HomeLeftTableViewCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation HomeLeftTableViewCell

+ (instancetype)homeLeftTableViewCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"HomeLeftTableViewCell";
    HomeLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[HomeLeftTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell setSubViews];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setSubViews{
    __weak typeof(self) weakself = self;
    [self addSubview:self.titleLabel];
    [self addSubview:self.bottomLine];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakself);
    }];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.mas_left);
        make.right.equalTo(weakself.mas_right);
        make.bottom.equalTo(weakself.mas_bottom);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark - setter && getter

- (void)setTitleColor:(UIColor *)titleColor{
    self.titleLabel.textColor = titleColor;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
    self.titleLabel.textColor = UIColorWithRGB(132, 132, 132);
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
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
