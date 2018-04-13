//
//  WorkTaskAddImagePickView.m
//  ZXProject
//
//  Created by Me on 2018/3/7.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "WorkTaskAddImagePickView.h"
#import "GobHeaderFile.h"
#import <UIImageView+WebCache.h>

#define PDDING 12
#define HEIGHT 71
#define WIDTH  ([UIScreen mainScreen].bounds.size.width - 5 * PDDING) / 4.0

@interface WorkTaskAddImagePickView()

@property (nonatomic, strong) NSMutableArray *imageViews;

@property (nonatomic, strong) UIImageView *tapImageView;
@property (nonatomic, assign) int currentCount;

@property (nonatomic, strong) NSArray *imageUrls;


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
    if (self.imageUrls.count != 0) {
        return;
    }
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

- (void)setImagesWithUrls:(NSArray *)urls{
    _imageUrls = urls;
    int i = 0;
    for (NSString *url in urls) {
        if (i == 0) {
            self.tapImageView.image = nil;
            [self.tapImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"sd_webimage_placeholderImage"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
                [self.tapImageView addGestureRecognizer:tap];
            }];
        }else{
            UIImageView *imageView = [[UIImageView alloc] init];
            CGFloat x = PDDING + i * (WIDTH + PDDING);
            CGFloat height = HEIGHT;
            CGFloat y = (self.height - height) * 0.5;
            CGFloat width = WIDTH;
            imageView.frame = CGRectMake(x, y, width, height);
            imageView.userInteractionEnabled = YES;
            [self addSubview:imageView];
            [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"sd_webimage_placeholderImage"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
                [imageView addGestureRecognizer:tap];
            }];
        }
        i ++;
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    UIImageView *myImageView = (UIImageView *)tap.view;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIButton *bigImageBgView = [[UIButton alloc] init];
    bigImageBgView.backgroundColor = [UIColor blackColor];
    bigImageBgView.frame = window.bounds;
    [bigImageBgView addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:myImageView.image];
    imageView.x = 0;
    imageView.y = 50;
    imageView.width = bigImageBgView.width;
    imageView.height = bigImageBgView.height - 100;
    [bigImageBgView addSubview:imageView];
    [window addSubview:bigImageBgView];
}

- (void)clickBtn:(UIButton *)btn{
    [btn removeFromSuperview];
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
