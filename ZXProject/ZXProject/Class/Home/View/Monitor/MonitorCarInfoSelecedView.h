//
//  MonitorCarInfoSelecedView.h
//  ZXProject
//
//  Created by 刘清 on 2018/4/28.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MonitorCarInfoSelecedViewDelegate<NSObject>

@optional

- (void)monitorCarInfoSelecedViewDidClickBtn:(int)index;

@end

@interface MonitorCarInfoSelecedView : UIView

+ (instancetype)monitorCarInfoSelecedViewWithItems:(NSArray *)items andFrame:(CGRect)frame;

@property (nonatomic, weak) id <MonitorCarInfoSelecedViewDelegate>delegate;

@end
