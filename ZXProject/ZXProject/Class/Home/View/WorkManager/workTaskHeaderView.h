//
//  workTaskHeaderView.h
//  ZXProject
//
//  Created by 刘清 on 2018/4/10.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkTaskModel.h"
#import "eventsMdoel.h"
@class workTaskHeaderView;

@protocol workTaskHeaderViewDelegate<NSObject>

@optional

- (void)workTaskHeaderViewDidClickAtionWithTag:(int)tag andView:(workTaskHeaderView *)view;

- (void)workTaskHeaderViewDidTapImagePickView;

@end

@interface workTaskHeaderView : UIView

@property (nonatomic, weak) id<workTaskHeaderViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, strong)  WorkTaskModel *model;
@property (nonatomic, strong)  eventsMdoel *eventModel;
@property (nonatomic, copy) NSString *positionAdress;
@property (nonatomic, assign) int type;


+ (instancetype)workTaskView;

- (void)insertVideoPlayViewWithPlayTime:(float)playTime;

- (void)workTaskHeaderViewGetImage:(UIImage *)image;

- (NSArray *)workTaskHeaderViewGetPickImages;

- (void)insetSoundViewWithUrl:(NSString *)url;


@end
