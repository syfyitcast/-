//
//  User.m
//  ZXProject
//
//  Created by Me on 2018/3/5.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "User.h"

@implementation User

//@property (nonatomic, copy) NSString *accountid;//账号id
//@property (nonatomic, copy) NSString *employerid;//职员id
//@property (nonatomic, copy) NSString *accid;//语音账号id
//@property (nonatomic, copy) NSString *acctoken;//语音token
//@property (nonatomic, copy) NSString *acctname;//语言账号名字
//@property (nonatomic, copy) NSString *projectids;//项目id
//@property (nonatomic, strong) NSArray *project_ids;
//@property (nonatomic, copy) NSString *employername;//职员姓名f
//@property (nonatomic, copy) NSString *loginname;//登录账号
//@property (nonatomic, copy) NSString *userrank;//职位
//@property (nonatomic, copy) NSString *photourl;//头像图片url
//@property (nonatomic, copy) NSString *mobileno;//手机号码
//@property (nonatomic, copy) NSString *workno;//工号
//@property (nonatomic, copy) NSString *companyname;//所属机构
//@property (nonatomic, copy) NSString *gender;//性别
//@property (nonatomic, copy) NSString *usertoken;//usertoken

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



@end
