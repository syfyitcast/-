//
//  UserManager.m
//  ZXProject
//
//  Created by Me on 2018/3/5.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "UserManager.h"
#import "NetworkConfig.h"

@implementation UserManager

+ (instancetype)sharedUserManager{
    static UserManager *intance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        intance = [[UserManager alloc] init];
    });
    return intance;
}

- (void)getUserInfomationWithDict:(NSDictionary *)dict{
    self.user = [User userWithDict:dict];
}


@end
