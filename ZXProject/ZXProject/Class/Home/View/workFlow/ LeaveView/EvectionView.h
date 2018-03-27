//
//  EvectionView.h
//  ZXProject
//
//  Created by 刘清 on 2018/3/26.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FButton;

@protocol EvectionViewDelegate<NSObject>

@optional

- (void)evectionViewDidClickBtnIndex:(NSInteger)index andView:(UIView *)view andfbButton:(FButton *)btn;


@end

@interface EvectionView : UIView

@property (nonatomic, weak) id <EvectionViewDelegate> delegate;


+ (instancetype)evectionView;

@end
