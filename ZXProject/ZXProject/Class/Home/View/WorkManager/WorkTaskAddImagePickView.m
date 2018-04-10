//
//  WorkTaskAddImagePickView.m
//  ZXProject
//
//  Created by Me on 2018/3/7.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "WorkTaskAddImagePickView.h"
#import "GobHeaderFile.h"

#define PDDING 12
#define HEIGHT 71
#define WIDTH  ([UIScreen mainScreen].bounds.size.width - 5 * PDDING) / 4.0

@interface WorkTaskAddImagePickView()

@property (nonatomic, strong) NSMutableArray *imageViews;

@property (nonatomic, strong) UIImageView *tapImageView;
@property (nonatomic, assign) int currentCount;

@end

@implementation WorkTaskAddImagePickView

+ (instancetype)workTaskAddImagePickViewWithFrame:(CGRect)frame{
    WorkTaskAddImagePickView *view = [[WorkTaskAddImagePickView alloc] initWithFrame:frame];
    view.currentCount = 0;
    [view setSubViews];
    return view;
}

- (void)setSubViews{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"pickImageIcon"];
    imageView.userInteractionEnabled = YES;
    imageView.x = PDDING;
    imageView.size = imageView.image.size;
    imageView.y = (self.height - imageView.height) * 0.5;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImagePickView)];
    [imageView addGestureRecognizer:tap];
    self.tapImageView = imageView;
    [self addSubview:imageView];
    [self.imageViews addObject:imageView];
    
}

- (void)tapImagePickView{
    if (self.delegate && [self.delegate respondsToSelector:@selector(WorkTaskAddImagePickViewDidTapImageView)]) {
        [self.delegate WorkTaskAddImagePickViewDidTapImageView];
    }
}

- (void)getImage:(UIImage *)image{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    [self.images addObject:image];
    [self.imageViews addObject:imageView];
    self.currentCount ++;
    CGFloat x = PDDING + (self.currentCount - 1) * (WIDTH + PDDING);
    CGFloat height = HEIGHT;
    CGFloat y = (self.height - height) * 0.5;
    CGFloat width = WIDTH;
    imageView.frame = CGRectMake(x, y, width, height);
    [self addSubview:imageView];
    
    self.tapImageView.x = PDDING + self.currentCount * ( WIDTH + PDDING) ;
    self.tapImageView.height = height;
    self.tapImageView.width = height;
    self.tapImageView.y = (self.height - height) * 0.5;
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
