//
//  MainTabBar.m
//  ZXProject
//
//  Created by Me on 2018/2/18.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "MainTabBar.h"
#import "FButton.h"
#import "MainTabBarItem.h"
#import "GobHeaderFile.h"

@interface MainTabBar()

@property (nonatomic, strong) FButton *currentBtn;


@end

@implementation MainTabBar


+ (instancetype)mainTabBarWithItems:(NSArray *)items andFrame:(CGRect)frame{
    MainTabBar *bar = [[MainTabBar alloc] initWithFrame:frame];
    UIView *topLine = [[UIView alloc] init];
    topLine.backgroundColor = UIColorWithRGB(225, 225, 225);
    topLine.height = 0.3;
    topLine.x = 0;
    topLine.y = 0;
    topLine.width = bar.width;
    [bar addSubview:topLine];
    NSInteger index = items.count;
    CGFloat cWidth = 70;
    CGFloat width = (bar.width - cWidth) / index;
    FButton *cBtn = [FButton fbtnWithFBLayout:FBLayoutTypeImageFull andPadding:0];
    cBtn.ratio = 0.75;
    [cBtn setBackgroundImage:[UIImage imageNamed:@"cameraBg"] forState:UIControlStateNormal];
    [cBtn setImage:[UIImage imageNamed:@"camera"] forState:UIControlStateNormal];
    cBtn.width = cWidth;
    cBtn.height = cWidth;
    cBtn.x = 2 * width;
    cBtn.y = - 20;
    [bar addSubview:cBtn];
    bar.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i < index; i ++) {
        FButton *btn = [FButton fbtnWithFBLayout:FBLayoutTypeDownUp andPadding:5];
        btn.ratio = 0.8;
        MainTabBarItem *item = (MainTabBarItem *)items[i];
        [btn setTitle:item.title forState:UIControlStateNormal];
        [btn setImage:item.image forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setTitleColor:UIColorWithRGB(49, 49, 49) forState:UIControlStateNormal];
        btn.width = width;
        btn.height = 40;
        if (i <= 1) {
           btn.x = i * width;
        }else{
            btn.x =  i * width + cWidth;
        }
        btn.y = 8;
        btn.tag = i;
        [btn addTarget:bar action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [bar addSubview:btn];
        if (i == 0) {
            bar.currentBtn = btn;
            [btn setImage:[UIImage imageNamed:@"indexH_0"] forState:UIControlStateNormal];
            [btn setTitleColor:UIColorWithRGB(112, 196, 0) forState:UIControlStateNormal];
        }
    }
    return bar;
}

- (void)clickBtn:(FButton *)btn{
    if (btn == self.currentBtn)return;
    NSInteger index = btn.tag;
    UIImage *currentImage = [[UIImage imageNamed:[NSString stringWithFormat:@"index_%zd",self.currentBtn.tag]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.currentBtn setImage:currentImage forState:UIControlStateNormal];
    [self.currentBtn setTitleColor:UIColorWithRGB(49, 49, 49) forState:UIControlStateNormal];
    if (self.clickItemBlock) {
        self.clickItemBlock(index);
        self.currentBtn = btn;
        UIImage *currentImage = [[UIImage imageNamed:[NSString stringWithFormat:@"indexH_%zd",self.currentBtn.tag]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self.currentBtn setImage:currentImage forState:UIControlStateNormal];
        [self.currentBtn setTitleColor:UIColorWithRGB(112, 196, 0) forState:UIControlStateNormal];
    }
}

@end
