//
//  ReimbursementView.h
//  ZXProject
//
//  Created by 刘清 on 2018/3/26.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  FButton;
@class WorkTaskAddImagePickView;

@protocol ReimbursementViewDelegate<NSObject>

@optional

- (void)reimbursementViewDidClickBtnIndex:(NSInteger)index andView:(UIView *)view andfbButton:(FButton *)btn;

- (void)remibursementPickImage;

@end

@interface ReimbursementView : UIView

@property (nonatomic, weak) id <ReimbursementViewDelegate>delegate;
@property (nonatomic, strong) UITextField *payCountField;//报销金额
@property (weak, nonatomic) IBOutlet UITextView *resonTextView;



+ (instancetype)reimbursementView;

- (void)getPickImage:(UIImage *)image;

- (NSArray *)returnPickImages;

@end
