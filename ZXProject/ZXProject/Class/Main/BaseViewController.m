//
//  BaseViewController.m
//  ZXProject
//
//  Created by Me on 2018/2/25.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "BaseViewController.h"
#import "GobHeaderFile.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavigationLeftItem];
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName:WhiteColor
                                                                      }];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NaviHeaderBg"] forBarMetrics:UIBarMetricsDefault];
    
}

- (void)setNavigationLeftItem{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navigationBack"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftItem)];
}

- (void)clickLeftItem{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
