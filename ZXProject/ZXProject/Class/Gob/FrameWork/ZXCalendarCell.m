//
//  ZXCalendarCell.m
//  ZXProject
//
//  Created by Me on 2018/3/1.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "ZXCalendarCell.h"
#import "GobHeaderFile.h"
#import <Masonry.h>

@interface ZXCalendarCell()

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *typeImageView;

@end

@implementation ZXCalendarCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setSubViews];
    }
    return self;
}

- (void)setSubViews{
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.typeImageView];
    __weak typeof(self) weakself = self;
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.mas_left);
        make.right.equalTo(weakself.mas_right);
        make.top.equalTo(weakself.mas_top);
        make.height.mas_equalTo(20);
    }];
}

#pragma mark - setter && getter

- (void)setItem:(ZXCalendarItem *)item{
    _item = item;
    self.timeLabel.text = item.time;
    CGSize size = CGSizeZero;
    switch (item.type) {
        case ZXCalendarItemTypeNone:
            self.typeImageView.image = nil;
            self.timeLabel.textColor = UIColorWithRGB(49, 49, 49);
            break;
        case ZXCalendarItemTypePreMothRight:
            self.timeLabel.textColor = UIColorWithRGB(175, 175, 175);
            self.typeImageView.image = [UIImage imageNamed:@"attenceRight"];
            size = CGSizeMake(15, 11);
            break;
        case ZXCalendarItemTypeRight:
            self.timeLabel.textColor = UIColorWithRGB(49, 49, 49);
            self.typeImageView.image = [UIImage imageNamed:@"attenceRight"];
            size = CGSizeMake(15, 11);
            break;
        case ZXCalendarItemTypeToday:
            self.timeLabel.textColor = UIColorWithRGB(49, 49, 49);
            self.typeImageView.image = [UIImage imageNamed:@"attenceRight"];
            size = CGSizeMake(15, 11);
            self.backgroundColor = UIColorWithRGB(207, 246, 192);
            break;
        case ZXCalendarItemTypeWrong:
            self.timeLabel.textColor = UIColorWithRGB(49, 49, 49);
            self.typeImageView.image = [UIImage imageNamed:@"attenceWrong"];
            size = CGSizeMake(15, 15);
            break;
        case ZXCalendarItemTypePreMothWrong:
            self.timeLabel.textColor = UIColorWithRGB(175, 175, 175);
            self.typeImageView.image = [UIImage imageNamed:@"attenceWrong"];
            size = CGSizeMake(15, 15);
            break;
        case ZXCalendarItemTypeNextMoth:
            self.typeImageView.image = nil;
            self.timeLabel.textColor = UIColorWithRGB(175, 175, 175);
            break;
        default:
            break;
    }
    __weak typeof(self) weakself = self;
    [self.typeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.timeLabel);
        make.top.equalTo(weakself.timeLabel.mas_bottom).offset(-5);
        make.size.mas_equalTo(size);
    }];
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLabel;
}

- (UIImageView *)typeImageView{
    if (_typeImageView == nil) {
        _typeImageView = [[UIImageView alloc] init];
    }
    return _typeImageView;
}

@end
