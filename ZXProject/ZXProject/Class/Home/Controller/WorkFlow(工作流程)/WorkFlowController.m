//
//  WorkFlowController.m
//  ZXProject
//
//  Created by Me on 2018/2/26.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "WorkFlowController.h"
#import "NotificationBar.h"
#import "GobHeaderFile.h"

@interface WorkFlowController ()

@property (nonatomic, strong) NotificationBar *topBar;

@end

@implementation WorkFlowController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"工作流程";
    [self setSubViews];
}

- (void)setSubViews{
    [self.view addSubview:self.topBar];
}

#pragma  mark - setter && getter

- (NotificationBar *)topBar{
    if (_topBar == nil) {
        CGRect frame = CGRectMake(0, 0, self.view.width, 50);
        _topBar = [NotificationBar notificationBarWithItems:@[@"请假",@"出差",@"报销",@"呈报"] andFrame:frame];
    }
    return _topBar;
}



@end
