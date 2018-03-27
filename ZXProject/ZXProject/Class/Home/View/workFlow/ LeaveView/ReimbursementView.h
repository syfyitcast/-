//
//  ReimbursementView.h
//  ZXProject
//
//  Created by 刘清 on 2018/3/26.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  FButton;

@protocol ReimbursementViewDelegate<NSObject>

@optional

- (void)reimbursementViewDidClickBtnIndex:(NSInteger)index andView:(UIView *)view andfbButton:(FButton *)btn;

@end

@interface ReimbursementView : UIView

@property (nonatomic, weak) id <ReimbursementViewDelegate>delegate;

+ (instancetype)reimbursementView;

@end
