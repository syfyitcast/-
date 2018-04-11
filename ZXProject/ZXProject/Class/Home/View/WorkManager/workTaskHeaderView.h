//
//  workTaskHeaderView.h
//  ZXProject
//
//  Created by 刘清 on 2018/4/10.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol workTaskHeaderViewDelegate<NSObject>

@optional

- (void)workTaskHeaderViewDidClickAtionWithTag:(int)tag;

- (void)workTaskHeaderViewDidTapImagePickView;

@end

@interface workTaskHeaderView : UIView

@property (nonatomic, weak) id<workTaskHeaderViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextView *textView;

+ (instancetype)workTaskViewWithImageUrls:(NSArray *)imageUrls andPositionAdress:(NSString *)positionAdress;

- (void)insertVideoPlayViewWithPlayTime:(float)playTime;

- (void)workTaskHeaderViewGetImage:(UIImage *)image;

- (NSArray *)workTaskHeaderViewGetPickImages;

@end
