//
//  LeaveView.h
//  ZXProject
//
//  Created by Me on 2018/3/2.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LeaveView;
@class FButton;

@protocol LeaveViewDelegate<NSObject>

@optional

- (void)leaveViewDidClickBtnIndex:(NSInteger)index andView:(UIView *)view andfbButton:(FButton *)btn;

@end

@interface LeaveView : UIView

@property (nonatomic, weak) id<LeaveViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextView *reasonTextView;
@property (nonatomic, strong) UITextField *timeField;

+ (instancetype)leaveView;

@end
