//
//  ProjectManager.m
//  ZXProject
//
//  Created by 刘清 on 2018/3/21.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "ProjectManager.h"
#import "HttpClient.h"
#import "User.h"
#import "NOTIFICATION_HEADER.h"

@implementation ProjectManager

+ (instancetype)sharedProjectManager{
    static ProjectManager *intance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        intance = [[ProjectManager alloc] init];
    });
    return intance;
}

- (void)setCurrentModel:(ProjectModel *)currentModel{
    _currentModel = currentModel;
    self.currentProjectid = currentModel.projectid;
}

- (NSString *)currentProjectid{
    if (_currentProjectid == nil) {
        return @"";
    }else{
        return _currentProjectid;
    }
}

- (void)setProjectDetails:(NSArray *)projectDetails{
    _projectDetails = projectDetails;
    for (ProjectModel *model in projectDetails) {
        if ([self.currentModel.projectid isEqualToString:model.projectid]) {
            self.currentModel = model;
        }
    }
}

+ (void)getProjectList{
    [HttpClient zx_httpClientToGetProjectListWithProjectCode:@"" andProjectName:@"" andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
        if (code == 0) {
            NSArray *datas = data[@"projectList"];
            [ProjectManager sharedProjectManager].projects = [ProjectModel  projectModelsWithsource_arr:datas];
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFI_PROJECTLISTDONE object:nil];
            [HttpClient zx_httpClientToGetOrgContactListWithProjectid:[ProjectManager sharedProjectManager].currentModel.projectid andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
                if (code == 0) {
                    NSArray *datas = data[@"employer"];
                    [ProjectManager sharedProjectManager].orgContactlist = [User usersWithSource_arr:datas];
                };
            }];
        }
    }];
}


@end
