//
//  WorkFlowDraftViewController.m
//  ZXProject
//
//  Created by 刘清 on 2018/4/3.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "WorkFlowDraftViewController.h"
#import "LeaveView.h"
#import "EvectionView.h"
#import "ReimbursementView.h"
#import "ReportView.h"

@interface WorkFlowDraftViewController ()

@property (nonatomic, strong) UIView *currentView;

@end

@implementation WorkFlowDraftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的草稿";
    [self setSubView];
}

- (void)setSubView{
    if (self.model.flowtype == 1) {
        self.currentView = [LeaveView leaveView];
    }else if(self.model.flowtype == 2){
        self.currentView = [EvectionView evectionView];
    }else if (self.model.flowtype == 3){
        self.currentView = [ReimbursementView reimbursementView];
    }else if(self.model.flowtype == 4){
        self.currentView = [ReportView reportView];
    }
    self.currentView.frame = self.view.bounds;
    [self.view addSubview:self.currentView];
}


@end
