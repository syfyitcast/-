//
//  WorkTaskAddImagePickView.m
//  ZXProject
//
//  Created by Me on 2018/3/7.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "WorkTaskAddImagePickView.h"
#import "GobHeaderFile.h"

@interface WorkTaskAddImagePickView()

@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) NSMutableArray *imageViews;

@property (nonatomic, strong) UIImageView *tapImageView;

@end

@implementation WorkTaskAddImagePickView

+ (instancetype)workTaskAddImagePickViewWithFrame:(CGRect)frame{
    WorkTaskAddImagePickView *view = [[WorkTaskAddImagePickView alloc] initWithFrame:frame];
    [view setSubViews];
    return view;
}

- (void)setSubViews{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"pickImageIcon"];
    imageView.x = 20;
    imageView.size = imageView.image.size;
    imageView.y = (self.height - imageView.height) * 0.5;
    self.tapImageView = imageView;
    [self addSubview:imageView];
    [self.imageViews addObject:imageView];
}

#pragma mark - setter && getter

- (NSMutableArray *)imageViews{
    if (_imageViews == nil) {
        _imageViews = [NSMutableArray array];
    }
    return _imageViews;
}

- (NSMutableArray *)images{
    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    return _images;
}


@end
