//
//  WorkFlowDetailFooterApprovView.h
//  ZXProject
//
//  Created by 刘清 on 2018/4/3.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkFlowApprovModel.h"
@class FButton;
@class WorkFlowDetailFooterApprovView;


@protocol WorkFlowApprovDetailViewDelegate<NSObject>

@optional

- (void) WorkFlowApprovDetailViewDidClickIndex:(int)index andBtn:(FButton *)btn andView:(WorkFlowDetailFooterApprovView *)view;


@end


@interface WorkFlowDetailFooterApprovView : UIView

@property (nonatomic, strong) NSArray *models;
@property (nonatomic, strong) WorkFlowApprovModel *currentModel;//当前审核流程
@property (nonatomic, strong) WorkFlowApprovModel *submitModel;//提交审核流程
@property (weak, nonatomic) IBOutlet UITextView *reasonTextView;

@property (nonatomic, weak) id<WorkFlowApprovDetailViewDelegate> delegate;

+ (instancetype)workFlowDetailFooterApprovView;

@end
