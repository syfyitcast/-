//
//  ProjectManager.h
//  ZXProject
//
//  Created by 刘清 on 2018/3/21.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProjectModel.h"
#import "ProjectModel.h"

@interface ProjectManager : NSObject

@property (nonatomic, strong) NSArray *projects;
@property (nonatomic, strong) NSArray *projectDetails;
@property (nonatomic, copy) NSString *currentProjectid;
@property (nonatomic, strong) ProjectModel *currentModel;


+ (instancetype)sharedProjectManager;



@end
