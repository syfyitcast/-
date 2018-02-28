//
//  MainTabBarItem.h
//  ZXProject
//
//  Created by Me on 2018/2/18.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MainTabBarItem : NSObject

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *title;

+ (instancetype)mainTabBarItemWithTitle:(NSString *)title andImage:(UIImage *)image;

@end
