//
//  MainTabBarController.m
//  ZXProject
//
//  Created by Me on 2018/2/8.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "MainTabBarController.h"
#import "HomeViewController.h"
#import "ContactListController.h"
#import "WorkTeamController.h"
#import "ManagerViewController.h"
#import "MainNavigationController.h"
#import "MainTabBar.h"
#import "MainTabBarItem.h"
#import "GobHeaderFile.h"


@interface MainTabBarController ()

@property (nonatomic, strong) MainTabBar *myTabBar;

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setChidsViewController];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.myTabBar.x = 0;
    self.myTabBar.y = [UIScreen mainScreen].bounds.size.height - self.myTabBar.height;
    [self.view addSubview:self.myTabBar];
    self.tabBar.hidden = YES;
}

- (void)hideBottomBarWhenPush{
    self.myTabBar.hidden = YES;
}

- (void)showTabBar{
    self.myTabBar.hidden = NO;
}

- (void)setChidsViewController{//tabbar的创建子控制器
    NSArray *arr = @[@"HomeViewController",@"WorkTeamController",@"ContactListController",@"ManagerViewController"];
    for (NSString *name in arr) {
        MainNavigationController *nvc = [self creatNavigationControllerWithRootName:name];
        [self addChildViewController:nvc];
    }
    NSArray *titles = @[@"首页",@"工作群",@"通讯录",@"设置"];
    int i = 0;
    NSMutableArray *items = [NSMutableArray array];
    for (NSString *title in titles) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"index_%d",i]];
        MainTabBarItem *item = [MainTabBarItem mainTabBarItemWithTitle:title andImage: [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [items addObject:item];
        i ++;
    }
    CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 56);
    self.myTabBar = [MainTabBar mainTabBarWithItems:items andFrame:frame];
    __weak typeof(self) weakself = self;
    [self.myTabBar setClickItemBlock:^(NSInteger index) {
        weakself.selectedIndex = index;
    }];
}

- (MainNavigationController *)creatNavigationControllerWithRootName:(NSString *)name{
    Class class = NSClassFromString(name);
    UIViewController *vc = [[class alloc] init];
    MainNavigationController *nvc = [[MainNavigationController alloc] initWithRootViewController:vc];
    return nvc;
}


@end
