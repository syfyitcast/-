//
//  WorkFlowDetailFooterView.h
//  ZXProject
//
//  Created by 刘清 on 2018/3/30.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkFlowApprovModel.h"

@interface WorkFlowDetailFooterView : UIView

+ (instancetype)workFlowDetailFooterView;

@property (nonatomic, strong) NSArray *models;
@property (nonatomic, assign) BOOL isFnished;

@property (nonatomic, strong) WorkFlowApprovModel *currentModel;//当前审核流程
@property (nonatomic, strong) WorkFlowApprovModel *submitModel;//提交审核流程

@end
