//
//  NotificationBar.m
//  ZXProject
//
//  Created by Me on 2018/2/26.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "NotificationBar.h"
#import "GobHeaderFile.h"

@interface NotificationBar()

@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UIView *bttomGrayLine;
@property (nonatomic, strong) NSArray *items;

@property (nonatomic, strong) UIScrollView *myScrollView;

@end

@implementation NotificationBar

+ (instancetype)notificationBarWithItems:(NSArray *)items andFrame:(CGRect)frame{
    NotificationBar *bar = [[NotificationBar alloc] initWithFrame:frame];
    bar.items = items;
    [bar setSubViews];
    return bar;
}

- (void)setSubViews{
    CGFloat width = self.width / self.items.count;
    for (int i = 0; i < self.items.count; i ++) {
        UILabel *label = [[UILabel alloc] init];
        label.text = self.items[i];
        label.font = [UIFont systemFontOfSize:15 weight:UIFontWeightBold];
        label.textColor = UIColorWithRGB(51, 51, 51);
        label.x = i * width;
        label.y = 0;
        label.height = self.height;
        label.width = width;
        label.tag = i;
        label.textAlignment = NSTextAlignmentCenter;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLabelAction:)];
        [label addGestureRecognizer:tap];
        label.userInteractionEnabled = YES;
        [self addSubview:label];
    }
    self.bttomGrayLine.x = 0;
    self.bttomGrayLine.height = 1;
    self.bttomGrayLine.width = self.width;
    self.bttomGrayLine.y = self.height - self.bttomGrayLine.height;
    [self addSubview:self.bttomGrayLine];
    self.bottomLine.x = 0;
    self.bottomLine.height = 2;
    self.bottomLine.width = width;
    self.bottomLine.y = self.height - self.bottomLine.height;
    [self addSubview:self.bottomLine];
}

- (void)tapLabelAction:(UITapGestureRecognizer *)tap{
    long index = tap.view.tag;
    if (self.delegate && [self.delegate respondsToSelector:@selector(notificationBarDidTapIndexLabel:)]) {
        [self.delegate notificationBarDidTapIndexLabel:index];
    }
    [UIView animateWithDuration:0.35 animations:^{
        self.bottomLine.x = index * (self.width / self.items.count);
    }];
}

- (void)bottomLineMoveWithRatio:(CGFloat)ratio{
    self.bottomLine.x = self.width * ratio;
}

- (void)bottomLineMoveWithIndex:(int)index{
    [UIView animateWithDuration:0.35 animations:^{
        self.bottomLine.x = index * self.bottomLine.width;
    }];
}

#pragma mark - setter && getter

- (UIView *)bottomLine{
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = UIColorWithRGB(70, 200, 70);
    }
    return _bottomLine;
}

- (UIView *)bttomGrayLine{
    if (_bttomGrayLine == nil) {
        _bttomGrayLine = [[UIView alloc] init];
        _bttomGrayLine.backgroundColor = UIColorWithRGB(215, 215, 215);
    }
    return _bttomGrayLine;
}

@end
