//
//  CarWorkStatusViewController.m
//  ZXProject
//
//  Created by Me on 2018/5/7.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "CarWorkStatusViewController.h"
#import "CarWorkStatusView.h"

@interface CarWorkStatusViewController ()

@property (nonatomic, strong) CarWorkStatusView *statusView;

@end

@implementation CarWorkStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"工况";
    self.statusView.frame = self.view.bounds;
    [self.view addSubview:self.statusView];
}



#pragma mark - setter && getter

- (CarWorkStatusView *)statusView{
    if (_statusView == nil) {
        _statusView = [CarWorkStatusView carWorkStatusView];
        _statusView.modelDict = self.modelDict;
    }
    return _statusView;
}


@end
