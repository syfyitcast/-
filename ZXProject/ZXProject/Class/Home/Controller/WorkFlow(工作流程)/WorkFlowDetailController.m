//
//  WorkFlowDetailController.m
//  ZXProject
//
//  Created by 刘清 on 2018/3/29.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "WorkFlowDetailController.h"
#import <Masonry.h>

@interface WorkFlowDetailController ()



@end

@implementation WorkFlowDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"流程详情";
}

- (void)setSubViews{
     __weak typeof(self)  weakself = self;
    UIImageView *contentImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"approFlowRect"]];
    [contentImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
}


@end
