//
//  HomeHeaderView.h
//  ZXProject
//
//  Created by Me on 2018/2/18.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeHeaderViewDelegate<NSObject>

@optional

- (void)homeHeaderViewDidClickLeftBtn;
- (void)homeHeaderViewDidClickRightBtn;
- (void)homeHeadeerViewDidClickIconView;

@end

@interface HomeHeaderView : UIView

@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (nonatomic, weak) id<HomeHeaderViewDelegate> delegate;

+ (instancetype)homeHeaderView;

- (void)setProjectLabelName:(NSString *)projectName;

@end
