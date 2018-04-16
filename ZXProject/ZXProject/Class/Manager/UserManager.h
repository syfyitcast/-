//
//  UserManager.h
//  ZXProject
//
//  Created by Me on 2018/3/5.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface UserManager : NSObject

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSArray *orgUsers;

+ (instancetype)sharedUserManager;

- (void)getUserInfomationWithDict:(NSDictionary *)dict;

- (BOOL)getAccessToken;

- (BOOL)isAccessToken;

- (void)deleteAccessToken;

@end
