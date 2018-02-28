//
//  ManagerViewController.m
//  ZXProject
//
//  Created by Me on 2018/2/8.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "ManagerViewController.h"
#import "GobHeaderFile.h"

@interface ManagerViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.view.backgroundColor = UIColorWithRGB(240, 240, 240);
    self.navigationItem.leftBarButtonItem = nil;
}

#pragma mark setter && getter

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = UIColorWithRGB(115, 115, 115);
    }
    return _tableView;
}



@end
