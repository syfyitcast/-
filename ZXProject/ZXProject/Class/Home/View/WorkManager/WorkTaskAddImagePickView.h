//
//  WorkTaskAddImagePickView.h
//  ZXProject
//
//  Created by Me on 2018/3/7.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WorkTaskAddImagePickViewDelegate<NSObject>

@optional

- (void)WorkTaskAddImagePickViewDidTapImageView;

@end

@interface WorkTaskAddImagePickView : UIView

@property (nonatomic, weak) id <WorkTaskAddImagePickViewDelegate>delegate;
@property (nonatomic, strong) NSMutableArray *images;

+ (instancetype)workTaskAddImagePickViewWithFrame:(CGRect)frame;

- (void)getImage:(UIImage *)image;

- (void)setImagesWithUrls:(NSArray *)urls;

@end
