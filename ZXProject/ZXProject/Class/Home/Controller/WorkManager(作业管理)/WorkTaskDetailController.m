//
//  WorkTaskDetailController.m
//  ZXProject
//
//  Created by Me on 2018/3/9.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "WorkTaskDetailController.h"
#import "WorkTaskAddImagePickView.h"
#import "GobHeaderFile.h"


@interface WorkTaskDetailController ()

@property (nonatomic, strong) WorkTaskAddImagePickView *pickView;

@end

@implementation WorkTaskDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情";
}

#pragma mark - setter && getter

- (WorkTaskAddImagePickView *)pickView{
    if (_pickView == nil) {
        _pickView = [WorkTaskAddImagePickView workTaskAddImagePickViewWithFrame:CGRectMake(0, 0, self.view.width, 100)];
    }
    return _pickView;
}

@end
