//
//  ProjectManager.m
//  ZXProject
//
//  Created by 刘清 on 2018/3/21.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "ProjectManager.h"

@implementation ProjectManager

+ (instancetype)sharedProjectManager{
    static ProjectManager *intance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        intance = [[ProjectManager alloc] init];
    });
    return intance;
}

- (void)setProjects:(NSArray *)projects{
    _projects = projects;
    ProjectModel *model = projects.firstObject;
    _currentProjectid = model.projectid;
}

@end
