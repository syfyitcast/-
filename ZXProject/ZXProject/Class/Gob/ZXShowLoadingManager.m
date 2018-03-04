//
//  ZXShowLoadingManager.m
//  ZXProject
//
//  Created by Me on 2018/2/25.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "ZXShowLoadingManager.h"
#import "GobHeaderFile.h"
#import "NSString+boundSize.h"

@interface ZXShowLoadingManager()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *inView;

@end

@implementation ZXShowLoadingManager

+ (instancetype)sharedShowLaodingManager{
    static ZXShowLoadingManager *intance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        intance = [[ZXShowLoadingManager alloc] init];
    });
    return intance;
}

- (void)showLoadingInView:(UIView *)view andText:(NSString *)text{
    CGFloat width = [text boudSizeWithFont:[UIFont systemFontOfSize:14] andMaxSize:CGSizeMake(200, MAXFLOAT)].width + 20;
    self.inView = view;
    UIView *bgView = [[UIView alloc] init];
    self.bgView = bgView;
    bgView.backgroundColor = [UIColor blackColor];
    bgView.layer.cornerRadius = 6;
    bgView.alpha = 0.75;
    bgView.width = width;
    bgView.height = width;
    UIImageView *wheelView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wheel"]];
    UIImageView *loadingView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading"]];
    bgView.x = ([UIApplication sharedApplication].keyWindow.width - bgView.width) * 0.5;
    bgView.y = ([UIApplication sharedApplication].keyWindow.height - bgView.height) * 0.5 - 32;
    wheelView.x = (bgView.width - wheelView.width) * 0.5;
    wheelView.y = (bgView.height - wheelView.height) * 0.5 - 10;
    loadingView.x = (bgView.width - loadingView.width) * 0.5;
    loadingView.y = (bgView.height - loadingView.height) * 0.5 - 10;
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = text;
    label.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    label.textColor = UIColorWithRGB(14 * 16, 14 * 16 , 14 * 16);
    label.width = bgView.width;
    label.height = 25;
    label.x = 0;
    label.y = CGRectGetMaxY(loadingView.frame) + 5;
    [bgView addSubview:loadingView];
    [view addSubview:bgView];
    [bgView addSubview:wheelView];
    [bgView addSubview:label];
    CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = @(0);
    animation.toValue =  @(M_PI * 2);
    animation.duration  = 0.85;
    animation.fillMode =kCAFillModeForwards;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    [loadingView.layer addAnimation:animation forKey:nil];
}

- (void)hideLoadingView{
    if (self.bgView) {
        [self.bgView removeFromSuperview];
        self.bgView = nil;
    }
}


@end
