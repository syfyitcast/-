//
//  WorkFlowDetailItemView.h
//  ZXProject
//
//  Created by 刘清 on 2018/4/2.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkFlowApprovModel.h"
@class WorkFlowDetailItemView;

@protocol WorkFlowApprovItemViewDelegate<NSObject>

@optional

- (void)workFlowApprovItemViewDidTapItem:(WorkFlowDetailItemView *)item;

@end

@interface WorkFlowDetailItemView : UIView

@property (nonatomic, strong) WorkFlowApprovModel *model;
@property (nonatomic, weak) id<WorkFlowApprovItemViewDelegate>delegate;
@property (nonatomic, assign) BOOL isFnished;
@property (nonatomic, assign) int index;

+ (instancetype)workFlowDetailItemView;

+ (instancetype)workFlowDetailEndItemView;

- (void)statusSelected;

@end
