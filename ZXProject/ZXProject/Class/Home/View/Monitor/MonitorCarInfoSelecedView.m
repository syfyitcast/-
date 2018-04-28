//
//  MonitorCarInfoSelecedView.m
//  ZXProject
//
//  Created by 刘清 on 2018/4/28.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "MonitorCarInfoSelecedView.h"
#import "GobHeaderFile.h"

@interface MonitorCarInfoSelecedView()

@property (nonatomic, strong) NSArray *items;

@end

@implementation MonitorCarInfoSelecedView

+ (instancetype)monitorCarInfoSelecedViewWithItems:(NSArray *)items andFrame:(CGRect)frame{
    MonitorCarInfoSelecedView *view = [[MonitorCarInfoSelecedView alloc] initWithFrame:frame];
    view.layer.cornerRadius = view.height * 0.5;
    view.layer.borderColor = BTNBackgroudColor.CGColor;
    view.layer.borderWidth = 1;
    [view setupSubViews];
    return view;
}

- (void)setupSubViews{
    int i = 0;
    CGFloat width = self.width / self.items.count;
    for (NSString *itemName in self.items) {
        UIButton *btn = [[UIButton alloc] init];
        btn.backgroundColor = WhiteColor;
        [btn setTitle:itemName forState:UIControlStateNormal];
        [btn setTitleColor:BTNBackgroudColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.x = i * width - 1;
        btn.y = 0;
        btn.width = width - 1;
        btn.height = self.height;
        [self addSubview:btn];
        if (i != self.items.count - 1) {
            UIView *lineView = [[UIView alloc] init];
            lineView.backgroundColor = BTNBackgroudColor;
            lineView.x = i * width;
            lineView.y = 2;
            lineView.width = 1;
            lineView.height = self.height - 4;
            [self addSubview:lineView];
        }
    }
}

@end
