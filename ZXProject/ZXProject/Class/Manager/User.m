//
//  User.m
//  ZXProject
//
//  Created by Me on 2018/3/5.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "User.h"
#import "NetworkConfig.h"

@implementation User

- (id)initWithCoder:aDecoder{
    if ([super init]) {
        self.accountid = [aDecoder decodeObjectForKey:@"accountid"];
        self.employerid = [aDecoder decodeObjectForKey:@"employerid"];
        self.accid = [aDecoder decodeObjectForKey:@"accid"];
        self.acctoken = [aDecoder decodeObjectForKey:@"acctoken"];
        self.acctname= [aDecoder decodeObjectForKey:@"acctname"];
        self.projectids = [aDecoder decodeObjectForKey:@"projectids"];
        self.employername = [aDecoder decodeObjectForKey:@"employername"];
        self.loginname = [aDecoder decodeObjectForKey:@"loginname"];
        self.userrank = [aDecoder decodeObjectForKey:@"userrank"];
        self.photourl = [aDecoder decodeObjectForKey:@"photourl"];
        self.mobileno = [aDecoder  decodeObjectForKey:@"mobileno"];
        self.workno = [aDecoder decodeObjectForKey:@"workno"];
        self.companyname = [aDecoder decodeObjectForKey:@"companyname"];
        self.gender = [aDecoder decodeObjectForKey:@"gender"];
        self.usertoken = [aDecoder decodeObjectForKey:@"usertoken"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.accountid forKey:@"accountid"];
    [aCoder encodeObject:self.employerid forKey:@"employerid"];
    [aCoder encodeObject:self.accid forKey:@"accid"];
    [aCoder encodeObject:self.acctname forKey:@"acctname"];
    [aCoder encodeObject:self.projectids forKey:@"projectids"];
    [aCoder encodeObject:self.employername forKey:@"employername"];
    [aCoder encodeObject:self.loginname forKey:@"loginname"];
    [aCoder encodeObject:self.userrank forKey:@"userrank"];
    [aCoder encodeObject:self.photourl forKey:@"photourl"];
    [aCoder encodeObject:self.mobileno forKey:@"mobileno"];
    [aCoder encodeObject:self.workno forKey:@"workno"];
    [aCoder encodeObject:self.companyname forKey:@"companyname"];
    [aCoder encodeObject:self.gender forKey:@"gender"];
    [aCoder encodeObject:self.usertoken forKey:@"usertoken"];
}

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self  setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{};

+ (instancetype)userWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

- (void)setProjectids:(NSString *)projectids{
    _projectids = projectids;
    self.allProjects = [projectids componentsSeparatedByString:@"|"];
    if (self.allProjects == nil || self.allProjects.count == 0) {
        self.allProjects = @[projectids];
    }
}

- (void)setPhotourl:(NSString *)photourl{
    _photourl = [[NetworkConfig sharedNetworkingConfig].ipUrl stringByAppendingString:photourl];
}


@end
