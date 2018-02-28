//
//  FButton.m
//  ZXProject
//
//  Created by Me on 2018/2/8.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "FButton.h"
#import "UIView+Layout.h"

@interface FButton()

@property (nonatomic, assign) FBLayoutType layoutType;
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
            break;
        case FBLayoutTypeImageFull:
            [self fbLayoutImageFull];
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

+ (instancetype)fbtn{
    FButton *btn = [[FButton alloc] init];
    btn.layoutType = FBLayoutTypeNone;
    btn.ratio = 1;
    return btn;
}

+ (instancetype)fbtnWithFBLayout:(FBLayoutType)type andPadding:(CGFloat)padding{
    FButton *btn = [FButton fbtn];
    btn.layoutType = type;
    btn.padding = padding;
    return btn;
}

@end
