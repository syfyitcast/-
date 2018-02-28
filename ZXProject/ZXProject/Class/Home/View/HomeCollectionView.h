//
//  HomeCollectionView.h
//  ZXProject
//
//  Created by Me on 2018/2/20.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HomeCollectionViewDelegate<NSObject>

@optional

- (void)homeCollectionViewDidClickBtnIndex:(NSInteger)index;

@end

@interface HomeCollectionView : UIView


@property (nonatomic, weak) id<HomeCollectionViewDelegate> delegate;

+ (instancetype)HomeCollectionViewWithItems:(NSArray *)items andFrame:(CGRect)frame;

@end
