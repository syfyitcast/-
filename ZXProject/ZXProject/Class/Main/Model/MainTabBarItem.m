//
//  MainTabBarItem.m
//  ZXProject
//
//  Created by Me on 2018/2/18.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "MainTabBarItem.h"



@implementation MainTabBarItem

+ (instancetype)mainTabBarItemWithTitle:(NSString *)title andImage:(UIImage *)image{
    MainTabBarItem *item = [[MainTabBarItem alloc] init];
    item.image = image;
    item.title = title;
    return item;
}

@end
