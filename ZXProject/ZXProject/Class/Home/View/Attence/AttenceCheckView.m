//
//  AttenceCheckView.m
//  ZXProject
//
//  Created by Me on 2018/4/6.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "AttenceCheckView.h"
#import <Masonry.h>
#import "GobHeaderFile.h"

@interface AttenceCheckView()

@property (weak, nonatomic) IBOutlet UILabel *workLabel;
@property (weak, nonatomic) IBOutlet UILabel *offLabel;
@property (weak, nonatomic) IBOutlet UIView *iconBgView;

@property (nonatomic, strong) UILabel *beginTimeLabel;
@property (nonatomic, strong) UILabel *settingNameLabel;
@property (nonatomic, strong) UILabel *endTimeLabel;

@end

@implementation AttenceCheckView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconBgView.layer.cornerRadius = 25;
    self.iconBgView.layer.borderColor = UIColorWithFloat(239).CGColor;
    self.iconBgView.layer.borderWidth = 1;
    [self addSubview:self.beginTimeLabel];
    [self addSubview:self.settingNameLabel];
    [self addSubview:self.endTimeLabel];
}

+ (instancetype)attenceCheckCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"AttenceCheckView";
    AttenceCheckView *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"AttenceCheckView" owner:nil options:nil].lastObject;
    }
    return cell;
}

- (void)setModel:(AttDutyCheckModel *)model{
    _model = model;
    self.settingNameLabel.text = model.settingname;
    __weak typeof(self) weakself = self;
    if (model.begintime != 0) {
        self.beginTimeLabel.hidden = NO;
        self.beginTimeLabel.text = model.beginTimeString;
        [self.beginTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakself.workLabel.mas_right).offset(25);
            make.centerY.equalTo(weakself.workLabel.mas_centerY);
        }];
    }else{
        self.beginTimeLabel.hidden = YES;
    }
    [self.settingNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.mas_right).offset(-60);
        make.centerY.equalTo(weakself.workLabel.mas_centerY);
        make.width.mas_equalTo(110);
    }];
    if (model.endtime != 0) {
        self.endTimeLabel.hidden = NO;
        self.endTimeLabel.text = model.endTimeString;
        [self.endTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakself.offLabel.mas_right).offset(25);
            make.centerY.equalTo(weakself.offLabel.mas_centerY);
        }];
    }else{
        self.endTimeLabel.hidden = YES;
    }
    
}

#pragma mark - setter && getter

- (UILabel *)beginTimeLabel{
    if (_beginTimeLabel == nil) {
        _beginTimeLabel = [[UILabel alloc] init];
        _beginTimeLabel.font = [UIFont systemFontOfSize:15];
        _beginTimeLabel.textColor = [UIColor blackColor];
        _beginTimeLabel.textAlignment = NSTextAlignmentCenter;
        _beginTimeLabel.hidden = YES;
    }
    return _beginTimeLabel;
}

- (UILabel *)settingNameLabel{
    if (_settingNameLabel == nil) {
        _settingNameLabel = [[UILabel alloc] init];
        _settingNameLabel.font = [UIFont systemFontOfSize:10];
        _settingNameLabel.textColor = WhiteColor;
        _settingNameLabel.backgroundColor = UIColorWithFloat(199);
        _settingNameLabel.textAlignment = NSTextAlignmentCenter;
        _settingNameLabel.layer.cornerRadius = 6;
        _settingNameLabel.clipsToBounds = YES;
    }
    return _settingNameLabel;
}

- (UILabel *)endTimeLabel{
    if (_endTimeLabel == nil) {
        _endTimeLabel = [[UILabel alloc] init];
        _endTimeLabel.font = [UIFont systemFontOfSize:15];
        _endTimeLabel.textColor = [UIColor blackColor];
        _endTimeLabel.textAlignment = NSTextAlignmentCenter;
        _endTimeLabel.hidden = YES;
    }
    return _endTimeLabel;
}

@end
