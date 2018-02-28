//
//  MainNavigationController.m
//  ZXProject
//
//  Created by Me on 2018/2/8.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "MainNavigationController.h"
#import "MainTabBarController.h"

@interface MainNavigationController ()

@end

@implementation MainNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];
    MainTabBarController *tabBar = (MainTabBarController *)self.tabBarController;
    [tabBar hideBottomBarWhenPush];
}


@end
