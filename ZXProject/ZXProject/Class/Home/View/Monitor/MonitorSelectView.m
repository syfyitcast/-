//
//  MonitorSelectView.m
//  ZXProject
//
//  Created by 刘清 on 2018/4/25.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "MonitorSelectView.h"
#import "GobHeaderFile.h"

@interface MonitorSelectView()

@property (nonatomic, strong) NSArray *items;



@end

@implementation MonitorSelectView

+ (instancetype)monitorSelectViewWithFrame:(CGRect)frame andItems:(NSArray *)items{
    MonitorSelectView *view = [[MonitorSelectView alloc] initWithFrame:frame];
    view.items = items;
    [view setSubViews];
    return view;
}

- (void)setSubViews{
    int i = 0;
    CGFloat width = self.width / self.items.count ;
    for (NSDictionary *dict in self.items) {
        if (i == 0) {
            NSString *imageName = dict[@"imageName"];
            FButton *btn = [FButton fbtnWithFBLayout:FBLayoutTypeImageFull andPadding:0];
            [btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            btn.x = i * width + 30;
            btn.y = 0;
            btn.tag = i;
            btn.width = width - 30;
            btn.height = self.height;
            [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventAllEvents];
            btn.backgroundColor = WhiteColor;
            [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            [self addSubview:btn];
        }else{
            UIView *lineView = [[UIView alloc] init];
            lineView.backgroundColor = WhiteColor;
            lineView.x = i * width;
            lineView.y = 0;
            lineView.width = 1;
            lineView.height = self.height;
            [self addSubview:lineView];
            NSString *title = dict[@"title"];
            NSString *imageName = dict[@"imageName"];
            FButton *btn = [FButton fbtnWithFBLayout:FBLayoutTypeRightLeft andPadding:3];
            [btn setTitle:title forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateSelected];
            btn.x = i * width + 1;
            btn.y = 0;
            btn.tag = i;
            btn.width = width - 1;
            btn.height = self.height;
            [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventAllEvents];
            [self addSubview:btn];
            btn.backgroundColor = UIColorWithFloat(139);
        }
        i ++;
    }
}

- (void)clickBtn:(UIButton *)btn{
    if (btn.tag != 0) {
        btn.selected  = !btn.selected;
        if (btn.selected) {
            btn.backgroundColor = BTNBackgroudColor;
        }else{
            btn.backgroundColor = UIColorWithFloat(139);
        }
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(monitorSelectViewDidClickItem:)]) {
        [self.delegate monitorSelectViewDidClickItem:self.items[btn.tag]];
    }
}

@end
