//
//  ProjectModel.m
//  ZXProject
//
//  Created by 刘清 on 2018/3/21.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "ProjectModel.h"
#import "UserManager.h"
#import "ProjectManager.h"

@implementation ProjectModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{};

+ (instancetype)projectsWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

+ (NSArray *)projectModelsWithsource_arr:(NSArray *)source_arr{
    NSMutableArray *tem_arr = [NSMutableArray array];
    for (NSDictionary *dic in source_arr) {
        ProjectModel *model = [ProjectModel projectsWithDict:dic];
        for (NSString *projectid in [UserManager sharedUserManager].user.allProjects) {
            if ([model.projectid isEqualToString:projectid]) {
                [tem_arr addObject:model];
            }
        }
        if ([model.projectid isEqualToString:[UserManager sharedUserManager].user.allProjects.lastObject]) {
            [ProjectManager sharedProjectManager].currentModel = model;
        }
    }
    return tem_arr.mutableCopy;
}

@end
