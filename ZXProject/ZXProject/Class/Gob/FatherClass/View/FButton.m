//
//  FButton.m
//  ZXProject
//
//  Created by Me on 2018/2/8.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "FButton.h"
#import "UIView+Layout.h"
#import "NSString+boundSize.h"
#import "GobHeaderFile.h"

@interface FButton()

@property (nonatomic, assign) FBLayoutType layoutType;
@property (nonatomic, strong) UILabel *badgeLabel;
@property (nonatomic, assign) CGFloat padding;

@end

@implementation FButton

- (void)layoutSubviews{
    [super layoutSubviews];
    switch (self.layoutType) {
        case FBLayoutTypeNone:
            return;
            break;
        case FBLayoutTypeTextFull:
            [self fbLayoutTypeTextFull];
            return;
        case FBLayoutTypeDownUp:
            [self fbLayoutTypeDownUp];
            self.badgeLabel.x = CGRectGetMaxX(self.imageView.frame) - self.badgeLabel.width * 0.5 - 2;
            self.badgeLabel.y = CGRectGetMinY(self.imageView.frame) - self.badgeLabel.height * 0.5 - 2;
            [self addSubview:self.badgeLabel];
            break;
        case FBLayoutTypeImageFull:
            [self fbLayoutImageFull];
            break;
        case FBLayoutTypeLeft:
            [self fbLayoutLeft];
            break;
        case FBLayoutTypeRight:
            [self fbLayoutRight];
            break;
        case FBLayoutTypeLeftRight:
            [self fbLayoutLeftRight];
            break;
        default:
            break;
    }
    
}

- (void)fbLayoutTypeDownUp{
    self.imageView.width = self.imageView.image.size.width * self.ratio;
    self.imageView.height = self.imageView.image.size.height * self.ratio;
    self.imageView.x = (self.width - self.imageView.image.size.width * self.ratio)*0.5;
    self.imageView.y = 0;
    self.titleLabel.x = 0;
    self.titleLabel.width = self.width;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame) + self.padding;
    self.titleLabel.height = self.height - self.imageView.height - self.padding;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)fbLayoutTypeTextFull{
    self.titleLabel.frame = self.bounds;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)fbLayoutImageFull{
    self.imageView.width = self.imageView.image.size.width * self.ratio;
    self.imageView.height = self.imageView.image.size.height * self.ratio;
    self.imageView.x = (self.width - self.imageView.width) * 0.5;
    self.imageView.y = (self.height - self.imageView.height) * 0.5;
}

- (void)fbLayoutLeft{
    
}

- (void)fbLayoutRight{
    CGFloat padding = self.padding;
    self.imageView.width = self.imageView.image.size.width * self.ratio;
    self.imageView.height = self.imageView.image.size.height * self.ratio;
    self.imageView.x = self.width - padding - self.imageView.width;
    self.imageView.y = (self.height - self.imageView.height) * 0.5;
    CGFloat width = [self.titleLabel.text boudSizeWithFont:self.titleLabel.font andMaxSize:CGSizeMake(self.width - self.imageView.width - padding, self.height)].width;
    self.titleLabel.width = width;
    self.titleLabel.height = self.height;
    self.titleLabel.x = self.imageView.x - padding - width;
    self.titleLabel.y = 0;
}

- (void)fbLayoutLeftRight{
    CGFloat padding = self.padding;
    self.imageView.width = self.imageView.image.size.width * self.ratio;
    self.imageView.height = self.imageView.image.size.height * self.ratio;
    self.imageView.x = self.width - padding - self.imageView.width;
    self.imageView.y = (self.height - self.imageView.height) * 0.5;
    CGFloat width = [self.titleLabel.text boudSizeWithFont:self.titleLabel.font andMaxSize:CGSizeMake(self.width - self.imageView.width - padding, self.height)].width;
    self.titleLabel.width = width;
    self.titleLabel.x = padding;
    self.titleLabel.height = self.height;
    self.titleLabel.y = 0;
    
}

+ (instancetype)fbtn{
    FButton *btn = [[FButton alloc] init];
    btn.layoutType = FBLayoutTypeNone;
    btn.ratio = 1;
    return btn;
}

+ (instancetype)fbtnWithFBLayout:(FBLayoutType)type andPadding:(CGFloat)padding{
    FButton *btn = [FButton fbtn];
    btn.badgeLabel.hidden = YES;
    btn.layoutType = type;
    btn.padding = padding;
    return btn;
}

#pragma mark - setter && getter

- (UILabel *)badgeLabel{
    if (_badgeLabel == nil) {
        _badgeLabel = [[UILabel alloc] init];
        _badgeLabel.backgroundColor =  UIColorWithRGB(255, 0, 0);
        _badgeLabel.textColor = WhiteColor;
        _badgeLabel.layer.cornerRadius = 7;
        _badgeLabel.clipsToBounds = YES;
        _badgeLabel.font = [UIFont systemFontOfSize:12];
        _badgeLabel.width = 14;
        _badgeLabel.height = 14;
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _badgeLabel;
}

- (void)setBagdeCount:(int)count{
    self.badgeLabel.text = [NSString stringWithFormat:@"%d",count];
    self.badgeLabel.hidden = NO;
}





@end
