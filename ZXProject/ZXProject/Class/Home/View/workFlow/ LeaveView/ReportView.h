//
//  ReportView.h
//  ZXProject
//
//  Created by 刘清 on 2018/3/26.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FButton;

@protocol ReportViewDelegate<NSObject>

@optional

- (void)reportViewDidClickBtnIndex:(NSInteger)index andView:(UIView *)view andfbButton:(FButton *)btn;

- (void)remibursementPickImage;

@end

@interface ReportView : UIView

@property (nonatomic, weak) id <ReportViewDelegate>delegate;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

+ (instancetype)reportView;

- (void)getPickImage:(UIImage *)image;

- (NSArray *)returnPickImages;

@end
