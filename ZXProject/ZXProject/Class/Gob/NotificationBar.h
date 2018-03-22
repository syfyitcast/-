//
//  NotificationBar.h
//  ZXProject
//
//  Created by Me on 2018/2/26.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NotificationBarDelegate<NSObject>

@optional

- (void)notificationBarDidTapIndexLabel:(NSInteger)index;


@end

@interface NotificationBar : UIView

@property (nonatomic, weak) id<NotificationBarDelegate> delegate;

+ (instancetype)notificationBarWithItems:(NSArray *)items andFrame:(CGRect)frame;

- (void)bottomLineMoveWithRatio:(CGFloat)ratio;

- (void)bottomLineMoveWithIndex:(int)index;

- (void)setBadgeAtIndex:(NSInteger)index withCount:(NSInteger)count;

@end
