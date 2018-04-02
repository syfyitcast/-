//
//  WorkFlowDetailItemView.h
//  ZXProject
//
//  Created by 刘清 on 2018/4/2.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkFlowApprovModel.h"

@interface WorkFlowDetailItemView : UIView

@property (nonatomic, strong) WorkFlowApprovModel *model;

+ (instancetype)workFlowDetailItemView;



@end
