//
//  MainTabBar.h
//  ZXProject
//
//  Created by Me on 2018/2/18.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTabBar : UIView

@property (nonatomic, copy) void(^clickItemBlock)(NSInteger index);

+ (instancetype)mainTabBarWithItems:(NSArray *)items andFrame:(CGRect)frame;



@end
