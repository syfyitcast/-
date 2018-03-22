//
//  UserManager.m
//  ZXProject
//
//  Created by Me on 2018/3/5.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "UserManager.h"
#import "NetworkConfig.h"

#define ACCESS_TOKENID @"userToken"

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
    [self saveAccessToken];
}

- (void)saveAccessToken{
    [[NSUserDefaults standardUserDefaults] setObject:self.user.usertoken forKey:ACCESS_TOKENID];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSString *saveFile = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"user.data"];
    [NSKeyedArchiver archiveRootObject:self.user toFile:saveFile];
}

- (BOOL)isAccessToken{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKENID]  isEqual: @""] || [[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKENID] == nil) {
        return NO;
    }else{
        return YES;
    }
}

- (BOOL)getAccessToken{
    NSString *file = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"user.data"];
    self.user = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
    if (self.user) {
        return YES;
    }else{
        return NO;
    }
}

- (void)deleteAccessToken{
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:ACCESS_TOKENID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
