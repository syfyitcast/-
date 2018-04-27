//
//  MonitorSelectView.h
//  ZXProject
//
//  Created by 刘清 on 2018/4/25.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol monitorSelectViewDelegate<NSObject>

@optional

- (void)monitorSelectViewDidClickItem:(NSDictionary *)item;

@end

@interface MonitorSelectView : UIView

@property (nonatomic, weak) id<monitorSelectViewDelegate>delegate;

+ (instancetype)monitorSelectViewWithFrame:(CGRect)frame andItems:(NSArray *)items;

@end
