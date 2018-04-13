//
//  HomeCollectionView.m
//  ZXProject
//
//  Created by Me on 2018/2/20.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "HomeCollectionView.h"
#import "GobHeaderFile.h"
#import "APPNotificationManager.h"

static int row = 4;

@interface HomeCollectionView()

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSMutableArray *btns;

@end

@implementation HomeCollectionView

+ (instancetype)HomeCollectionViewWithItems:(NSArray *)items andFrame:(CGRect)frame{
    HomeCollectionView *view = [[HomeCollectionView alloc] initWithFrame:frame];
    [[NSNotificationCenter defaultCenter] addObserver:view selector:@selector(readCount) name:NOTIFI_READCOUNT object:nil];
    view.items = items;
    [view setSubviews];
    return view;
}

- (void)setSubviews{
    NSInteger index = self.items.count;
    CGFloat width = self.width / row;
    CGFloat height = 64;
    CGFloat padding = 30;
    NSArray *titles = @[@"通知公告",@"流程审批",@"考勤打卡",@"作业管理",@"环卫事件",@"巡查管理",@"设备管理",@"在线监控",@"项目总览",@"第三方",@"作业统计",@"全部"];
    for (int i = 0; i < index; i ++) {
        FButton *btn = [FButton fbtnWithFBLayout:FBLayoutTypeDownUp andPadding:10];
        NSString *title = titles[i];
        [btn setTitleColor:UIColorWithRGB(110, 110, 110) forState:UIControlStateNormal];
        btn.ratio = 0.7;
        btn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        [btn setTitle:title forState:UIControlStateNormal];
        NSString *imageName = [NSString stringWithFormat:@"Hcc_%zd",i];
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        btn.x = width * (i % row);
        btn.y = 15 + (height  + padding )* (i / row) ;
        btn.width = width;
        btn.height = height;
        btn.tag = i;
        if (i == 0) {
            if ([APPNotificationManager sharedAppNotificationManager].allReadCount != 0) {
                [btn setBagdeCount:[APPNotificationManager sharedAppNotificationManager].allReadCount];
            }
        }
        [self.btns addObject:btn];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        if (i / row != 0 && i % 4 == 0) {
            UIView *lineView = [[UIView alloc] init];
            lineView.backgroundColor = UIColorWithRGB(240,240,240);
            lineView.x = 0;
            lineView.y = 94 * (i / row);
            lineView.width = self.width;
            lineView.height = 1;
            [self addSubview:lineView];
        }
    }
}

- (void)clickBtn:(FButton *)btn{
    NSInteger index = btn.tag;
    if (self.delegate && [self.delegate respondsToSelector:@selector(homeCollectionViewDidClickBtnIndex:)]) {
        [self.delegate homeCollectionViewDidClickBtnIndex:index];
    }
}

- (void)readCount{
    FButton *btn = self.btns[0];
    if ([APPNotificationManager sharedAppNotificationManager].allReadCount != 0) {
        [btn setBagdeCount:[APPNotificationManager sharedAppNotificationManager].allReadCount];
    }
}

- (NSMutableArray *)btns{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

@end
