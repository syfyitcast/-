//
//  ZXCalendar.m
//  ZXProject
//
//  Created by Me on 2018/3/1.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "ZXCalendar.h"
#import "ZXCalendarCell.h"
#import "ZXCalendarManager.h"
#import "GobHeaderFile.h"
#import <Masonry.h>

#define ID @"ZXCalendarCell"

@interface ZXCalendar()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) FButton *leftBtn;
@property (nonatomic, strong) FButton *rightBtn;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UICollectionView *contentView;
@property (nonatomic, strong) ZXCalendarManager *calendarManager;
@property (nonatomic, strong) NSArray *items;

@end

@implementation ZXCalendar

+ (instancetype)zx_CalendarWithFrame:(CGRect)frame{
    ZXCalendar *calendar = [[ZXCalendar alloc] initWithFrame:frame];
    [calendar initContentView];
    [calendar setSubViews];
    return calendar;
}

- (void)initContentView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(30, 20);
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 20;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.contentView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.contentView.delegate = self;
    self.contentView.dataSource = self;
    self.contentView.scrollEnabled = NO;
    self.contentView.backgroundColor = WhiteColor;
    [self.contentView registerClass:[ZXCalendarCell class] forCellWithReuseIdentifier:ID];
}

- (void)setSubViews{
    [self addSubview:self.leftBtn];
    [self addSubview:self.rightBtn];
    [self addSubview:self.timeLabel];
    [self addSubview:self.contentView];
    __weak typeof(self) weakself = self;
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.mas_left).offset(90 * kScreenRatioWidth);
        make.top.equalTo(weakself.mas_top);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.mas_right).offset(-90 * kScreenRatioWidth);
        make.top.equalTo(weakself.mas_top);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.leftBtn.mas_right).offset(10);
        make.right.equalTo(weakself.rightBtn.mas_left).offset(-10);
        make.centerY.equalTo(weakself.leftBtn.mas_centerY);
    }];
    CGFloat height = (self.items.count / 7) * 40;
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.mas_left).offset(50 * kScreenRatioWidth);
        make.right.equalTo(weakself.mas_right).offset(-50 * kScreenRatioWidth);
        make.top.equalTo(weakself.timeLabel.mas_bottom).offset(30);
        make.height.mas_equalTo(height);
    }];
    
    
}

#pragma mark - UICollectionViewDataSource &&Deleagte

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZXCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.item = self.items[indexPath.item];
    return cell;
}

#pragma mark - setter && getter

- (ZXCalendarManager *)calendarManager{
    if (_calendarManager == nil) {
        _calendarManager = [[ZXCalendarManager alloc] init];
    }
    
    return _calendarManager;
}

- (NSArray *)items{
    if (_items == nil) {
        _items = [self.calendarManager zx_CalendarItemsWithDate:[NSDate date]];
    }
    return _items;
}

- (FButton *)leftBtn{
    if (_leftBtn == nil) {
        _leftBtn = [FButton fbtnWithFBLayout:FBLayoutTypeImageFull andPadding:0];
        [_leftBtn setImage:[UIImage imageNamed:@"attenceDetailLeftBtn"]
                  forState:UIControlStateNormal];
        _leftBtn.ratio = 0.7;
    }
    return _leftBtn;
}

- (FButton *)rightBtn{
    if (_rightBtn == nil) {
        _rightBtn = [FButton fbtnWithFBLayout:FBLayoutTypeImageFull andPadding:0];
        [_rightBtn setImage:[UIImage imageNamed:@"attenceDetailRightBtn"] forState:UIControlStateNormal];
        _rightBtn.ratio = 0.7;
    }
    return _rightBtn;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"2018年3月";
        _timeLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
        _timeLabel.textColor = UIColorWithRGB(108, 213, 58);
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _timeLabel;
}

@end
