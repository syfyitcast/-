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

static CGFloat ITEMSPACEING = 20;
static CGFloat LINESPACEING = 10;

@interface ZXCalendar()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) FButton *leftBtn;
@property (nonatomic, strong) FButton *rightBtn;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UICollectionView *contentView;
@property (nonatomic, strong) ZXCalendarManager *calendarManager;
@property (nonatomic, strong) NSArray *items;

@property (nonatomic, strong) ZXCalendarItem *currentItem;

@end

@implementation ZXCalendar

+ (instancetype)zx_CalendarWithFrame:(CGRect)frame{
    ZXCalendar *calendar = [[ZXCalendar alloc] initWithFrame:frame];
    [calendar initContentView];
    [calendar setSubViews];
    return calendar;
}

- (void)initContentView{
    CGFloat InteritemSpacing = ITEMSPACEING;
    CGFloat LineSpacing =  LINESPACEING;
    CGFloat itemWidth = (self.width - 6 * InteritemSpacing) / 7;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(itemWidth, itemWidth);
    layout.minimumInteritemSpacing = InteritemSpacing;
    layout.minimumLineSpacing = LineSpacing;
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
        make.left.equalTo(weakself.mas_left).offset(30 * kScreenRatioWidth);
        make.top.equalTo(weakself.mas_top);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.mas_right).offset(-30 * kScreenRatioWidth);
        make.top.equalTo(weakself.mas_top);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.leftBtn.mas_right).offset(10);
        make.right.equalTo(weakself.rightBtn.mas_left).offset(-10);
        make.centerY.equalTo(weakself.leftBtn.mas_centerY);
    }];
    CGFloat itemHeight = (self.width - 6 * ITEMSPACEING) / 7;
    CGFloat height = (self.items.count / 7) * (itemHeight + LINESPACEING);
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.mas_left);
        make.right.equalTo(weakself.mas_right);
        make.top.equalTo(weakself.timeLabel.mas_bottom).offset(30);
        make.height.mas_equalTo(height);
    }];
}

- (void)clickLeftBtn{
    self.items = [self.calendarManager lastMonthDataArr];
    [self.contentView reloadData];
    NSDate *date = [self.calendarManager preDate];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM月yyyy"];
    _timeLabel.text = [formatter stringFromDate:date];
    CGFloat height = (self.items.count / 7) * 40;
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
         make.height.mas_equalTo(height);
    }];
}

- (void)clickRightBtn{
    self.items = [self.calendarManager nextMonthDataArr];
    [self.contentView reloadData];
    NSDate *date = [self.calendarManager nextDate];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM月yyyy"];
    _timeLabel.text = [formatter stringFromDate:date];
    CGFloat height = (self.items.count / 7) * 40;
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item <7) {
        return;
    }
  
    ZXCalendarItem *item = self.items[indexPath.item];
    if (item == self.currentItem) {
        return;
    }
    item.isSelected = YES;
    self.currentItem.isSelected = NO;
    self.currentItem = item;
    [self.contentView reloadData];
    NSTimeInterval startTime = [self.calendarManager dayBeginTimeWithDay:item.day];
    NSTimeInterval endTime = [self.calendarManager dayEndTimeWithDay:item.day];
    if (self.delegate && [self.delegate respondsToSelector:@selector(calendarDelegateMethodWithStartTime:andEndTime:)]) {
        [self.delegate calendarDelegateMethodWithStartTime:startTime andEndTime:endTime];
    }
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
        for (ZXCalendarItem *item in _items) {
            if (item.isSelected == YES) {
                self.currentItem = item;
                break;
            }
        }
    }
    return _items;
}

- (FButton *)leftBtn{
    if (_leftBtn == nil) {
        _leftBtn = [FButton fbtnWithFBLayout:FBLayoutTypeImageFull andPadding:0];
        [_leftBtn setImage:[UIImage imageNamed:@"attenceDetailLeftBtn"]
                  forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(clickLeftBtn) forControlEvents:UIControlEventTouchUpInside];
        _leftBtn.ratio = 0.7;
    }
    return _leftBtn;
}

- (FButton *)rightBtn{
    if (_rightBtn == nil) {
        _rightBtn = [FButton fbtnWithFBLayout:FBLayoutTypeImageFull andPadding:0];
        [_rightBtn setImage:[UIImage imageNamed:@"attenceDetailRightBtn"] forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(clickRightBtn) forControlEvents:UIControlEventTouchUpInside];
        _rightBtn.ratio = 0.7;
    }
    return _rightBtn;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM月yyyy"];
        _timeLabel.text = [formatter stringFromDate:[NSDate date]];
        _timeLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
        _timeLabel.textColor = BlackColor;
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _timeLabel;
}

@end
